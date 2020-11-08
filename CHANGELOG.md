## v0.5 - 2020-

- 

## v0.4.8 - 2020

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
