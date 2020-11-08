# Installomator (ST branch)

_The one installer script to rule them all._

![](https://img.shields.io/github/v/release/theile/Installomator)&nbsp;![](https://img.shields.io/github/downloads/theile/Installomator/latest/total)&nbsp;![](https://img.shields.io/badge/macOS-10.14%2B-success)&nbsp;![](https://img.shields.io/github/license/theile/Installomator)

This version of installomator is for people that would like Installomator to be installed permanently on the client Macs. Then we can execute the script at various times to get software installed and updated.

This version is not to be used like the original, that is built for Jamf Pro. 

This version is for MDMs, that can sent scripts, maybe at specific times. It has been testet a lot with Mosyle Business and Manager.

Purpose is to add a version check before download, and/or before installation, so only if an update exist, will it install the software. A new variable for the label has been introduced so if the version can be obtained from the web site or similar place, the script can evaluate very quickly if it needs an update.

See [scriptingosx/Installomator](https://github.com/scriptingosx/Installomator) for the original software and README.

I will try to add new labels when they are submittet to scriptingosx, and maybe I will see if I can create the appNewVersion content.

I have included a .pkgproj-file that will open in the app [Packages](http://s.sudre.free.fr/Software/Packages/about.html). So now you can build you own installer and deploy that to your machines. The package will install the two scripts in /usr/local/bin that is part of the PATH, which means that in Terminal ap you can use Installomator.sh as a command.

The two scripts with “app” in the name is the script, that should be inside Mosyle Manager. They will test if Installomator.sh is installed, and run the command. The one script will cal the command with one label, the other script will loop through a bunch of labels. Rather streight forward. Note: Mosyle does not currently handle exit codes from scripts. Please request support for this from Mosyle!

Changed the process in the script when blocking processes are found, and added new options. Default is “BLOCKING_PROCESS_ACTION=prompt_user”

Options:
- ignore: continue even when blocking processes are found
- silent_fail: exit script without prompt or installation
- prompt_user: show a user dialog for each blocking process found abort after three attempts to quit (only if user accepts to quit the apps, otherwise the update is cancelled).
- prompt_user_then_kill: show a user dialog for each blocking process found, attempt to quit two times, kill the process finally
- prompt_user_loop: Like prompt-user, but clicking "Not Now", will just wait an hour, and then it will ask again.
- tell_user: User will be showed a notification about the important update, but user is only allowed to quit and continue, and then we ask the app to quit.
- tell_user_then_kill: Show dialog 2 times, and if the quitting fails, the blocking processes will be killed.
- kill: kill process without prompting or giving the user a chance to save

## Also, for this version
Your production and deployment environment will be different, please test thoroughly before rolling it out to your production.

I have put a lot of work into making it stable and safe, but I cannot - of course - make _any_ promises that it won't break in some not yet encountered edge case.
