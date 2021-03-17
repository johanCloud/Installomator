#!/bin/bash
# Updating Installomator
# Usefull to push out after deployment if earlier version was deployed in DEP profile

what="installomator_st" # enter the software to install

# Verify that Installomator has been installed
destFile="/usr/local/bin/Installomator.sh"
if [ ! -e "${destFile}" ]; then
    echo "Installomator not found here:"
    echo "${destFile}"
    echo "Exiting."
    exit 99
fi

#${destFile} valuesfromarguments\
#            name=Installomator \
#            type=pkg \
#            packageID=dk.theilgaard.pkg.Installomator \
#            downloadURL=https://github.com/Theile/Installomator/releases/download/v0.4.20/Installomator_ST-0.4.20.pkg \
#            appNewVersion=0.4.20 \
#            expectedTeamID=L8W73B6AH3 \
#            BLOCKING_PROCESS_ACTION=ignore \
#            NOTIFY=silent
${destFile} ${what} BLOCKING_PROCESS_ACTION=ignore NOTIFY=silent
if [ $? != 0 ]; then
# This is currently not working in Mosyle, that will ignore script errors. Please request support for this from Mosyle!
    echo "Error installing ${what}. Exit code $?"
    exit $?
fi

echo "[$(DATE)][LOG-END]"

exit 0
