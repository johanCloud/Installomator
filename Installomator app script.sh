#!/bin/bash
# Installation using Installomator
what="googledrivefilestream" # enter the software to install

# To be used as a script sent out from a MDM.
# Fill the variable "what" above with a label.
# Script will run this label.
###############################################


# Verify that Installomator has been installed
destFile="/usr/local/bin/Installomator"
if [ ! -e "${destFile}" ]; then
    echo "Installomator not found here:"
    echo "${destFile}"
    echo "Exiting."
    exit 99
fi

${destFile} ${what} #BLOCKING_PROCESS_ACTION=prompt_user_then_kill
if [ $? != 0 ]; then
    echo "Error installing ${what}. Exit code $?"
    exit $?
fi

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

# xink
# cdef

########################
# ALL available
########################
#1password7
#8x8
#adobereaderdc
#adobereaderdc-install
#adobereaderdc-update
#airserver
#alfred
#appcleaner
#aquaskk
#atom
#autodmg
#autopkgr
#autopkgr
#aviatrix
#bbedit
#bettertouchtool
#boxdrive
#brave
#cdef
#citrixworkspace
#code42
#coderunner
#cyberduck
#depnotify
#desktoppr
#detectxswift
#discord
#docker
#dropbox
#egnyte
#eraseinstall
#firefox
#firefoxesrpkg
#firefoxpkg
#githubdesktop
#googlechrome
#googlechromepkg
#googledrivefilestream
#googlejapaneseinput
#grandperspective
#handbrake
#icons
#inkscape
#istatmenus
#iterm2
#jamfmigrator
#jamfpppcutility
#jamfreenroller
#karabinerelements
#keepassxc
#krisp
#malwarebytes
#microsoftautoupdate
#microsoftcompanyportal
#microsoftdefenderatp
#microsoftedgeconsumerstable
#microsoftedgeenterprisestable
#microsoftexcel
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
#netnewswire
#nomad
#omnifocus3
#omnigraffle7
#openvpnconnect
#pacifist
#plisteditpro
#postman
#privileges
#r
#resiliosynchome
#ringcentralapp
#ringcentralmeetings
#royaltsx
#santa
#sfsymbols
#signal
#sizeup
#sketch
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
#torbrowser
#tunnelbear
#umbrellaroamingclient
#virtualbox
#visualstudiocode
#vlc
#vscodium
#webexmeetings
#webexteams
#whatsapp
#wordmat
#wwdcformac
#xink
#zoom
