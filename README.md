# Installomator (Theile fork)

## This fork is obsolete

I will not be updating this fork of Installomator any more. It does not make sence.

I recommend using the original [Installomator/Installomator](https://github.com/Installomator/Installomator) version 8.0 and forward.

Remember to remove this fork, when you start using the original:
```
pkgutil --forget "dk.theilgaard.pkg.Installomator"
rm /usr/local/bin/Installomator.sh
rm /usr/local/bin/InstallomatorLabels.sh
```

## Important Note for version 0.7.0 and 0.7.1

**This release is identical to the original fork. I will not maintain this any further.**

MDM scripts has moved to the original fork as well.

If you update Installomator by calling the label `installomator` or `installomator_theile` you will now get the original fork of this.

### The script `Installomator.sh` has moved!

It was in `/usr/local/bin`, but is now in `/usr/local/Installomator/Installomator.sh` and consist of only one script (all labels will be part of the script).

### Original fork now has all my additions

As I'm a member of the team developing the original installomator, all the special features of this fork has now been included in the original.

_See the original [Installomator/Installomator](https://github.com/Installomator/Installomator) for what changes has happened, as it’s a completely different build-method that has been implemented and the script is now in fragments, for much easier maintenance and easier handling of labels. And the build mechanism can also build a pkg that will be signed and notarized, so you can do all this yourself._

### Thanks

I'm proud to have maintained this fork, and maybe even more proud to have my additions included in the original fork, so it will now be even better.

**Thanks to everybody in the Mac community!**

## Support and Contributing

Discussion, support and advice around Installomator happens in the `#installomator` channel in the [MacAdmins.org Slack](https://macadmins.org). Go there for support questions.

Do not create an issue just when you have a questions, but do file an issue or pull request (PR) for bugs or wrong behavior. When in doubt, ask in the above Slack channel.

Please see [CONTRIBUTING.md](https://github.com/Installomator/Installomator/blob/dev/CONTRIBUTING.md) for how to contribute to the original version, or see [CONTRIBUTING.md](https://github.com/Theile/Installomator/blob/dev/CONTRIBUTING.md) for filing bug reports on this project.

## Original description

_The one installer script to rule them all._

![](https://img.shields.io/github/v/release/Theile/Installomator)&nbsp;![](https://img.shields.io/github/downloads/Theile/Installomator/latest/total)&nbsp;![](https://img.shields.io/badge/macOS-10.14%2B-success)&nbsp;![](https://img.shields.io/github/license/Theile/Installomator)

This fork of installomator is for people that would like Installomator to be installed permanently on the client Macs. Then we can execute the script at various times to get software installed and updated.

This fork is not to be used like the original, that is built for Jamf Pro. 

This fork is for MDMs, that can sent only smaller scripts, maybe at specific times. It has been testet a lot with Mosyle Business and Manager, as well as with Addigy.

The purpose is to add a version check before download, and/or before installation, so only if an update exist, will it install the software. In this way it can run at regular intervals and only bug the user with update notifications if a new version is available.

Also this version should notify the user better, when they install apps themselves from the Self Service catalog (provided by some MDM providers).

I am also part of the team working on the original Installomator script.

_See [Installomator/Installomator](https://github.com/Installomator/Installomator) for the original software and README._

### Extra variables in labels

- `appNewVersion` (optional, but recommended):
Version of the downloaded software.
If given, it will be compared to installed version, to see if download is different.
It does not check for newer or not, only different.
Not always easy to figure out how to make this. Sometimes this is listed on the downloads page, sometimes in other places. And how can we isolate it in a genral manner? (See `abstract`, `bbedit`, `brave`, `desktoppr`, `googlechrome`, or `omnidisksweeper`).

- `packageID` (optional, but recommended for pkgs without an app)
This variable is for pkg bundle IDs. Very usefull if a pkg only install command line tools, or the like that does not install an app. (See label `desktoppr`, `golang`, `installomator_st`, `odrive`, or `teamviewerhost`).

I will try to add new labels when they are submittet to scriptingosx, and maybe I will see if I can create the `appNewVersion` and/or the `packageID` variable(s).


### Handling of blocking processes

Changed the process in the script when blocking processes are found, and added new actions. Default is `BLOCKING_PROCESS_ACTION=prompt_user_loop`.

__Options:__
- `ignore`: continue even when blocking processes are found.
- `silent_fail`: exit script without prompt or installation.
- `prompt_user`: show a user dialog for each blocking process found abort after three attempts to quit (only if user accepts to quit the apps, otherwise the update is cancelled).
- `prompt_user_then_kill`: show a user dialog for each blocking process found, attempt to quit two times, kill the process finally.
- `prompt_user_loop`: Like prompt-user, but clicking "Not Now", will just wait an hour, and then it will ask again. _Please note!_  It might block the agent on the machine, as the scripts gets stuct in waiting until the hour passed.
- `tell_user`: (Default) User will be showed a notification about the important update, but user is only allowed to quit and continue, and then we ask the app to quit.
- `tell_user_then_kill`: Show dialog 2 times, and if the quitting fails, the blocking processes will be killed.
- `kill`: kill process without prompting or giving the user a chance to save.

If any process was closed, Installomator will try to open the app again, after the update process is done. 


### Logo-icon in dialog boxes if app is blocking

Default is `LOGO=appstore`
__Options:__
- `appstore`: Icon is Apple App Store (default)
- `jamf`: JAMF Pro
- `mosyleb`: Mosyle Business
- `mosylem`: Mosyle Manager (Education)
- `addigy`: Addigy

A path can also be set in the command call, and if file exists, it will be used, like `LOGO="/System/Applications/App\ Store.app/Contents/Resources/AppIcon.icns"` (spaces are escaped).

### App Store apps handling
Default is `IGNORE_APP_STORE_APPS=no`
__options:__
- `no`: If installed app is from App Store (which include VPP installed apps) it will not be touched, no matter it's version (default)
- `yes`: Replace App Store (and VPP) version of app and handle future updates using Installomator, even if latest version. Shouldn’t give any problems for the user in most cases. Known bad example: Slack will loose all settings.

### Notification

Added a `NOTIFY` option `all`, so notifications can be shown to the user even if no upgrade is available, or if there is a failure in download. This is usable if the user click install in Self Service, then we want them to know, when we are done, no matter what happened. `success` is still default so `NOTIFY=all` needs to be added to the command to get all the notifications.

### Install behavior (force installation)

Also added an `INSTALL` variable to be set to `force` if you want the software to be installed even though it is already install in the latest version. Can at least be used to install the latest universal version, even if the Intel-only built is installed, if a label is improved for this. And I simply wanted to force installation, if that was needed.

### Re-opening of closed app

The `REOPEN` can be used to prevent the reopening of a closed app

- `yes`:   (default) app will be reopened if it was closed
- `no`:    app not reopened

### Extra scripts

The two scripts with `app` in the name is the script, that should be inside Mosyle Manager. They will test if Installomator.sh is installed, and run the command. The one script will cal the command with one label, the other script will loop through a bunch of labels. Rather streight forward. Note: Mosyle does not currently handle exit codes from scripts. Please request support for this from Mosyle!

## Installation

I have signed and notarized the pkg. And now you can update Installomator_ST from within Installomator itself.
`/usr/local/bin/Installomator.sh installomator_theile`

## Like the original Installomator, this text apply for this fork version:
Your production and deployment environment will be different, please test thoroughly before rolling it out to your production.

I have put a lot of work into making it stable and safe, but I cannot - of course - make _any_ promises that it won't break in some not yet encountered edge case.
