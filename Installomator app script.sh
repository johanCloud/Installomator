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

${destFile} ${what} LOGO=mosyleb #NOTIFY=all #BLOCKING_PROCESS_ACTION=tell_user_then_kill #INSTALL=force
if [ $? != 0 ]; then
# This is currently not working in Mosyle, that will ignore script errors. Please request support for this from Mosyle!
    echo "Error installing ${what}. Exit code $?"
    exit $?
fi

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

# signal
# telegram
# whatsapp

# hazel
# devonthink

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
#1password7
#8x8
#adobebrackets
#adobeconnect
#adobereaderdc
#adobereaderdc-install
#adobereaderdc-update
#aircall
#airserver
#alfred
#amazonworkspaces
#androidfiletransfer
#apparency
#appcleaner
#aquaskk
#atom
#autodmg
#autopkgr
#aviatrix
#balenaetcher
#bbedit
#bettertouchtool
#bitwarden
#bluejeans
#boxdrive
#brave
#camtasia
#citrixworkspace
#code42
#coderunner
#cormorant
#cyberduck
#dangerzone
#dbeaverce
#debookee
#depnotify
#desktoppr
#detectxswift
#devonthink
#dialpad
#discord
#docker
#dropbox
#egnyte
#eraseinstall
#etrecheck
#ferdi
#firefox
#firefoxesrpkg
#firefoxpkg
#fsmonitor
#githubdesktop
#googlechrome
#googlechromepkg
#googledrivefilestream
#googlejapaneseinput
#gpgsuite
#gpgsync
#grandperspective
#handbrake
#hazel
#hyper
#icons
#inkscape
#istatmenus
#iterm2
#jabradirect
#jamfmigrator
#jamfpppcutility
#jamfreenroller
#karabinerelements
#keepassxc
#keka
#krisp
#libreoffice
#malwarebytes
#mattermost
#menumeters
#netnewswire
#nomad
#nomadlogin
#omnifocus3
#omnigraffle7
#onlyofficedesktop
#openvpnconnect
#openvpnconnectv3
#pacifist
#pitch
#plantronicshub
#plisteditpro
#postman
#privileges
#r
#ramboxce
#resiliosynchome
#ringcentralapp
#ringcentralmeetings
#royaltsx
#santa
#sfsymbols
#sidekick
#signal
#silnite
#sizeup
#sketch
#skitch
#skype
#slack
#sonos
#sonoss1
#sonoss2
#sourcetree
#spotify
#sublimetext
#suspiciouspackage
#swiftruntimeforcommandlinetools
#teamviewer
#teamviewerqs
#textmate
#things
#thunderbird
#tigervnc
#toggltrack
#torbrowser
#tunnelbear
#tunnelblick
#umbrellaroamingclient
#vagrant
#virtualbox
#visualstudiocode
#vlc
#vmwarehorizonclient
#vscodium
#webexmeetings
#webexteams
#webexteams
#whatsapp
#wireshark
#xink
#yubikeymanagerqt
#zoom

########################
# Microsoft
########################
#microsoftautoupdate
#microsoftcompanyportal
#microsoftdefenderatp
#microsoftedgeenterprisestable
#microsoftexcel
#microsoftlicenseremovaltool
#microsoftoffice365
#microsoftofficebusinesspro
#microsoftonedrive
#microsoftonenote
#microsoftoutlook
#microsoftpowerpoint
#microsoftremotedesktop
#microsoftsharepointplugin
#microsoftskypeforbusiness
#microsoftteams
#microsoftword
#microsoftyammer
