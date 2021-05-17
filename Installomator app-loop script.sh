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
# firefox_da
# brave
# torbrowser
# googlechrome
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

# microsoftskypeforbusiness
# microsoftteams
# microsoftyammer
# microsoftedgeenterprisestable
# microsoftedgeconsumerstable
# microsoftsharepointplugin
# visualstudiocode
# microsoftdefenderatp

# googledrivefilestream

# cdef
# desktoppr
# xink
# wwdc


########################
# ALL available
########################
# 1password7
# 8x8
# abstract
# adobebrackets
# adobeconnect
# adobereaderdc
# adobereaderdc-install
# adobereaderdc-update
# aircall
# airserver
# alfred
# amazonchime
# amazonworkspaces
# androidfiletransfer
# apparency
# appcleaner
# applenyfonts
# applesfcompact
# applesfmono
# applesfpro
# aquaskk
# atom
# autodmg
# autopkgr
# aviatrix
# awscli2
# awsvpnclient
# balenaetcher
# basecamp3
# bbedit
# bettertouchtool
# bitwarden
# blender
# bluejeans
# boxdrive
# brave
# cakebrew
# calibre
# camostudio
# camtasia
# citrixworkspace
# clevershare2
# clickshare
# code42
# coderunner
# cormorant
# cryptomator
# cyberduck
# dangerzone
# darktable
# dbeaverce
# debookee
# depnotify
# desktoppr
# detectxswift
# devonthink
# dialpad
# discord
# docker
# dropbox
# easeusdatarecoverywizard
# egnyte
# element
# eraseinstall
# etrecheck
# exelbanstats
# fantastical
# ferdi
# figma
# firefox
# firefox_da
# firefoxesr
# firefoxesrpkg
# firefoxpkg
# front
# fsmonitor
# gimp
# githubdesktop
# golang
# googlechrome
# googlechromepkg
# googledrive
# googledrivebackupandsync
# googledrivefilestream
# googleearth
# googlejapaneseinput
# gotomeeting
# gpgsuite
# gpgsync
# grandperspective
# gyazo
# gyazogif
# handbrake
# hazel
# hpeasyadmin
# hpeasystart
# hyper
# icons
# inkscape
# installomator_st
# installomator_theile
# intellijideace
# istatmenus
# iterm2
# jabradirect
# jamfconnect
# jamfmigrator
# jamfpppcutility
# jamfreenroller
# jetbrainsintellijidea
# jetbrainsintellijideace
# jetbrainsphpstorm
# jetbrainspycharm
# jetbrainspycharmce
# karabinerelements
# keepassxc
# keka
# keyboardmaestro
# klokki
# knockknock
# krisp
# krita
# lastpass
# launchbar
# lexarrecoverytool
# libreoffice
# loom
# lucifer
# lulu
# macfuse
# malwarebytes
# mattermost
# menumeters
# microsoftautoupdate
# microsoftcompanyportal
# microsoftdefenderatp
# microsoftedge
# microsoftedgeconsumerstable
# microsoftedgeenterprisestable
# microsoftexcel
# microsoftlicenseremovaltool
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
# microsoftvisualstudiocode
# microsoftword
# microsoftyammer
# miro
# musescore
# netnewswire
# nextcloud
# nomad
# nomadlogin
# notion
# nvivo
# obsidian
# odrive
# omnidisksweeper
# omnifocus3
# omnigraffle6
# omnigraffle7
# omnioutliner5
# omniplan3
# omniplan4
# omnipresence
# onionshare
# onlyofficedesktop
# openvpnconnect
# openvpnconnectv3
# opera
# pacifist
# pdfsam
# pitch
# plantronicshub
# plisteditpro
# postman
# prism9
# privileges
# proctortrack
# promiseutilityr
# pycharmce
# pymol
# r
# ramboxce
# rectangle
# redeye
# resiliosynchome
# retrobatch
# ricohpsprinters
# ringcentralapp
# ringcentralclassicapp
# ringcentralmeetings
# ringcentralphone
# rocket
# rocketchat
# royaltsx
# rstudio
# santa
# screamingfrogseospider
# sfsymbols
# shield
# sidekick
# signal
# silnite
# sizeup
# sketch
# skype
# slack
# snagit
# snagit2020
# snagit2021
# snapgeneviewer
# sonos
# sonoss1
# sonoss2
# sourcetree
# spotify
# sublimetext
# supportapp
# suspiciouspackage
# swiftruntimeforcommandlinetools
# tableaureader
# taskpaper
# teamviewer
# teamviewerhost
# teamviewerqs
# telegram
# textmate
# things
# thunderbird
# tigervnc
# toggltrack
# torbrowser
# trex
# tunnelbear
# tunnelblick
# umbrellaroamingclient
# universaltypeclient
# vagrant
# vanilla
# veracrypt
# virtualbox
# viscosity
# visualstudiocode
# vivaldi
# vlc
# vmwarehorizonclient
# vscodium
# webexmeetings
# webexteams
# whatsapp
# wickrme
# wickrpro
# wireshark
# wwdc
# xeroxphaser7800
# xink
# yubikeymanagerqt
# zappy
# zoom
# zoomclient
# zulujdk11
# zulujdk13
# zulujdk15
