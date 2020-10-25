# Installomator (ST branch)

_The one installer script to rule them all._

![](https://img.shields.io/github/v/release/theile/Installomator)&nbsp;![](https://img.shields.io/github/downloads/theile/Installomator/latest/total)&nbsp;![](https://img.shields.io/badge/macOS-10.14%2B-success)&nbsp;![](https://img.shields.io/github/license/theile/Installomator)

This version of installomator is for people that would like Installomator to be installed permanently on the client Macs. Then we can execute the script at various times to get software installed and updated.

This version is not to be used like the original, that is built for Jamf Pro. 

This version is for MDMs, that can sent scripts, maybe at specific times. It has been testet a lot with Mosyle Business and Manager.

Purpose is to add a version check before download, and/or before installation, so only if an update exist, will it install the software. A new variable for the label has been introduced so if the version can be obtained from the web site or similar place, the script can evaluate very quickly if it needs an update.

See [scriptingosx/Installomator](https://github.com/scriptingosx/Installomator) for the original software.

I recommend to install the two scripts in /usr/local/bin, that folder is included in PATH, so the script can be called without path. The two scripts with “app” in the name is the script, that should be inside Mosyle Manager.

## Also, for this version
Your production and deployment environment will be different, please test thoroughly before rolling it out to your production.

I have put a lot of work into making it stable and safe, but I cannot - of course - make _any_ promises that it won't break in some not yet encountered edge case.
