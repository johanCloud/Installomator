## 0.7.0 - 2021-0?-?? Expectations and thoughts
This version will be in full sync with the original fork.
I will maintain often new builds of Installomator PKGs, as well as the specific helping scripts for Mosyle/Addigy and other MDMs.
I will build from the original fork, that will soon be based on files in fragments, so it will be much easier to maintain, and my fork here will not be adding anything to the original script.
-  `Installomator.sh` will be moved to `/usr/local/Installomator` so from this version we need to change the call in our MDM-scripts or we should add a link. Maybe I put this into the PKG, as we also need to remove the whereabouts of the original version.
-  The default `BLOCKING_PROCESS_ACTION` will be `tell_user` (I expect). `prompt_user_loop` can make the MDM agent get stuck for that waiting period if the users says no. If no other action is coming through for an hour, it can be a problem. If users should be notified of updates, use the MDM solution to present a dialog.

## 0.6.2 - 2021-??-??
-  Changed check for App Store apps. Use `IGNORE_APP_STORE_APPS=yes` to replace App Store apps (as well as VPP apps) no matter what version they have. Default is `no`, so no matter what version of the App Store app is installed, it will not be replaced. `INSTALL=force` is not used for this part anymore, and will not change behavior.
-  Labels added: microsoftazurestorageexplorer, montereyblocker, rodeconnect, zeplin
-  Labels changed: figma (now both Intel and ARM versions)

## 0.6.1 - 2021-09-10
-  Preparing move of `Installomator.sh` to `/usr/local/Installomator/Installomator.sh`. Version 0.7 will be on this new location, so that will be prepared here. It's still installed in the current location `/usr/local/bin/Installomator.sh`, but links are made to the new location, and MDM scripts has been updated to use the new location. When version 0.7 is coming out, it will not link back to the old location, but will remove the old version.
-  Implemented check for App Store apps. If the already installed app is from App Store, then we will exit, unless `INSTALL=force` is used.
-  Labels removed: tigervnc
-  Labels added: airtame, authydesktop, boxsync, caffeine, cisdem-documentreader, colourcontrastanalyser, craftmanager, flowjo, insomnia, jetbrainsdatagrip, jetbrainstoolbox, muzzle, parsec, platypus, scaleft, screencloudplayer, smartgit, splashtopsos, wallyezflash, zoomrooms
-  Labels changed: apparency (`appNewVersion`), lulu (app is on github), spotify (now for Apple Silicon), suspiciouspackage (`appNewVersion`), microsoftofficebusinesspro (`appNewVersion`)
-  not to offend or belittle anyone, but credit-lines is in the process of being removed. The team behind this fork, as well as the original Installomator, is so thankful for all the contributions, but we would like to save som space in the script. There is now more than 300 titles and if we can remove a credit line on each one, it is a pretty significant reduction. Our own comments in the code is being cleaned up as well.
-  `buildCaseStatement.sh` renamed to `buildLabel.sh` and improved a bit when naming the label (should still be verified manually, though)

## 0.6.0 - 2021-07-18
-  Synchronized with original Installomator version 0.6
-  Labels added: 4kvideodownloader, aldente, alttab, anydesk, atext, audacity, balsamiqwireframes, bartender, defaultfolderx, favro, googlesoftwareupdate, grasshopper, keyboardmaestro, logitechoptions, obs, screenflick, sirimote, tableaudesktop, techsmithcapture, uniconverter, xquartz
-  Labels changed: applesfsymbols (same as sfsymbols), element (`appNewVersion` added), figma (changed `downloadURL`), keepassxc (changed `downloadURL`)

## 0.5.8 - 2021-06-27
-  Change how we search for currently installed app. Now we first try /Applications, and if nothing there, we search using Spotlight. The problem we have seen is that if Parallels is installed and the user has a Windows app (like Micrososft Teams og microsoft Edge), then we constantly got update notification to the user, as Parallels had created a Mac-app with the name of the Windows app (and a wrong version number)
-  Labels added: evernote
-  Labels changed: githubdesktop (difference between arm and intel), microsoftteams (getting `appNewVersion` from macadmins.software as it matches `BundleID` of pkg), sourcetree (Sparkle does not have the latest version anymore), theunarchiver (now with appNewVersion), visualstudiocode (process name changed)
-  Mosyle changed their app name from Business to Self-Service

## 0.5.7 - 2021-05-21
-  New developer certificate, so you cannot update from an older version of `installomator_theile` to this new version, as the TeamID is different. It is now "FXW6QXBFW5"

## 0.5.6 - 2021-05-20
-  Labels added: arq7, proxyman, textexpander, theunarchiver
-  Labels changed: googlejapaneseinput (no blocking processes), sublimetext (now version 4), webexteams (fixed links)
-  New `BLOCKING_PROCESS_ACTION` variables `quit` and `quit_kill`. They will just ask to quit. If after 3 tries it has not quit, it will be killed with the latter option. Could be of great use for service-apps if they do not respawn automatically.

## 0.5.5 - 2021-05-17
-  Labels added: applenyfonts, applesfpro, applesfmono, applesfcompact, trex, wwdc
-  Special labels added: firefox_intl, firefoxesr_intl (both will check for wich language the user has, and install that version, if possible)
-  Labels changed: docker (now both arm and Intel), opera (improved version checking), wireshark (added a space character to `awk` part of `appNewVersion`)
-  Added variable `versionKey` so that we can compare version numbers with normal field `CFBundleShortVersionString`, or field `CFBundleVersion`, as used by Opera.
-  A function `appCustomVersion(){}`can be used in a label, if a custom command has to be used to know what version is installed. See labels zulujdk11, zulujdk13, zulujdk15

