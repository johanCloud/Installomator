#!/bin/bash
# Updating Installomator
# Usefull to push out after deployment if version 0.4.14 was deployed in DEP profile

what="installomator_st" # enter the software to install

# Verify that Installomator has been installed
destFile="/usr/local/bin/Installomator.sh"
if [ ! -e "${destFile}" ]; then
    echo "Installomator not found here:"
    echo "${destFile}"
    echo "Exiting."
    exit 99
fi

${destFile} ${what} BLOCKING_PROCESS_ACTION=ignore NOTIFY=silent
if [ $? != 0 ]; then
# This is currently not working in Mosyle, that will ignore script errors. Please request support for this from Mosyle!
    echo "Error installing ${what}. Exit code $?"
    exit $?
fi

echo "[$(DATE)][LOG-END]"

exit 0
