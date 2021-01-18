## v0.5 - 2020-

## 0.4.17 - 2021-01-??
- Added a bit extra logging, when using INSTALL=force
- Labels with appNewVersion: 1password7
- Labels changed for Apple Silicon: vlc
- Labels added: vanilla, taskpaper, calibre, redeye, lucifer, fantastical, launchbar, klokki, notion, lexarrecoverytool, easeusdatarecoverywizard, lastpass, front, obsidian, telegram, wickrme, wickrpro, omnigraffle6, omnioutliner5, omniplan3, omnipresence, omnidisksweeper, exelbanstats, onionshare

## 0.4.16 - 2021-01-08
- Added variable `INSTALL` that can be set to `force` if software needs to be installed even though latest version is already installed (it will be a reinstall). Usefull if you need to install the universal build of the same software, if the latest was already installed, and the label just improved to handle the universal version. Brave Browser and Google Chrome ready for this.
- Labels changed: googlechrome (universal for Apple Silicon), brave (changed a bit in architecture test)

## v0.4.15 - 2021-01-06

- New type handler for appInDmgInZip. Needed for DEVONthink.
- Added notification before download and before installation, if NOTIFY=all
- Function installPkgInZip changed to find files 2 levels deep if zip contains a folder.
- `CheckInstallomator.sh` has added suggestion for checking labels
- Labels changed for Apple Silicon: brave
- Labels added: devonthink


## v0.4.14 - 2020-12-23

- I messed up my own Team ID in my own label.
- `CheckInstallomator.sh` improved/simplified in version number check
- Labels changed: snagit (snagit2021, snagit2020 is the same)
- Labels added: hazel, cormorant, silnite, 

## v0.4.13 - 2020-12-21

- `CheckInstallomator.sh` improved so that type is checked with the extension from the URL
- Labels added: installomator_st (now you can update Installomator from itself), etrecheck, microsoftlicenseremovaltool
- Labels fixed: dbeaverce
- Labels removed appNewVersion: yubikeymanagerqt
- Labels with errors, commented out:  wwdcformac (looks like software/site is gone)

## v0.4.12 - 2020-12-18

- Added notification to no update available and to failed download.
- Package signed and notarized
- `CheckInstallomator.sh`: Does not use github APIs for checking URL or version. So not entirely accurate, but it will confirm if it's working.
- Labels added: mattermost, bitwarden, thunderbird, tigervnc, pitch, sidekick, plantronicshub, jabradirect, amazonworkspaces, vagrant, aircall
- Labels fixed: nomad (changed TeamID), omnifocus3
- Labels with errors, not fixed:  wwdcformac (looks like it is gone)

## v0.4.10 - 2020-12-12

- Labels added: vmwarehorizonclient, adobeconnect, wireshark, nomadlogin, microsoftedge (same as microsoftedgeconsumerstable), onlyofficedesktop, gpgsuite, gpgsync, dangerzone, dbeaverce, androidfiletransfer, libreoffice, toggltrack, balenaetcher, fsmonitor, ramboxce, adobebrackets, debookee, ferdi, hyper, menumeters, webexteams
- Labels fixed: sketch
- Versioncheck fixed on labels: bettertouchtool
- Versioncheck add to labels: Spotify, nomad, microsoftautoupdate, microsoftedge, microsoftword, microsoftexcel, microsoftpowerpoint, microsoftoutlook, microsoftonenote, microsoftonedrive, microsoftskypeforbusiness, microsoftcompanyportal
- Labels with errors, not fixed: omnifocus3, vscodium, yubikeymanagerqt
- Versioncheck removed from labels: Spotify

## v0.4.9 - 2020-11-11

- Testet with macOS 11 Big Sur
- Default BLOCKING_PROCESS_ACTION=prompt_user_loop
- FIxed a bug preventing labels using github from working
- Labels added: keka
- Removed Label cdef, as it does not contain signing.

## v0.4.8 - 2020-11-08

- Added other handlings of user notifications. prompt_user_loop, tell_user and tell_user_then_kill. prompt_user_loop is not exiting on the not now button, but is waiting an hour until next question, and after that it changes action to tell_user. tell_user is just a dialog to the user to tell that an update is needed, with no way of dismissing, but they can leave the dialog open. it's more eager to install, and do not allow the user to cancel the upgrade. if _then_kill is added in the name, it will ask 2 times and kill it the 3. What could happen is that after the polite quite, the user could open the app, and if so, he/she will be asked again. The workings of these have been reworked a bit. If the app is killed the wait for that is only 5 seconds.
- Labels improved: 8x8
- Labels added with versioncheck: iterm2, docker, postman, sourcetree, visualstudiocode, malwarebytes, suspiciouspackage


## v0.4.7 - 2020-10-26

- No changes to Installomator.sh file
- Changes to the scripts to be used in the MDM, so that it will call Installomator.sh
- included .pkgproj-file so that an installer package, taht install scripts to /usr/local/bin, can be built.
- Labels: - Added openvpnconnectv3


## v0.4.6 - 2020-10-25

- Alligned with version 0.4 from official Installomator
- Reenforced need of signature on downloaded file. If files do not have a signature, we will not accept automatic download and install
- xpath function added to handle differences with xpath between Catalina and Big Sur
- Labels: brave TeamID fixed and version added
- Labels: torbrowser download and version fixed
- Labels: Added yubikeymanagerqt, bluejeans, skype


## v0.4.5 - 2020-09-02

- Changed GitHub download so that returned file has to end with filetype.
- Logging using label as tag, and also with logger command (label as tag so that concurrent runnings of Installomator can be separated
- cleanupAndExit function writes exit code
- Labels: Added vscodium, keepassxc, alfred, istatmenus, sizeup, virtualbox, detectxswift, autopkgr, airserver, xink, cdef
- Labels: textmate to use GitHub

## Labels in separate file

- I want to be able to update the labels more frequently, and just keep the main script, so I have moved all labels to an InstallomatorLabels.sh file that will be called from the main script.