## 0.5.3 - 2021-04-18
- Added reopening of apps again. Using new method.
- Added `REOPEN` variable. Can be "yes" or "no". Will only reopen a closed app if value is `REOPEN=yes`

## 0.5.2 - 2021-04-14
- REMOVED reopening apps again. It still gives problem with some apps. The user have to open the updated app themselves after they get the notification
- Fixed a bug in a variable name that prevented updateTool to be used
- added `type` variable for value `"updateronly"` if the label should only run an updater tool.
- Changed pkg name to match my GitHub handle, rather than my initials (also added installomator_theile label, still keeping installomator_st, but it is discontinued)
- Labels added: awscli2, cakebrew, cryptomator, darktable, gotomeeting, gyazo, gyazogif, jetbrainsintellijidea, jetbrainsintellijideace (same as intellijideace), jetbrainsphpstorm, jetbrainspycharm, jetbrainspycharmce (same as pycharmce), krita, macfuse, miro, nextcloud, nvivo, rocketchat, shield, snapgeneviewer, veracrypt
- Labels changed: visualstudiocode (now universal), OmniGroup xpath statements improved
- Microsoft labels changed for appNewVersion. We now use the downloaded url version string, instead of relying on macadmins.software (which often is behind) if it's available. Not for all. (This is not a certain way to get the correct version. Right now it returns 16.47 for Excel, that currently has version 16.47.1)

## 0.5.0 - 2021-03-28
- Labels added: blender, opera, retrobatch, rocket, screamingfrogseospider, tableaureader
- Labels changed/fixed: omniplan3, teamviewer, teamviewerhost
- Labels removed: skitch (moved to App Store)

## 0.4.24 - 2021-03-23
- Reopening of apps put back again (using `open` command instead of `osascript`)
- Version checking added to PKGs if `packageID` variable is set.
- Addigy added as LOGO
- Labels added: pdfsam, odrive
- Labels changed: obsidian is universal

## 0.4.21 - 2021-03-17
- Removed reopening of apps (if they were closed) as it gave some problems for apps using the keychain.
- Added LOGO variable for icons i dialogs, use `LOGO=appstore` (or `jamf` or `mosyleb` or `mosylem`) so the old AppleScript icons is out. Default is `appstore`. (Path to JAMF Pro logo is probably not correct.)
- Labels added: clevershare2, hpeasyadmin, hpeasystart, clickshare

## 0.4.20 - 2021-02-22
- Fixed the printing of labels if no label is given. Previously it would omit a label containing a "_", but that will be included now. If a label has more than one name those are now on individual lines, som they all will be included in the print of labels.
- Fixed, if DEBUG=1 and script was running as root, so now it will not install anything (earlier it would not install pkgs, but still install apps)
- Labels changed: onionshare (it's now a dmg, not a pkg)
- Labels added `appNewVersion`: aquaskk, sidekick
- Labels added: camostudio, abstract, awsvpnclient, figma, gimp, googleearth, googledrivebackupandsync, intellijideace, jamfconnect, musescore, prism9, promiseutilityr, pycharmce, pymol, ricohpsprinters, ringcentralclassicapp, ringcentralphone, rstudio, universaltypeclient, xeroxphaser7800, zappy, zoomclient, zulujdk11, zulujdk13, zulujdk15, omniplan4
- Labels not working: omniplan3

## 0.4.19 - 2021-02-15
- Added icons to dialog boxes
- Labels added `appNewVersion`: vscodium, libreoffice
- Labels changed: googlechrome (changed appNewVersion per architecture), googledrivefilestream (added packageID and blockingProcesses, removed pkgName as that have changed and not really needed, and googledrive=googledrivefilestream), adobereaderdc|adobereaderdc-install (new packageID, changed appNewVersion), adobereaderdc-update (changed appNewVersion), webexmeetings (added targetDir and blockingProcesses), loom (downloadURL changed)
- Labels added: rectangle, knockknock, lulu, element, teamviewerhost, amazonchime, basecamp3, proctortrack, viscosity

## 0.4.18 - 2021-01-22
- Added `packageID` variable to label, so version of packages can be found
- `CheckInstallomator.sh` improved for version checking on github and can give warnings
- Labels changed for Apple Silicon: slack
- Labels with appNewVersion: slack
- Labels changed: keyboardmaestro (bit better version checking), adobereaderdc|adobereaderdc-install & adobereaderdc-update (new appNewVersion), icons (error in downloadURL), vagrant (appNewVersion and fixed downloadURL)
- Labels added: loom

## 0.4.17 - 2021-01-19
- If any blocking process was closed, Installomator will try to open the app again, after the update process is done
- Added a bit extra logging, when using INSTALL=force
- Labels with appNewVersion: 1password7
- Labels changed for Apple Silicon: vlc
- Labels added: vanilla, taskpaper, calibre, redeye, lucifer, fantastical, launchbar, klokki, notion, lexarrecoverytool, easeusdatarecoverywizard, lastpass, front, telegram, obsidian, wickrme, wickrpro, omnigraffle6, omnioutliner5, omniplan3, omnipresence, omnidisksweeper, exelbanstats, onionshare, keyboardmaestro

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
- Default `BLOCKING_PROCESS_ACTION=prompt_user_loop`
- Fixed a bug preventing labels using github from working
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
