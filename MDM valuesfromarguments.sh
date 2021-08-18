#!/bin/bash
# Installation using Installomator
# Example of installing software using valuesfromarguments to install a custom software

what="valuesfromarguments" # enter the software to install

# Verify that Installomator has been installed
destFile="/usr/local/bin/Installomator.sh"
if [ ! -e "${destFile}" ]; then
    echo "Installomator not found here:"
    echo "${destFile}"
    echo "Exiting."
    exit 99
fi

${destFile} valuesfromarguments \
            name=CraftManager \
            type=zip \
            downloadURL=https://craft-assets.invisionapp.com/CraftManager/production/CraftManager.zip \
            appNewVersion=1.0.114 \
            expectedTeamID=VRXQSNCL5W \
            BLOCKING_PROCESS_ACTION=prompt_user_loop \
            NOTIFY=all

# ${destFile} ${what} BLOCKING_PROCESS_ACTION=ignore NOTIFY=silent
if [ $? != 0 ]; then
# This is currently not working in Mosyle, that will ignore script errors. Please request support for this from Mosyle!
    echo "Error installing ${what}. Exit code $?"
    exit $?
fi

echo "[$(DATE)][LOG-END]"

exit 0
