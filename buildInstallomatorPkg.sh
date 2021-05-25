#!/bin/zsh

# buildInstallomatorPkg.sh

# this script will create a pkg installer that places the Installomator.sh
# script file in /usr/local/Installomator/Installomator.sh

# this is for use with MDM systems that require the tools to be local

export PATH=/usr/bin:/bin:/usr/sbin:/sbin

pkgname="Installomator_Theile"
version="0.5.7"
identifier="dk.theilgaard.pkg.Installomator"
install_location="/usr/local/bin/"
signature=""
dev_team="" # asc-provider
dev_account=""
dev_keychain_label=""


scriptfolder=$(dirname "$0")
projectfolder=$(mktemp -d)
payloadfolder="${projectfolder}/payload"

# MARK: functions
requeststatus() { # $1: requestUUID
    requestUUID=${1?:"need a request UUID"}
    req_status=$(xcrun altool --notarization-info "$requestUUID" \
                          --username "$dev_account" \
                          --password "@keychain:$dev_keychain_label" 2>&1 | awk -F ': ' '/Status:/ { print $2; }' )
    echo "$req_status"
}

notarizefile() { # $1: path to file to notarize, $2: identifier
    filepath=${1:?"need a filepath"}
    identifier=${2:?"need an identifier"}
    
    # upload file
    echo "## uploading $filepath for notarization"
    requestUUID=$(xcrun altool --notarize-app \
                               --primary-bundle-id "$identifier" \
                               --username "$dev_account" \
                               --password "@keychain:$dev_keychain_label" \
                               --asc-provider "$dev_team" \
                               --file "$filepath" 2>&1 | awk '/RequestUUID/ { print $NF; }')
                               
    echo "Notarization RequestUUID: $requestUUID"
    
    if [[ $requestUUID == "" ]]; then
        echo "could not upload for notarization"
        exit 1
    fi
        
    # wait for status to be not "in progress" any more
    request_status="in progress"
    while [[ "$request_status" == "in progress" ]]; do
        echo -n "waiting... "
        sleep 10
        request_status=$(requeststatus "$requestUUID")
        echo "$request_status"
    done
    
    if [[ $request_status != "success" ]]; then
        echo "## could not notarize $filepath"
        xcrun altool --notarization-info "$requestUUID" \
                     --username "$dev_account" \
                     --password "@keychain:$dev_keychain_label"
        exit 1
    fi
    
}

# MARK: main code starts here

# create a projectfolder with a payload folder
if [[ ! -d "${payloadfolder}" ]]; then
    mkdir -p "${payloadfolder}"
fi

# copy the script file
cp ${scriptfolder}/Installomator.sh ${payloadfolder}
chmod 755 ${payloadfolder}/Installomator.sh
cp ${scriptfolder}/InstallomatorLabels.sh ${payloadfolder}
chmod 755 ${payloadfolder}/InstallomatorLabels.sh

# build the component package
pkgpath="${scriptfolder}/${pkgname}.pkg"

pkgbuild --root "${projectfolder}/payload" \
         --identifier "${identifier}" \
         --version "${version}" \
         --install-location "${install_location}" \
         "${pkgpath}"


# build the product archive

productpath="${scriptfolder}/${pkgname}-${version}.pkg"

productbuild --package "${pkgpath}" \
             --version "${version}" \
             --identifier "${identifier}" \
             --sign "${signature}" \
             "${productpath}"

# clean up project folder
rm -Rf "${projectfolder}"

# upload for notarization
notarizefile "$productpath" "$identifier"

# staple result
echo "## Stapling $productpath"
xcrun stapler staple "$productpath"

echo "## md5 checksum for $(basename "${productpath}")"
md5 -q "$productpath"

exit 0
