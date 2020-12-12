#!/bin/bash
# Installation using Installomator
what="googledrivefilestream" # enter the software to install

# To be used as a script sent out from a MDM.
# Fill the variable "what" above with a label.
# Script will run this label.
###############################################


# Verify that Installomator has been installed
destFile="/usr/local/bin/Installomator.sh"
if [ ! -e "${destFile}" ]; then
    echo "Installomator not found here:"
    echo "${destFile}"
    echo "Exiting."
    exit 99
fi

${destFile} ${what} #BLOCKING_PROCESS_ACTION=tell_user_then_kill
if [ $? != 0 ]; then
# This is currently not working in Mosyle, that will ignore script errors. Please request support for this from Mosyle!
    echo "Error installing ${what}. Exit code $?"
    exit $?
fi

echo "[$(DATE)][LOG-END]"

exit 0

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
# keka

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

# xink
# cdef

########################
# ALL available
########################
# 1password7
# 8x8
# adobereaderdc
# adobereaderdc-install
# adobereaderdc-update
# airserver
# alfred
# amazonworkspaces
# apparency
# appcleaner
# aquaskk
# atom
# autodmg
# autopkgr
# aviatrix
# bbedit
# bettertouchtool
# bluejeans
# boxdrive
# brave
# camtasia
# cdef
# citrixworkspace
# code42
# coderunner
# cyberduck
# depnotify
# desktoppr
# detectxswift
# dialpad
# discord
# docker
# dropbox
# egnyte
# eraseinstall
# firefox
# firefoxesrpkg
# firefoxpkg
# githubdesktop
# googlechrome
# googlechromepkg
# googledrivefilestream
# googlejapaneseinput
# grandperspective
# handbrake
# icons
# inkscape
# istatmenus
# iterm2
# jamfmigrator
# jamfpppcutility
# jamfreenroller
# karabinerelements
# keepassxc
# keka
# krisp
# malwarebytes
# netnewswire
# nomad
# omnifocus3
# omnigraffle7
# openvpnconnect
# openvpnconnectv3
# pacifist
# plisteditpro
# postman
# privileges
# r
# resiliosynchome
# ringcentralapp
# ringcentralmeetings
# royaltsx
# santa
# sfsymbols
# signal
# sizeup
# sketch
# skitch
# skype
# slack
# snagit2020
# sonos
# sonoss1
# sonoss2
# sourcetree
# spotify
# sublimetext
# suspiciouspackage
# swiftruntimeforcommandlinetools
# teamviewer
# teamviewerqs
# textmate
# things
# torbrowser
# tunnelbear
# tunnelblick
# umbrellaroamingclient
# virtualbox
# visualstudiocode
# vlc
# vscodium
# webexmeetings
# webexteams
# whatsapp
# wwdcformac
# xink
# yubikeymanagerqt
# zoom

########################
# Microsoft
########################
# microsoftautoupdate
# microsoftcompanyportal
# microsoftdefenderatp
# microsoftedgeconsumerstable
# microsoftedgeenterprisestable
# microsoftexcel
# microsoftoffice365
# microsoftofficebusinesspro
# microsoftonedrive
# microsoftonenote
# microsoftoutlook
# microsoftpowerpoint
# microsoftremotedesktop
# microsoftsharepointplugin
# microsoftskypeforbusiness
# microsoftteams
# microsoftword
# microsoftyammer
