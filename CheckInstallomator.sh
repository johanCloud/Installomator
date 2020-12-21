#!/bin/zsh

# Check Installomator labels
# 2020 Søren Theilgaard (@theilgaard)

# This script will test labels and check if download link is active, and if version is defined.
# If labels are written to the script only those will be tested.
# If none are provided, it will test all labels.
# https://github.com/theile/Installomator

# To check this script use these labels:
# dbeaverce brave microsoftteams whatsapp citrixworkspace aircall

# MARK: Load the labels
SELF=$(basename $0)
SELFLOCATION=$(dirname $0)
labelFile="${SELFLOCATION}/InstallomatorLabels.sh"
source "${labelFile}"
if [ $? != 0 ]; then; echo "Label-file is missing, expected here: ${labelFile}"; exit $?; fi

echo "Script: $SELFLOCATION/$SELF"
echo "LabalFile: $labelFile"

${SELFLOCATION}/Installomator.sh longversion
echo

# MARK: check minimal macOS requirement
autoload is-at-least

if ! is-at-least 10.14 $(sw_vers -productVersion); then
    printlog "Installomator requires at least macOS 10.14 Mojave."
    exit 98
fi

# MARK: Functions

printlog(){
    echo "$1"
}

# will get the latest release download from a github repo
downloadURLFromGit() { # $1 git user name, $2 git repo name
    gitusername=${1?:"no git user name"}
    gitreponame=${2?:"no git repo name"}
    
    downloadURL="https://github.com/$gitusername/$gitreponame/releases/latest"
    echo "$downloadURL"
    return 0
}

versionFromGit() { # $1 git user name, $2 git repo name
    gitusername=${1?:"no git user name"}
    gitreponame=${2?:"no git repo name"}
    
    appNewVersion=$(curl --silent --fail "https://github.com/$gitusername/$gitreponame/releases/latest" | sed -E 's/.*tag\/(.*)\">.*/\1/g' )
    if [ -z "$appNewVersion" ]; then
        printlog "could not retrieve version number for $gitusername/$gitreponame: $appNewVersion"
        exit 9
    else
        echo "$appNewVersion"
        return 0
    fi
}


# Handling of differences in xpath between Catalina and Big Sur
xpath() {
    # the xpath tool changes in Big Sur and now requires the `-e` option
    if [[ $(sw_vers -buildVersion) > "20A" ]]; then
        /usr/bin/xpath -e $@
    else
        /usr/bin/xpath $@
    fi
}

# MARK: Script

if [[ $# -eq 0 ]]; then
    allLabels=$(grep -E '^[a-z0-9\-]*(\)|\|\\)$' "${labelFile}" | tr -d ')|\\' | grep -v -E '^(broken.*|longversion|version|valuesfromarguments)$' | tr '\n' ' ')
    allLabels=( ${=allLabels} ) #to separate white space
else
    allLabels=( ${=@} )
fi

countError=0
for label in $allLabels; do
    echo "########## $label"
    labelerror=0; expectedExtension=""; URLextension=""
    name=""; type=""; downloadURL=""; appNewVersion=""; expectedTeamID=""; blockingProcesses=""; updateTool=""; updateToolArguments=""; archiveName=""
    
    caseLabel

    echo "Name: $name"
    echo "Download URL: $downloadURL"
    echo "Type: $type"
    case $type in
        dmg|pkg|zip|tbz)
            expectedExtension="$type"
            ;;
        pkgInDmg)
            expectedExtension="dmg"
            ;;
        pkgInZip)
            expectedExtension="zip"
            ;;
        *)
            echo "Cannot handle type $type"
            ;;
    esac
    if [[ "$appNewVersion" == "" ]] ; then
        echo "No appNewVersion!"
    else
        if [[ $( echo "$appNewVersion" | sed -E 's/^.?([0-9\.]*).?/\1/g' ) == "" || "$appNewVersion" == "" ]]; then
            echo "-> !! ERROR in appNewVersion"
            labelerror=1
        else
            echo "Version: $appNewVersion" ;
        fi
    fi
    if curl --location --output /dev/null --silent --fail -r 0-24 "$downloadURL" ; then
        echo "OK: downloadURL works OK"
        if [[ $(echo "$downloadURL" | sed -E 's/.*\.([a-zA-Z]*)\s*/\1/g' ) == "${expectedExtension}" ]]; then
            echo "OK: download extension MATCH on ${expectedExtension}"
        else
            if [[ $(echo "$downloadURL" | grep -io "github.com") != "github.com" ]]; then
                URLheader=$( curl -fsIL "$downloadURL" )
                if [[ "${URLheader}" != "" ]]; then
                    URLlocation=$( echo "${URLheader}" | grep -i "^location" )
                    URLfilename=$( echo "${URLheader}" | grep -i "filename=" )
                    if [[ "${URLlocation}" != "" ]]; then
                        URLextension=$( echo "${URLlocation}" | tail -1 | sed -E 's/.*\.([a-zA-Z]*)\s*/\1/g' | tr -d '\r\n' )
                    else
                        URLextension=$( echo "${URLfilename}" | tail -1 | sed -E 's/.*\.([a-zA-Z]*)\s*/\1/g' | tr -d '\r\n' )
                    fi
                    URLextension=${URLextension:l}
                    if [[ "${URLextension}" == "${expectedExtension}" ]]; then
                        echo "OK: download extension MATCH on ${URLextension}"
                    else
                        echo "-> !! ERROR in download extension, expected ${expectedExtension}, but got ${URLextension}."
                        labelerror=1
                    fi
                else
                    echo "no header provided from server."
                fi
            else
                echo "github.com not type checked."
            fi
        fi
    else
        echo "-> !! ERROR in downloadURL"
        labelerror=1
    fi
    if [[ $labelerror != 0 ]]; then; echo "########## ERROR in label: $label"; ((countError++)); fi

    echo ""
done

${SELFLOCATION}/Installomator.sh version
echo ""

if [[ countError > 0 ]]; then
    echo "ERRORS counted: $countError"
else
    echo "No errors detected!"
fi

echo "Done!"
