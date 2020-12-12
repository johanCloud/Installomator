#!/bin/zsh

# Check Installomator labels
# 2020 Søren Theilgaard (@theilgaard)

# This script will test labels and check if download link is active, and if version is defined.
# If labels are written to the script only those will be tested.
# If none are provided, it will test all labels.
# https://github.com/theile/Installomator

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
    
    # check if API-calls to Git has been exceeded, only 60 per hour
    if [[ $(curl -si https://api.github.com/users/octocat | grep X-Ratelimit-Remaining | awk '{print $2}') == 0 ]]; then
        echo "API rate limit exceeded to github"
        return 0
    fi
    
    if [[ $type == "pkgInDmg" ]]; then
        filetype="dmg"
    elif [[ $type == "pkgInZip" ]]; then
        filetype="zip"
    else
        filetype=$type
    fi
        
    if [ -n "$archiveName" ]; then
    downloadURL=$(curl --silent --fail "https://api.github.com/repos/$gitusername/$gitreponame/releases/latest" \
    | awk -F '"' "/browser_download_url/ && /$archiveName/ { print \$4 }")
    else
    downloadURL=$(curl --silent --fail "https://api.github.com/repos/$gitusername/$gitreponame/releases/latest" \
    | awk -F '"' "/browser_download_url/ && /$filetype\"/ { print \$4 }")
    fi
    
    if [ -z "$downloadURL" ]; then
        printlog "could not retrieve download URL for $gitusername/$gitreponame: $downloadURL"
        exit 9
    else
        echo "$downloadURL"
        return 0
    fi
}

versionFromGit() {
    # credit: Søren Theilgaard (@theilgaard)
    # $1 git user name, $2 git repo name
    gitusername=${1?:"no git user name"}
    gitreponame=${2?:"no git repo name"}
        
    # check if API-calls to Git has been exceeded, only 60 per hour
    if [[ $(curl -si https://api.github.com/users/octocat | grep X-Ratelimit-Remaining | awk '{print $2}') == 0 ]]; then
        echo "API rate limit exceeded to github"
        return 0
    fi

    appNewVersion=$(curl --silent --fail "https://api.github.com/repos/$gitusername/$gitreponame/releases/latest" | grep tag_name | cut -d '"' -f 4 | sed 's/[^0-9\.]//g')
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

set -o shwordsplit

if [[ $# -eq 0 ]]; then
    allLabels=$(grep -E '^[a-z0-9\-]*(\)|\|\\)$' "${labelFile}" | tr -d ')|\\' | grep -v -E '^(broken.*|longversion|version|valuesfromarguments)$' | tr '\n' ' ')
else
    allLabels=$@
fi


for label in $allLabels; do
    echo "########## $label"
    labelerror=0;name="";type="";downloadURL="";appNewVersion="";expectedTeamID="";blockingProcesses="";updateTool="";updateToolArguments="";archiveName=""
    caseLabel
    if [ -z "$archiveName" ]; then
    case $type in
        dmg|pkg|zip|tbz)
            archiveName="${name}.$type"
            ;;
        pkgInDmg)
            archiveName="${name}.dmg"
            ;;
        pkgInZip)
            archiveName="${name}.zip"
            ;;
        *)
            printlog "Cannot handle type $type"
            cleanupAndExit 99
            ;;
    esac
    fi

    echo "Name: $name"
    echo "Download URL: $downloadURL"
    echo "Type: $type"
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
    typeLength=${#type}
    #URLlocation=$(curl --location --silent --include "$downloadURL" | grep "^location" ) # --fail
    #curl --location --output /dev/null --silent --fail -r 0-0 "$downloadURL"
    #if [[ "$URLlocation" == "Binary file (standard input) matches" || "$URLlocation" == "" ]]; then
    if curl --location --output /dev/null --silent --fail -r 0-0 "$downloadURL" ; then
        echo "downloadURL OK"
    else
        echo "-> !! ERROR in downloadURL"
        labelerror=1
    fi
    if [[ $labelerror != 0 ]]; then; echo "##### ERROR in label: $label"; fi

    echo ""
done

${SELFLOCATION}/Installomator.sh version
echo "Done!"
