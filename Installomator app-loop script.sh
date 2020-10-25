#!/bin/bash
# Global Log
LOG_FILE="/var/tmp/scriptlog.txt"
exec > >(tee -a ${LOG_FILE} )
exec 2> >(tee -a ${LOG_FILE} >&2)
echo " "
echo "[$(DATE)][LOG-START]"


# Installation using Installomator
what="microsoftteams microsoftyammer firefox_da googlechrome cyberduck vlc signal" # enter the software to install separated with spaces

# Verify that Installomator has been installed
destFile="/usr/local/bin/Installomator"
if [ ! -e "${destFile}" ]; then
    echo "Installomator not found here:"
    echo "${destFile}"
    echo "Exiting."
    exit 99
fi

for item in $what; do
    #echo $item
    ${destFile} ${item} #BLOCKING_PROCESS_ACTION=prompt_user_then_kill
    if [ $? != 0 ]; then
        echo "[$(DATE)] Error installing ${item}. Exit code $?"
        # exit $?
    fi
done

echo "[$(DATE)][LOG-END]"

exit 0

# behavior when blocking processes are found
BLOCKING_PROCESS_ACTION=prompt_user
# options:
#   - ignore       continue even when blocking processes are found
#   - silent_fail  exit script without prompt or installation
#   - prompt_user  show a user dialog for each blocking process found
#                  abort after three attempts to quit
#   - prompt_user_then_kill
#                  show a user dialog for each blocking process found,
#                  attempt to quit two times, kill the process finally
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
