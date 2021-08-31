#!/bin/bash
# Installation using Installomator
what="microsoftteams microsoftyammer firefox bravebrowser cyberduck vlc signal" # enter the software to install separated with spaces

# To be used as a script sent out from a MDM.
# Fill the variable "what" above with labels separated by space " ".
# Script will loop through these labels.
######################################################################

# Verify that Installomator has been installed
destFile="/usr/local/bin/Installomator.sh"
if [ ! -e "${destFile}" ]; then
    echo "Installomator not found here:"
    echo "${destFile}"
    echo "Exiting."
    exit 99
fi

for item in $what; do
    #echo $item
    ${destFile} ${item} LOGO=mosyleb #NOTIFY=all #BLOCKING_PROCESS_ACTION=tell_user_then_kill #INSTALL=force
    if [ $? != 0 ]; then
    # This is currently not working in Mosyle, that will ignore script errors. Please request support for this from Mosyle!
        echo "[$(DATE)] Error installing ${item}. Exit code $?"
        # exit $?
    fi
done

echo "[$(DATE)][LOG-END]"

exit 0

# notify behavior
# Default is
# NOTIFY=success
# options:
#   - success      notify the user on success
#   - silent       no notifications
#   - all          all notifications (great for Self Service installation)

# behavior when blocking processes are found
# Default is
# BLOCKING_PROCESS_ACTION=prompt_user_loop
# options:
#   - ignore       continue even when blocking processes are found
#   - silent_fail  exit script without prompt or installation
#   - prompt_user  show a user dialog for each blocking process found
#                  abort after three attempts to quit
#                  (only if user accepts to quit the apps, otherwise
#                  the update is cancelled).
#   - prompt_user_then_kill
#                  show a user dialog for each blocking process found,
#                  attempt to quit two times, kill the process finally
#   - prompt_user_loop
#                  Like prompt-user, but clicking "Not Now", will just wait an hour,
#                  and then it will ask again.
#   - tell_user    User will be showed a notification about the important update,
#                  but user is only allowed to quit and continue, and then we
#                  ask the app to quit.
#   - tell_user_then_kill
#                  Show dialog 2 times, and if the quitting fails, the
#                  blocking processes will be killed.
#   - kill         kill process without prompting or giving the user a chance to save

# logo-icon used in dialog boxes if app is blocking
# LOGO=appstore
# options:
#   - appstore      Icon is Apple App Store (default)
#   - jamf          JAMF Pro
#   - mosyleb       Mosyle Business
#   - mosylem       Mosyle Manager (Education)
#   - addigy        Addigy
# path can also be set in the command call, and if file exists, it will be used, like 'LOGO="/System/Applications/App\ Store.app/Contents/Resources/AppIcon.icns"' (spaces are escaped).

# install behavior
# Default is
# INSTALL=""
# options:
#  -               When not set, software will only be installed
#                  if it is newer/different in version
#  - force         Install even if it’s the same version

########################
# Often used labels:
########################

# firefox
# firefox_intl
# brave
# torbrowser
# googlechrome
# netnewswire

# adobereaderdc
# textmate

# cyberduck
# keka
# theunarchiver

# vlc
# handbrake

# inkscape

# signal
# telegram
# whatsapp

# hazel
# devonthink

# teamviewerqs
# zoom

# malwarebytes
# githubdesktop
# sublimetext
# textmate
# visualstudiocode

# microsoftskypeforbusiness
# microsoftteams
# microsoftyammer
# microsoftedgeenterprisestable
# microsoftedgeconsumerstable
# microsoftsharepointplugin
# microsoftdefenderatp

# googledrivefilestream

# cdef
# desktoppr
# supportapp
# xink
# wwdc
