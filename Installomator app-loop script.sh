#!/bin/bash
# Installation using Installomator
what="microsoftteams microsoftyammer firefox_da googlechrome cyberduck vlc signal" # enter the software to install separated with spaces

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
    ${destFile} ${item} #BLOCKING_PROCESS_ACTION=tell_user_then_kill
    if [ $? != 0 ]; then
        echo "[$(DATE)] Error installing ${item}. Exit code $?"
        # exit $?
    fi
done

echo "[$(DATE)][LOG-END]"

exit 0

# behavior when blocking processes are found
# Default is
# BLOCKING_PROCESS_ACTION=prompt_user
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

########################
# Often used labels:
########################

# googlechrome
# firefox
# firefox_da
# brave
# torbrowser
# netnewswire

# adobereaderdc
# textmate

# cyberduck

# vlc
# handbrake

# inkscape

# whatsapp
# signal
# telegram

# teamviewerqs
# zoom

# malwarebytes
# sublimetext
# githubdesktop

# desktoppr

# microsoftskypeforbusiness
# microsoftteams
# microsoftyammer
# microsoftedgeenterprisestable
# microsoftedgeconsumerstable
# microsoftsharepointplugin
# visualstudiocode
# microsoftdefenderatp

# googledrivefilestream


########################
# Also available
########################
# autodmg
# googlechromepkg
# googlejapaneseinput
# santa
# spotify
# bbedit
# firefoxpkg
# firefoxesrpkg
# suspiciouspackage
# atom
# eraseinstall
# omnigraffle7
# omnifocus3
# textmate
# depnotify
# tunnelbear
# sourcetree
# boxdrive
# aviatrix
# sonos
# coderunner
# openvpnconnect
# pacifist
# 1password7
# webexmeetings
# webexteams
# citrixworkspace
# privileges
# icons
# plisteditpro
# slack
# things
# discord
# grandperspective
# resiliosynchome
# dropbox
# teamviewer
# iterm2
# royaltsx
# appcleaner
# karabinerelements
# postman
# jamfpppcutility
# jamfmigrator
# jamfreenroller
# autopkgr
# docker
# umbrellaroamingclient
# powershell
# powershell-lts
# wwdcformac
# ringcentralmeetings
# ringcentralapp
# sfsymbols
# swiftruntimeforcommandlinetools
# r
# bettertouchtool
# sketch

########################
# Microsoft
########################
# microsoftoffice365
# microsoftofficebusinesspro
# microsoftcompanyportal
# microsoftremotedesktop
# microsoftautoupdate
# microsoftword
# microsoftexcel
# microsoftpowerpoint
# microsoftoutlook
# microsoftonenote
# microsoftonedrive
