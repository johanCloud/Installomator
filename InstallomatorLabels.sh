#!/bin/zsh

# InstallomatorLabels file
# Implemented by Søren Theilgaard (@theilgaard)
# Keep the name of this file, and put it next to Installomator

labelsVERSION="0.4.17"

# MARK: labels in case statement
caseLabel () {
case $label in
version)
    # print the script VERSION
    printlog "$VERSION"
    exit 0
    ;;
longversion)
    # print the script version
    printlog "Installomator location:"
    printlog "${SELFLOCATION}/${SELF}"
    printlog "Labels file:"
    printlog "$labelFile"
    printlog "Version $VERSION ($VERSIONDATE), branch $VERSIONBRANCH, Labels file version $labelsVERSION"
    exit 0
    ;;

# label descriptions start here
autodmg)
    # credit: Mischa van der Bent (@mischavdbent)
    name="AutoDMG"
    type="dmg"
    downloadURL=$(downloadURLFromGit MagerValp AutoDMG)
    appNewVersion=$(versionFromGit MagerValp AutoDMG)
    expectedTeamID="5KQ3D3FG5H"
    ;;
googlechrome)
    name="Google Chrome"
    type="dmg"
    if [[ $(arch) != "i386" ]]; then
        printlog "Architecture: arm64 (not i386)"
        downloadURL="https://dl.google.com/chrome/mac/universal/stable/GGRO/googlechrome.dmg"
    else
        printlog "Architecture: i386"
        downloadURL="https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
    fi
    appNewVersion=$(curl -s https://omahaproxy.appspot.com/history | awk -F',' '/mac,stable/{print $3; exit}') # Credit: William Smith (@meck)
    expectedTeamID="EQHXZ8M8AV"
    ;;
googlechromepkg)
    name="Google Chrome"
    type="pkg"
    #
    # Note: this url acknowledges that you accept the terms of service
    # https://support.google.com/chrome/a/answer/9915669
    #
    downloadURL="https://dl.google.com/chrome/mac/stable/accept_tos%3Dhttps%253A%252F%252Fwww.google.com%252Fintl%252Fen_ph%252Fchrome%252Fterms%252F%26_and_accept_tos%3Dhttps%253A%252F%252Fpolicies.google.com%252Fterms/googlechrome.pkg"
    expectedTeamID="EQHXZ8M8AV"
    updateTool="/Library/Google/GoogleSoftwareUpdate/GoogleSoftwareUpdate.bundle/Contents/Resources/GoogleSoftwareUpdateAgent.app/Contents/MacOS/GoogleSoftwareUpdateAgent"
    updateToolArguments=( -runMode oneshot -userInitiated YES )
    updateToolRunAsCurrentUser=1
    ;;
googlejapaneseinput)
    # credit: Tadayuki Onishi (@kenchan0130)
    name="GoogleJapaneseInput"
    type="pkgInDmg"
    pkgName="GoogleJapaneseInput.pkg"
    downloadURL="https://dl.google.com/japanese-ime/latest/GoogleJapaneseInput.dmg"
    expectedTeamID="EQHXZ8M8AV"
    ;;
santa)
    # credit: Tadayuki Onishi (@kenchan0130)
    name="Santa"
    type="pkgInDmg"
    downloadURL=$(downloadURLFromGit google santa)
    appNewVersion=$(versionFromGit google santa)
    expectedTeamID="EQHXZ8M8AV"
    ;;
spotify)
    name="Spotify"
    type="dmg"
    downloadURL="https://download.scdn.co/Spotify.dmg"
    # appNewVersion=$(curl -fs https://www.spotify.com/us/opensource/ | cat | grep -o "<td>.*.</td>" | head -1 | cut -d ">" -f2 | cut -d "<" -f1) # does not result in the same version as downloaded
    expectedTeamID="2FNC3A47ZF"
    ;;
bbedit)
    name="BBEdit"
    type="dmg"
    downloadURL=$(curl -s https://versioncheck.barebones.com/BBEdit.xml | grep dmg | sort | tail -n1 | cut -d">" -f2 | cut -d"<" -f1)
    appNewVersion=$(curl -s https://versioncheck.barebones.com/BBEdit.xml | grep dmg | sort  | tail -n1 | sed -E 's/.*BBEdit_([0-9 .]*)\.dmg.*/\1/')
    expectedTeamID="W52GZAXT98"
    ;;
firefox)
    name="Firefox"
    type="dmg"
    downloadURL="https://download.mozilla.org/?product=firefox-latest&os=osx&lang=en-US"
    appNewVersion=$(/usr/bin/curl https://www.mozilla.org/en-US/firefox/releases/ --silent | /usr/bin/grep '<html' | /usr/bin/awk -F\" '{ print $8 }') # Credit: William Smith (@meck)
    expectedTeamID="43AQ936H96"
    blockingProcesses=( firefox )
    ;;
firefox_da)
    name="Firefox"
    type="dmg"
    downloadURL="https://download.mozilla.org/?product=firefox-latest&amp;os=osx&amp;lang=da"
    appNewVersion=$(/usr/bin/curl https://www.mozilla.org/en-US/firefox/releases/ --silent | /usr/bin/grep '<html' | /usr/bin/awk -F\" '{ print $8 }') # Credit: William Smith (@meck)
    expectedTeamID="43AQ936H96"
    blockingProcesses=( firefox )
    ;;
firefoxpkg)
    name="Firefox"
    type="pkg"
    downloadURL="https://download.mozilla.org/?product=firefox-pkg-latest-ssl&os=osx&lang=en-US"
    expectedTeamID="43AQ936H96"
    blockingProcesses=( firefox )
    ;;
firefoxesrpkg)
    name="Firefox"
    type="pkg"
    downloadURL="https://download.mozilla.org/?product=firefox-esr-pkg-latest-ssl&os=osx"
    expectedTeamID="43AQ936H96"
    blockingProcesses=( firefox )
    ;;
whatsapp)
    name="WhatsApp"
    type="dmg"
    downloadURL="https://web.whatsapp.com/desktop/mac/files/WhatsApp.dmg"
    expectedTeamID="57T9237FN3"
    ;;
desktoppr)
    name="desktoppr"
    type="pkg"
    downloadURL=$(downloadURLFromGit "scriptingosx" "desktoppr")
    appNewVersion=$(versionFromGit "scriptingosx" "desktoppr")
    expectedTeamID="JME5BW3F3R"
    blockingProcesses=( NONE )
    ;;
malwarebytes)
    name="Malwarebytes"
    type="pkg"
    downloadURL="https://downloads.malwarebytes.com/file/mb3-mac"
    appNewVersion=$(curl -Ifs https://downloads.malwarebytes.com/file/mb3-mac | grep "location" | sed -E 's/.*-Mac-([0-9\.]*)\.pkg/\1/g')
    expectedTeamID="GVZRY6KDKR"
    ;;
suspiciouspackage)
    # credit: Mischa van der Bent (@mischavdbent)
    name="Suspicious Package"
    type="dmg"
    downloadURL="https://mothersruin.com/software/downloads/SuspiciousPackage.dmg"
    addNewVersion=$(curl -fs https://mothersruin.com/software/SuspiciousPackage/get.html | grep 'class="version"' | sed -E 's/.*>([0-9\.]*) \(.*/\1/g')
    expectedTeamID="936EB786NH"
    ;;
atom)
    name="Atom"
    type="zip"
    archiveName="atom-mac.zip"
    downloadURL=$(downloadURLFromGit atom atom )
    appNewVersion=$(versionFromGit atom atom)
    expectedTeamID="VEKTX9H2N7"
    ;;
eraseinstall)
    name="EraseInstall"
    type="pkg"
    downloadURL=https://bitbucket.org$(curl -fs https://bitbucket.org/prowarehouse-nl/erase-install/downloads/ | grep pkg | cut -d'"' -f2 | head -n 1)
    expectedTeamID="R55HK5K86Y"
    ;;
omnigraffle6)
    name="OmniGraffle"
    type="dmg"
    downloadURL=$(curl -fs "https://update.omnigroup.com/appcast/com.omnigroup.OmniGraffle6" | xpath '//rss/channel/item[1]/enclosure[1]/@url' 2>/dev/null | cut -d '"' -f 2)
    appNewVersion=$( echo "${downloadURL}" | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g' )
    expectedTeamID="34YW5XSRB7"
    ;;
omnigraffle7)
    name="OmniGraffle"
    type="dmg"
    downloadURL=$(curl -fs "https://update.omnigroup.com/appcast/com.omnigroup.OmniGraffle7" | xpath '//rss/channel/item[1]/enclosure[1]/@url' 2>/dev/null | cut -d '"' -f 2)
    appNewVersion=$( echo "${downloadURL}" | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g' )
    expectedTeamID="34YW5XSRB7"
    ;;
omnifocus3)
    name="OmniFocus"
    type="dmg"
    downloadURL=$(curl -fs "https://update.omnigroup.com/appcast/com.omnigroup.OmniFocus3" | xpath '//rss/channel/item[1]/enclosure[1]/@url' 2>/dev/null | head -1 | cut -d '"' -f 2)
    appNewVersion=$( echo "${downloadURL}" | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g' )
    expectedTeamID="34YW5XSRB7"
    ;;
omnioutliner5)
    name="OmniOutliner"
    type="dmg"
    downloadURL=$(curl -fs "https://update.omnigroup.com/appcast/com.omnigroup.OmniOutliner5" | xpath '//rss/channel/item[1]/enclosure[1]/@url' 2>/dev/null | head -1 | cut -d '"' -f 2)
    appNewVersion=$( echo "${downloadURL}" | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g' )
    expectedTeamID="34YW5XSRB7"
    ;;
omniplan3)
    name="OmniPlan"
    type="dmg"
    downloadURL=$(curl -fs "https://update.omnigroup.com/appcast/com.omnigroup.OmniPlan3" | xpath '//rss/channel/item[1]/enclosure[1]/@url' 2>/dev/null | head -1 | cut -d '"' -f 2)
    appNewVersion=$( echo "${downloadURL}" | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g' )
    expectedTeamID="34YW5XSRB7"
    ;;
omnipresence)
    name="OmniPresence"
    type="dmg"
    downloadURL=$(curl -fs "https://update.omnigroup.com/appcast/com.omnigroup.OmniPresence" | xpath '//rss/channel/item[1]/enclosure[1]/@url' 2>/dev/null | head -1 | cut -d '"' -f 2)
    appNewVersion=$( echo "${downloadURL}" | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g' )
    expectedTeamID="34YW5XSRB7"
    ;;
omnidisksweeper)
    name="OmniDiskSweeper"
    type="dmg"
    downloadURL=$(curl -fs "https://update.omnigroup.com/appcast/com.omnigroup.OmniDiskSweeper" | xpath '//rss/channel/item[1]/enclosure[1]/@url' 2>/dev/null | head -1 | cut -d '"' -f 2)
    appNewVersion=$( echo "${downloadURL}" | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g' )
    expectedTeamID="34YW5XSRB7"
    ;;
vlc)
    name="VLC"
    type="dmg"
    downloadURL=$(curl -fs http://update.videolan.org/vlc/sparkle/vlc-intel64.xml \
        | xpath '//rss/channel/item[last()]/enclosure/@url' 2>/dev/null | cut -d '"' -f 2 )
    appNewVersion=$(curl -fs http://update.videolan.org/vlc/sparkle/vlc-intel64.xml | xpath '//rss/channel/item[last()]/enclosure/@sparkle:version' 2>/dev/null | cut -d '"' -f 2 )
    expectedTeamID="75GAHG3SZQ"
    ;;
textmate)
    name="TextMate"
    type="tbz"
    #downloadURL="https://api.textmate.org/downloads/release?os=10.12"
    downloadURL=$(downloadURLFromGit "textmate" "textmate")
    appNewVersion=$(versionFromGit "textmate" "textmate")
    expectedTeamID="45TL96F76G"
    ;;
depnotify)
    name="DEPNotify"
    type="zip"
    downloadURL="https://files.nomad.menu/DEPNotify.zip"
    expectedTeamID="VRPY9KHGX6"
    targetDir="/Applications/Utilities"
    ;;
tunnelbear)
    name="TunnelBear"
    type="zip"
    downloadURL="https://s3.amazonaws.com/tunnelbear/downloads/mac/TunnelBear.zip"
    expectedTeamID="P2PHZ9K5JJ"
    ;;
sourcetree)
    name="Sourcetree"
    type="zip"
    downloadURL=$(curl -fs https://product-downloads.atlassian.com/software/sourcetree/Appcast/SparkleAppcastAlpha.xml \
        | xpath '//rss/channel/item[last()]/enclosure/@url' 2>/dev/null \
        | cut -d '"' -f 2 )
    appNewVersion=$(curl -fs https://product-downloads.atlassian.com/software/sourcetree/Appcast/SparkleAppcastAlpha.xml | xpath '//rss/channel/item[last()]/title' 2>/dev/null | sed -n -e 's/^.*Version //p' | sed 's/\<\/title\>//' | sed $'s/[^[:print:]\t]//g')
    expectedTeamID="UPXU4CQZ5P"
    ;;
boxdrive)
    # credit: Isaac Ordonez, Mann consulting (@mannconsulting)
    name="Box"
    type="pkg"
    downloadURL="https://e3.boxcdn.net/box-installers/desktop/releases/mac/Box.pkg"
    expectedTeamID="M683GB7CPW"
    ;;
aviatrix)
    # credit: Isaac Ordonez, Mann consulting (@mannconsulting)
    name="Aviatrix VPN Client"
    type="pkg"
    downloadURL="https://s3-us-west-2.amazonaws.com/aviatrix-download/AviatrixVPNClient/AVPNC_mac.pkg"
    expectedTeamID="32953Z7NBN"
    ;;
zoom)
    # credit: Isaac Ordonez, Mann consulting (@mannconsulting)
    name="Zoom.us"
    type="pkg"
    downloadURL="https://zoom.us/client/latest/ZoomInstallerIT.pkg"
    appNewVersion=$(curl -fs -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15)" "https://zoom.us/download" | grep Version | head -n 1 | sed -E 's/.* ([0-9.]* \(.*\)).*/\1/') # credit: Søren Theilgaard (@theilgaard)
    expectedTeamID="BJ4HAAB9B3"
    blockingProcesses=( zoom.us )
    ;;
sonos|\
sonoss1)
    # credit: Erik Stam (@erikstam)
    name="Sonos S1 Controller"
    type="dmg"
    downloadURL="https://www.sonos.com/redir/controller_software_mac"
    expectedTeamID="2G4LW83Q3E"
    ;;
sonoss2)
    name="Sonos"
    type="dmg"
    downloadURL="https://www.sonos.com/redir/controller_software_mac2"
    expectedTeamID="2G4LW83Q3E"
    ;;
coderunner)
    # credit: Erik Stam (@erikstam)
    name="CodeRunner"
    type="zip"
    downloadURL="https://coderunnerapp.com/download"
    expectedTeamID="R4GD98AJF9"
    ;;
openvpnconnect)
    # credit: Erik Stam (@erikstam)
    name="OpenVPN"
    type="pkgInDmg"
    pkgName="OpenVPN_Connect_Installer_signed.pkg"
    downloadURL="https://openvpn.net/downloads/openvpn-connect-v2-macos.dmg"
    expectedTeamID="ACV7L3WCD8"
    ;;
openvpnconnectv3)
    # credit: @lotnix
    name="OpenVPN Connect"
    type="pkgInDmg"
    downloadURL="https://openvpn.net/downloads/openvpn-connect-v3-macos.dmg"
    expectedTeamID="ACV7L3WCD8"
    ;;
pacifist)
    name="Pacifist"
    type="dmg"
    downloadURL="https://charlessoft.com/cgi-bin/pacifist_download.cgi?type=dmg"
    expectedTeamID="HRLUCP7QP4"
    ;;
1password7)
    name="1Password 7"
    type="pkg"
    downloadURL="https://app-updates.agilebits.com/download/OPM7"
    appNewVersion=$( curl -fsIL "${downloadURL}" | grep -i "^location" | awk '{print $2}' | sed -E 's/.*\/[0-9a-zA-Z]*-([0-9.]*)\..*/\1/g' )
    expectedTeamID="2BUA8C4S2C"
    ;;
webexmeetings)
    # credit: Erik Stam (@erikstam)
    name="Cisco Webex Meetings"
    type="pkgInDmg"
    downloadURL="https://akamaicdn.webex.com/client/webexapp.dmg"
    expectedTeamID="DE8Y96K9QP"
    ;;
webexteams)
    # credit: Erik Stam (@erikstam)
    name="Webex Teams"
    type="dmg"
    downloadURL="https://binaries.webex.com/WebexTeamsDesktop-MACOS-Gold/WebexTeams.dmg"
    expectedTeamID="DE8Y96K9QP"
    ;;
citrixworkspace)
    #credit: Erik Stam (@erikstam) and #Philipp on MacAdmins Slack
    name="Citrix Workspace"
    type="pkgInDmg"
    downloadURL="https:"$(curl -s -L "https://www.citrix.com/downloads/workspace-app/mac/workspace-app-for-mac-latest.html#ctx-dl-eula-external" | grep "dmg?" | sed "s/.*rel=.\(.*\)..id=.*/\1/") # http://downloads.citrix.com/18823/CitrixWorkspaceApp.dmg?__gda__=1605791892_edc6786a90eb5197fb226861a8e27aa8
    appNewVersion=$(curl -fs https://www.citrix.com/downloads/workspace-app/mac/workspace-app-for-mac-latest.html | grep "<p>Version" | head -1 | cut -d " " -f1 | cut -d ";" -f2 | cut -d "." -f 1-3)
    expectedTeamID="S272Y5R93J"
    ;;
privileges)
    # credit: Erik Stam (@erikstam)
    name="Privileges"
    type="zip"
    downloadURL=$(downloadURLFromGit sap macOS-enterprise-privileges )
    appNewVersion=$(versionFromGit sap macOS-enterprise-privileges )
    expectedTeamID="7R5ZEU67FQ"
    ;;
icons)
    # credit: Mischa van der Bent (@mischavdbent)
    name="Icons"
    type="zip"
    downloadURL=$(downloadURLFromGit sap macOS-icon-genera   )
    appNewVersion=$(versionFromGit sap macOS-icon-generator )
    expectedTeamID="7R5ZEU67FQ"
    ;;
googledrivefilestream)
    # credit: Isaac Ordonez, Mann consulting (@mannconsulting)
    name="Google Drive File Stream"
    type="pkgInDmg"
    downloadURL="https://dl.google.com/drive-file-stream/GoogleDriveFileStream.dmg"
    pkgName="GoogleDriveFileStream.pkg"
    expectedTeamID="EQHXZ8M8AV"
    ;;
plisteditpro)
    name="PlistEdit Pro"
    type="zip"
    downloadURL="https://www.fatcatsoftware.com/plisteditpro/PlistEditPro.zip"
    expectedTeamID="8NQ43ND65V"
    ;;
slack)
    name="Slack"
    type="dmg"
    downloadURL="https://slack.com/ssb/download-osx"
    expectedTeamID="BQR82RBBHL"
    ;;
sublimetext)
    # credit: Mischa van der Bent (@mischavdbent)
    name="Sublime Text"
    type="dmg"
    downloadURL="https://download.sublimetext.com/latest/stable/osx"
    appNewVersion=$(curl -fs https://www.sublimetext.com/3 | grep 'class="latest"' | cut -d '>' -f 4 | sed -E 's/ (.*[0-9]*)<.*/\1/g')
    #appNewVersion=$(curl -Is https://download.sublimetext.com/latest/stable/osx | grep "Location:" | sed -n -e 's/^.*Sublime Text //p' | sed 's/.dmg//g' | sed $'s/[^[:print:]\t]//g') # Alternative from @Oh4sh0
    expectedTeamID="Z6D26JE4Y4"
    ;;
githubdesktop)
    name="GitHub Desktop"
    type="zip"
    downloadURL="https://central.github.com/deployments/desktop/desktop/latest/darwin"
    appNewVersion=$(curl -fsL https://central.github.com/deployments/desktop/desktop/changelog.json | awk -F '{' '/"version"/ { print $2 }' | sed -E 's/.*,\"version\":\"([0-9.]*)\".*/\1/g')
    expectedTeamID="VEKTX9H2N7"
    ;;
things)
    name="Things"
    type="zip"
    downloadURL="https://culturedcode.com/things/download/"
    expectedTeamID="JLMPQHK86H"
    ;;
discord)
    name="Discord"
    type="dmg"
    downloadURL="https://discordapp.com/api/download?platform=osx"
    expectedTeamID="53Q6R32WPB"
    ;;
grandperspective)
    name="GrandPerspective"
    type="dmg"
    downloadURL="https://sourceforge.net/projects/grandperspectiv/files/latest/download"
    expectedTeamID="3Z75QZGN66"
    ;;
handbrake)
    name="HandBrake"
    type="dmg"
    downloadURL=$(curl --silent --fail "https://api.github.com/repos/HandBrake/HandBrake/releases/latest" \
        | awk -F '"' "/browser_download_url/ && /dmg/ && ! /sig/ && ! /CLI/ { print \$4 }")
    appNewVersion=$(curl -sf "https://api.github.com/repos/HandBrake/HandBrake/releases/latest" | awk -F '"' "/tag_name/ { print \$4 }")
    expectedTeamID="5X9DE89KYV"
    ;;
netnewswire)
    name="NetNewsWire"
    type="zip"
    downloadURL=$(curl -fs https://ranchero.com/downloads/netnewswire-release.xml \
        | xpath '//rss/channel/item[1]/enclosure/@url' 2>/dev/null | cut -d '"' -f 2)
    appNewVersion=$(curl -fs https://ranchero.com/downloads/netnewswire-release.xml | xpath '//rss/channel/item[1]/enclosure/@sparkle:shortVersionString' 2>/dev/null | cut -d '"' -f 2)
    expectedTeamID="M8L2WTLA8W"
    ;;
resiliosynchome)
    name="Resilio Sync"
    type="dmg"
    downloadURL="https://download-cdn.resilio.com/stable/osx/Resilio-Sync.dmg"
    expectedTeamID="2953Z5SZSK"
    ;;
cyberduck)
    name="Cyberduck"
    type="zip"
    downloadURL=$(curl -fs https://version.cyberduck.io/changelog.rss | xpath '//rss/channel/item/enclosure/@url' 2>/dev/null | cut -d '"' -f 2 )
    appNewVersion=$(curl -fs https://version.cyberduck.io/changelog.rss | xpath '//rss/channel/item/enclosure/@sparkle:shortVersionString' 2>/dev/null | cut -d '"' -f 2 )
    expectedTeamID="G69SCX94XU"
    ;;
dropbox)
    name="Dropbox"
    type="dmg"
    downloadURL="https://www.dropbox.com/download?plat=mac&full=1"
    expectedTeamID="G7HH3F8CAK"
    ;;
teamviewer)
    name="TeamViewer"
    type="pkgInDmg"
    pkgName="Install TeamViewer.pkg"
    downloadURL="https://download.teamviewer.com/download/TeamViewer.dmg"
    expectedTeamID="H7UGFBUGV6"
    ;;
iterm2)
    name="iTerm"
    type="zip"
    downloadURL="https://iterm2.com/downloads/stable/latest"
    appNewVersion=$(curl -is https://iterm2.com/downloads/stable/latest | grep location: | grep -o "iTerm2.*zip" | cut -d "-" -f 2 | cut -d '.' -f1 | sed 's/_/./g')
    expectedTeamID="H7V7XYVQ7D"
    blockingProcesses=( iTerm2 )
    ;;
royaltsx)
    name="Royal TSX"
    type="dmg"
    downloadURL=$(curl -fs https://royaltsx-v4.royalapps.com/updates_stable | xpath '//rss/channel/item[1]/enclosure/@url'  2>/dev/null | cut -d '"' -f 2)
    appNewVersion=$(curl -fs https://royaltsx-v4.royalapps.com/updates_stable | xpath '//rss/channel/item[1]/enclosure/@sparkle:shortVersionString'  2>/dev/null | cut -d '"' -f 2)
    expectedTeamID="VXP8K9EDP6"
    ;;
appcleaner)
    # credit: Tadayuki Onishi (@kenchan0130)
    name="AppCleaner"
    type="zip"
    downloadURL=$(curl -fs https://freemacsoft.net/appcleaner/Updates.xml | xpath '//rss/channel/*/enclosure/@url' 2>/dev/null | tr " " "\n" | sort | tail -1 | cut -d '"' -f 2)
    expectedTeamID="X85ZX835W9"
    ;;
karabinerelements)
    # credit: Tadayuki Onishi (@kenchan0130)
    name="Karabiner-Elements"
    type="pkgInDmg"
    downloadURL=$(downloadURLFromGit pqrs-org Karabiner-Elements)
    appNewVersion=$(versionFromGit pqrs-org Karabiner-Elements)
    expectedTeamID="G43BCU2T37"
    ;;
postman)
    # credit: Mischa van der Bent
    name="Postman"
    type="zip"
    downloadURL="https://dl.pstmn.io/download/latest/osx"
    appNewVersion=$(curl -Ifs https://dl.pstmn.io/download/latest/osx | grep "content-disposition:" | sed -n -e 's/^.*Postman-osx-//p' | sed 's/\.zip//' | sed $'s/[^[:print:]\t]//g' )
    expectedTeamID="H7H8Q7M5CK"
    ;;
jamfpppcutility)
    # credit: Mischa van der Bent
    name="PPPC Utility"
    type="zip"
    downloadURL=$(downloadURLFromGit jamf PPPC-Utility)
    appNewVersion=$(versionFromGit jamf PPPC-Utility)
    expectedTeamID="483DWKW443"
    ;;
jamfmigrator)
    # credit: Mischa van der Bent
    name="jamf-migrator"
    type="zip"
    downloadURL=$(downloadURLFromGit jamf JamfMigrator)
    appNewVersion=$(versionFromGit jamf JamfMigrator)
    expectedTeamID="PS2F6S478M"
    ;;
jamfreenroller)
    # credit: Mischa van der Bent
    name="ReEnroller"
    type="zip"
    downloadURL=$(downloadURLFromGit jamf ReEnroller)
    appNewVersion=$(versionFromGit jamf ReEnroller)
    expectedTeamID="PS2F6S478M"
    ;;
adobereaderdc|\
adobereaderdc-install)
    name="Adobe Acrobat Reader DC"
    type="pkgInDmg"
    downloadURL=$(curl --silent --fail -H "Sec-Fetch-Site: same-origin" -H "Accept-Encoding: gzip, deflate, br" -H "Accept-Language: en-US;q=0.9,en;q=0.8" -H "DNT: 1" -H "Sec-Fetch-Mode: cors" -H "X-Requested-With: XMLHttpRequest" -H "Referer: https://get.adobe.com/reader/enterprise/" -H "Accept: */*" "https://get.adobe.com/reader/webservices/json/standalone/?platform_type=Macintosh&platform_dist=OSX&platform_arch=x86-32&language=English&eventname=readerotherversions" | grep -Eo '"download_url":.*?[^\\]",' | head -n 1 | cut -d \" -f 4)
    appNewVersion=$(curl -s -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15)" https://get.adobe.com/reader/ | grep "<strong>Version" | sed 's/[^0-9 .]*//g' | awk '{print $1}') # credit: Søren Theilgaard (@theilgaard)
    expectedTeamID="JQ525L2MZD"
    blockingProcesses=( "AdobeReader" )
    ;;
adobereaderdc-update)
    name="Adobe Acrobat Reader DC"
    type="pkgInDmg"
    downloadURL=$(adobecurrent=`curl --fail --silent https://armmf.adobe.com/arm-manifests/mac/AcrobatDC/reader/current_version.txt | tr -d '.'` && echo http://ardownload.adobe.com/pub/adobe/reader/mac/AcrobatDC/"$adobecurrent"/AcroRdrDCUpd"$adobecurrent"_MUI.dmg)
    appNewVersion=$(curl -s -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15)" https://get.adobe.com/reader/ | grep "<strong>Version" | sed 's/[^0-9 .]*//g' | awk '{print $1}') # credit: Søren Theilgaard (@theilgaard)
    expectedTeamID="JQ525L2MZD"
    blockingProcesses=( "AdobeReader" )
    ;;
signal)
    # credit: Søren Theilgaard (@theilgaard)
    name="Signal"
    type="dmg"
    downloadURL=https://updates.signal.org/desktop/$(curl -fs https://updates.signal.org/desktop/latest-mac.yml | awk '/url/ && /dmg/ {print $3}')
    appNewVersion=$(curl -fs https://updates.signal.org/desktop/latest-mac.yml | grep version | awk '{print $2}')
    expectedTeamID="U68MSDN6DR"
    ;;
docker)
    # credit: @securitygeneration
    name="Docker"
    type="dmg"
    downloadURL="https://download.docker.com/mac/stable/Docker.dmg"
    appNewVersion=$(curl -ifs https://docs.docker.com/docker-for-mac/release-notes/ | grep ">Docker Desktop Community" | head -1 | sed -n -e 's/^.*Community //p' | cut -d '<' -f1)
    expectedTeamID="9BNSXJN65R"
    ;;
brave)
    # credit: @securitygeneration
    name="Brave Browser"
    type="dmg"
    if [[ $(arch) != "i386" ]]; then
        printlog "Architecture: arm64 (not i386)"
        downloadURL=$(curl -fsIL https://laptop-updates.brave.com/latest/osxarm64/release | grep -i "^location" | awk '{print $2}' | tr -d '\r\n')
    else
        printlog "Architecture: i386"
        downloadURL=$(curl -fsIL https://laptop-updates.brave.com/latest/osx/release | grep -i "^location" | awk '{print $2}' | tr -d '\r\n')
    fi
#    downloadURL=$(curl --location --fail --silent "https://updates.bravesoftware.com/sparkle/Brave-Browser/stable/appcast.xml" | xpath '//rss/channel/item[last()]/enclosure/@url' 2>/dev/null  | cut -d '"' -f 2)
    appNewVersion=$(curl --location --fail --silent "https://updates.bravesoftware.com/sparkle/Brave-Browser/stable/appcast.xml" | xpath '//rss/channel/item[last()]/enclosure/@sparkle:shortVersionString' 2>/dev/null  | cut -d '"' -f 2)
    expectedTeamID="KL8N8XSYF4"
    ;;
umbrellaroamingclient)
    # credit: Tadayuki Onishi (@kenchan0130)
    name="Umbrella Roaming Client"
    type="pkgInZip"
    downloadURL=https://disthost.umbrella.com/roaming/upgrade/mac/production/$( curl -fsL https://disthost.umbrella.com/roaming/upgrade/mac/production/manifest.json | awk -F '"' '/"downloadFilename"/ { print $4 }' )
    expectedTeamID="7P7HQ8H646"
    ;;
# TODO: vmwarefusion installation process needs testing
# vmwarefusion)
#     # credit: Erik Stam (@erikstam)
#     name="VMware Fusion"
#     type="dmg"
#     downloadURL="https://www.vmware.com/go/getfusion"
#     appNewVersion=$( curl -fsIL "${downloadURL}" | grep -i "^location" | awk '{print $2}' | sed -E 's/.*Fusion-([0-9.]*)-.*/\1/g' )
#     expectedTeamID="EG7KH642X6"
#     ;;

# NOTE: powershell installers are not notarized
# powershell)
#     # credit: Tadayuki Onishi (@kenchan0130)
#     name="PowerShell"
#     type="pkg"
#     downloadURL=$(curl -fs "https://api.github.com/repos/Powershell/Powershell/releases/latest" \
#     | awk -F '"' '/browser_download_url/ && /pkg/ { print $4 }' | grep -v lts )
#     expectedTeamID="UBF8T346G9"
#     ;;
# powershell-lts)
#     # credit: Tadayuki Onishi (@kenchan0130)
#     name="PowerShell"
#     type="pkg"
#     downloadURL=$(curl -fs "https://api.github.com/repos/Powershell/Powershell/releases/latest" \
#     | awk -F '"' '/browser_download_url/ && /pkg/ { print $4 }' | grep lts)
#     expectedTeamID="UBF8T346G9"
#     ;;

#wwdcformac) # this label looks like software/site is gone
#    name="WWDC"
#    type="zip"
#    downloadURL="https://cdn.wwdc.io/WWDC_latest.zip"
#    expectedTeamID="8C7439RJLG"
#    ;;
ringcentralmeetings)
    # credit: Isaac Ordonez, Mann consulting (@mannconsulting)
    name="Ring Central Meetings"
    type="pkg"
    downloadURL="http://dn.ringcentral.com/data/web/download/RCMeetings/1210/RCMeetingsClientSetup.pkg"
    expectedTeamID="M932RC5J66"
    blockingProcesses=( "RingCentral Meetings" )
    ;;
ringcentralapp)
    # credit: Isaac Ordonez, Mann consulting (@mannconsulting)
    name="Glip"
    type="dmg"
    downloadURL="https://downloads.ringcentral.com/glip/rc/GlipForMac"
    expectedTeamID="M932RC5J66"
    blockingProcesses=( "Glip" )
    ;;
sfsymbols)
    name="SF Symbols"
    type="pkgInDmg"
    downloadURL="https://developer.apple.com/design/downloads/SF-Symbols.dmg"
    expectedTeamID="Software Update"
    ;;
swiftruntimeforcommandlinetools)
    # Note: this installer will error on macOS versions later than 10.14.3
    name="SwiftRuntimeForCommandLineTools"
    type="pkgInDmg"
    downloadURL="https://updates.cdn-apple.com/2019/cert/061-41823-20191025-5efc5a59-d7dc-46d3-9096-396bb8cb4a73/SwiftRuntimeForCommandLineTools.dmg"
    expectedTeamID="Software Update"
    ;;
aquaskk)
    # credit: Tadayuki Onishi (@kenchan0130)
    name="aquaskk"
    type="pkg"
    downloadURL="$(downloadURLFromGit codefirst aquaskk)"
    expectedTeamID="FPZK4WRGW7"
    ;;
krisp)
    # credit: Tadayuki Onishi (@kenchan0130)
    name="Krisp"
    type="pkg"
    downloadURL="https://download.krisp.ai/mac"
    expectedTeamID="U5R26XM5Z2"
    ;;
torbrowser)
    # credit: Søren Theilgaard (@theilgaard)
    name="Tor Browser"
    type="dmg"
    downloadURL=https://www.torproject.org$(curl -fs https://www.torproject.org/download/ | grep "downloadLink" | grep dmg | head -1 | cut -d '"' -f 4)
    appNewVersion=$(curl -fs https://www.torproject.org/download/ | grep "downloadLink" | grep dmg | head -1 | cut -d '"' -f 4 | cut -d / -f 4)
    expectedTeamID="MADPSAYN6T"
    ;;
code42)
    # credit: Isaac Ordonez, Mann consulting (@mannconsulting)
    name="Code42"
    type="pkgInDmg"
    downloadURL=https://download.code42.com/installs/agent/latest-mac.dmg
    expectedTeamID="9YV9435DHD"
    blockingProcesses=( NONE )
    ;;
nomad)
    # credit: Tadayuki Onishi (@kenchan0130)
    name="NoMAD"
    type="pkg"
    downloadURL="https://files.nomad.menu/NoMAD.pkg"
    appNewVersion=$(curl -fs https://nomad.menu/support/ | grep "NoMAD Downloads" | sed -E 's/.*Current Version ([0-9\.]*)<.*/\1/g')
    expectedTeamID="VRPY9KHGX6"
    ;;
nomadlogin)
    # credit: Søren Theilgaard (@theilgaard)
    name="NoMAD Login"
    type="pkg"
    downloadURL="https://files.nomad.menu/NoMAD-Login-AD.pkg"
    appNewVersion=$(curl -fs https://nomad.menu/support/ | grep "NoMAD Login AD Downloads" | sed -E 's/.*Current Version ([0-9\.]*)<.*/\1/g')
    expectedTeamID="AAPZK3CB24"
    ;;
bettertouchtool)
    # credit: Søren Theilgaard (@theilgaard)
    name="BetterTouchTool"
    type="zip"
    downloadURL="https://folivora.ai/releases/BetterTouchTool.zip"
    appNewVersion=$(curl -fs https://updates.folivora.ai/bettertouchtool_release_notes.html | grep BetterTouchTool | head -n 2 | tail -n 1 | sed -E 's/.* ([0-9\.]*) .*/\1/g')
    expectedTeamID="DAFVSXZ82P"
    ;;
r)
    # credit: Tadayuki Onishi (@kenchan0130)
    name="R"
    type="pkg"
    downloadURL=$( curl -fsL https://formulae.brew.sh/api/cask/r.json | sed -n 's/^.*"url":"\([^"]*\)".*$/\1/p' )
    appNewVersion=$(curl -fsL https://formulae.brew.sh/api/cask/r.json | sed -n 's/^.*"version":"\([^"]*\)".*$/\1/p')
    expectedTeamID="VZLD955F6P"
    ;;
8x8)
    # credit: #D-A-James from MacAdmins Slack and Isaac Ordonez, Mann consulting (@mannconsulting)
    name="8x8 Work"
    type="dmg"
    downloadURL=$(curl -fs -L https://support.8x8.com/cloud-phone-service/voice/work-desktop/download-8x8-work-for-desktop | grep -m 1 -o "https.*dmg" | sed 's/\"//' | awk '{print $1}')
    # As for appNewVersion, it needs to be checked for newer version than 7.2.4
    appNewVersion=$(curl -fs -L https://support.8x8.com/cloud-phone-service/voice/work-desktop/download-8x8-work-for-desktop | grep -m 1 -o "https.*dmg" | sed 's/\"//' | awk '{print $1}' | sed -E 's/.*-v([0-9\.]*)[-\.]*.*/\1/' )
    expectedTeamID="FC967L3QRG"
    ;;
egnyte)
    # credit: #MoeMunyoki from MacAdmins Slack
    name="Egnyte Connect"
    type="pkg"
    downloadURL="https://egnyte-cdn.egnyte.com/egnytedrive/mac/en-us/latest/EgnyteConnectMac.pkg"
    expectedTeamID="FELUD555VC"
    blockingProcesses=( NONE )
    ;;
camtasia)
    name="Camtasia 2020"
    type="dmg"
    downloadURL=https://download.techsmith.com/camtasiamac/releases/Camtasia.dmg
    expectedTeamID="7TQL462TU8"
    ;;
snagit|snagit2021|snagit2020)
    name="Snagit 2021"
    type="dmg"
    downloadURL="https://download.techsmith.com/snagitmac/releases/Snagit.dmg"
    expectedTeamID="7TQL462TU8"
    ;;
virtualbox)
    # credit: AP Orlebeke (@apizz)
    name="VirtualBox"
    type="pkgInDmg"
    pkgName="VirtualBox.pkg"
    downloadURL=$(curl -fs "https://www.virtualbox.org/wiki/Downloads" \
        | awk -F '"' "/OSX.dmg/ { print \$4 }")
    appNewVersion=$(curl -fs "https://www.virtualbox.org/wiki/Downloads" | awk -F '"' "/OSX.dmg/ { print \$4 }" | sed -E 's/.*virtualbox\/([0-9.]*)\/.*/\1/')
    expectedTeamID="VB5E2TV963"
    ;;
detectxswift)
    # credit: AP Orlebeke (@apizz)
    name="DetectX Swift"
    type="zip"
    downloadURL="https://s3.amazonaws.com/sqwarq.com/PublicZips/DetectX_Swift.app.zip"
    appNewVersion=$(curl -fs https://s3.amazonaws.com/sqwarq.com/AppCasts/dtxswift_release_notes.html | grep Version | head -1 | sed -E 's/.*Version ([0-9.]*)\<.*/\1/')
    expectedTeamID="MAJ5XBJSG3"
    ;;
autopkgr)
    # credit: Søren Theilgaard (@theilgaard)
    name="AutoPkgr"
    type="dmg"
    #downloadURL=$(curl -fs "https://api.github.com/repos/lindegroup/autopkgr/releases/latest" | awk -F '"' "/browser_download_url/ && /dmg/ && ! /sig/ && ! /CLI/ && ! /sha256/ { print \$4 }")
    downloadURL=$(downloadURLFromGit lindegroup autopkgr)
    appNewVersion=$(versionFromGit lindegroup autopkgr)
    expectedTeamID="JVY2ZR6SEF"
    ;;
airserver)
    # credit: AP Orlebeke (@apizz)
    name="AirServer"
    type="dmg"
    downloadURL="https://www.airserver.com/download/mac/latest"
    #appNewVersion=$() # Cannot find version history or release notes on home page
    expectedTeamID="6C755KS5W3"
    ;;
vscodium)
    # credit: AP Orlebeke (@apizz)
    name="VSCodium"
    type="dmg"
    downloadURL=$(curl -fs "https://api.github.com/repos/VSCodium/vscodium/releases/latest" \
        | awk -F '"' "/browser_download_url/ && /dmg/ && ! /sig/ && ! /CLI/ && ! /sha256/ { print \$4 }")
    expectedTeamID="C7S3ZQ2B8V"
    appName="VSCodium.app"
    blockingProcesses=( Electron )
    ;;
keepassxc)
    # credit: Patrick Atoon (@raptor399)
    name="KeePassXC"
    type="dmg"
    downloadURL="$(downloadURLFromGit keepassxreboot keepassxc)"
    appNewVersion=$(versionFromGit keepassxreboot keepassxc)
    expectedTeamID="G2S7P7J672"
    ;;
alfred)
    # credit: AP Orlebeke (@apizz)
    name="Alfred"
    type="dmg"
    downloadURL=$(curl -fs https://www.alfredapp.com | awk -F '"' "/dmg/ {print \$2}" | head -1)
    appNewVersion=$(echo "${downloadURL}" | sed -E 's/.*Alfred_([0-9.]*)_.*/\1/')
    appName="Alfred 4.app"
    expectedTeamID="XZZXE9SED4"
    ;;
istatmenus)
    # credit: AP Orlebeke (@apizz)
    name="iStat Menus"
    type="zip"
    downloadURL="https://download.bjango.com/istatmenus/"
    expectedTeamID="Y93TK974AT"
    appNewVersion=$(curl -fs https://bjango.com/mac/istatmenus/versionhistory/ | grep "<h3>" | head -1 | sed -E 's/<h3>([0-9.]*)<\/h3>/\1/')
    blockingProcesses=( "iStat Menus" "iStatMenusAgent" "iStat Menus Status" )
    ;;
sizeup)
    # credit: AP Orlebeke (@apizz)
    name="SizeUp"
    type="zip"
    downloadURL="https://www.irradiatedsoftware.com/download/SizeUp.zip"
    appNewVersion=$(curl -fs https://www.irradiatedsoftware.com/updates/notes/SizeUpReleaseNotes.html | grep Version | sed -E 's/.*Version ([0-9.]*) <.*/\1/')
    expectedTeamID="GVZ7RF955D"
    ;;
tunnelblick)
    name="Tunnelblick"
    type="dmg"
    downloadURL=$(downloadURLFromGit TunnelBlick Tunnelblick )
    expectedTeamID="Z2SG5H3HC8"
    ;;
yubikeymanagerqt)
    # credit: Tadayuki Onishi (@kenchan0130)
    name="YubiKey Manager GUI"
    type="pkg"
    downloadURL="https://developers.yubico.com/yubikey-manager-qt/Releases/$(curl -sfL https://api.github.com/repos/Yubico/yubikey-manager-qt/releases/latest | awk -F '"' '/"tag_name"/ { print $4 }')-mac.pkg"
    #appNewVersion=$(curl -fs https://developers.yubico.com/yubikey-manager-qt/Releases/ | grep mac.pkg | head -1 | sed -E "s/.*-([0-9.]*)-mac.*/\1/") # does not work
    expectedTeamID="LQA3CS5MM7"
    ;;
skitch)
    # credit: Isaac Ordonez, Mann consulting (@mannconsulting)
    name="Skitch"
    type="zip"
    downloadURL=$(curl -fs -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1 Safari/605.1.15" https://evernote.com/products/skitch | grep -o "https://.*zip")
    expectedTeamID="J8RPQ294UB"
    Company="Evernote"
    ;;
dialpad)
    # credit: @ehosaka
    name="Dialpad"
    type="dmg"
    downloadURL="https://storage.googleapis.com/dialpad_native/osx/Dialpad.dmg"
    expectedTeamID="9V29MQSZ9M"
    ;;
amazonworkspaces)
    # credit: Isaac Ordonez, Mann consulting (@mannconsulting)
    name="Workspaces"
    type="pkg"
    downloadURL="https://d2td7dqidlhjx7.cloudfront.net/prod/global/osx/WorkSpaces.pkg"
    appNewVersion=$(curl -fs https://d2td7dqidlhjx7.cloudfront.net/prod/iad/osx/WorkSpacesAppCast_macOS_20171023.xml | grep -o "Version*.*<" | head -1 | cut -d " " -f2 | cut -d "<" -f1)
    expectedTeamID="94KV3E626L"
    ;;
apparency)
    name="Apparency"
    type="dmg"
    downloadURL="https://www.mothersruin.com/software/downloads/Apparency.dmg"
    expectedTeamID="936EB786NH"
    ;;

# MARK: labels by others between releases
bluejeans)
    name="BlueJeans"
    type="pkg"
    downloadURL=$(curl -fs "https://www.bluejeans.com/downloads" | xmllint --html --format - 2>/dev/null | grep -o "https://.*BlueJeansInstaller.dmg" | sed 's/dmg/pkg/g')
    appNewVersion=$(echo $downloadURL | cut -d '/' -f6)
    expectedTeamID="HE4P42JBGN"
    Company="Verizon"
    ;;
skype)
    name="Skype"
    type="dmg"
    downloadURL="https://get.skype.com/go/getskype-skypeformac"
    appNewVersion=$(curl -is "https://get.skype.com/go/getskype-skypeformac" | grep ocation: | grep -o "Skype-.*dmg" | cut -d "-" -f 2 | cut -d "." -f1-2)
    expectedTeamID="AL798K98FX"
    Company="Microsoft"
    PatchSkip="YES"
    ;;
keka)
    # credit: Adrian Bühler (@midni9ht)
    name="Keka"
    type="dmg"
    downloadURL=$(downloadURLFromGit aonez Keka)
    appNewVersion=$(versionFromGit aonez Keka)
    expectedTeamID="4FG648TM2A"
    ;;
vmwarehorizonclient)
    # credit: Oh4sh0 https://github.com/Oh4sh0
    name="VMware Horizon Client"
    type="dmg"
    downloadURL=$(curl -fs "https://my.vmware.com/channel/public/api/v1.0/dlg/details?locale=en_US&downloadGroup=CART21FQ2_MAC_800&productId=1027&rPId=48989" | grep -o 'Url.*..dmg"' | cut -d '"' -f3)
    appNewVersion=$(curl -fs "https://my.vmware.com/channel/public/api/v1.0/dlg/details?locale=en_US&downloadGroup=CART21FQ2_MAC_800&productId=1027&rPId=48989" | sed 's/.*-\(.*\)-.*/\1/')
    expectedTeamID="EG7KH642X6"
    ;;
adobeconnect)
    # credit: Oh4sh0 https://github.com/Oh4sh0
    # Comment by Søren: I do not know this software.
    # Looks like it's an Adobe installer in an app, so it will probably not work
    name="AdobeConnectInstaller"
    type="dmg"
    downloadURL="http://www.adobe.com/go/ConnectSetupMac"
    appNewVersion=$(curl -fs https://helpx.adobe.com/adobe-connect/connect-downloads-updates.html | grep "Mac" | grep version | head -1 | sed -E 's/.*\(version ([0-9\.]*),.*/\1/g')
    expectedTeamID="JQ525L2MZD"
    ;;
wireshark)
    # credit: Oh4sh0 https://github.com/Oh4sh0
    name="Wireshark"
    type="dmg"
    downloadURL="https://1.as.dl.wireshark.org/osx/Wireshark%20Latest%20Intel%2064.dmg"
    appNewVersion=$(curl -fs https://www.wireshark.org/download.html | grep "Stable Release" | grep -o "(.*.)" | cut -f2 | head -1 | awk -F'[()]' '{print $2}')
    expectedTeamID="7Z6EMTD2C6"
    ;;
    
# MARK: labels by Søren Theilgaard (@theilgaard)
sketch)
     name="Sketch"
     type="zip"
     downloadURL=$(curl -sf https://www.sketch.com/downloads/mac/ | grep 'href="https://download.sketch.com' | sed -E 's/.*href=\"(.*)\".?/\1/g')
     appNewVersion=$(curl -fs https://www.sketch.com/updates/ | grep "Sketch Version" | head -1 | sed -E 's/.*Version ([0-9.]*)<.*/\1/g') # version from update page
     expectedTeamID="WUGMZZ5K46"
     ;;
teamviewerqs)
    # credit: Søren Theilgaard (@theilgaard)
    name="TeamViewerQS"
    type="dmg"
    downloadURL="https://download.teamviewer.com/download/TeamViewerQS.dmg"
    appName="TeamViewerQS.app"
    expectedTeamID="H7UGFBUGV6"
    ;;
inkscape)
    # credit: Søren Theilgaard (@theilgaard)
    name="Inkscape"
    type="dmg"
    downloadURL="https://inkscape.org$(curl -fs https://inkscape.org$(curl -fsJL https://inkscape.org/release/  | grep "/release/" | grep en | head -n 1 | cut -d '"' -f 6)mac-os-x/1010-1015/dl/ | grep "click here" | cut -d '"' -f 2)"
    #appNewVersion=$(curl -fsJL https://inkscape.org/release/  | grep "<h2>Inkscape" | cut -d '>' -f 3 | cut -d '<' -f 1 | sed 's/[^0-9.]*//g') # Can't figure out where exact new version is found. Currently returns 1.0, but version is "1.0.0 (4035a4f)"
    expectedTeamID="SW3D6BB6A6"
    ;;
xink)
    name="Xink"
    type="zip"
    downloadURL="https://downloads.xink.io/macos/client"
    #appNewVersion=$() # Cannot find version history or release notes on home page
    expectedTeamID="F287823HVS"
    ;;

onlyofficedesktop)
    # credit: Adrian Bühler (@midni9ht)
    name="ONLYOFFICE"
    type="dmg"
    downloadURL="https://download.onlyoffice.com/install/desktop/editors/mac/distrib/onlyoffice/ONLYOFFICE.dmg"
    expectedTeamID="2WH24U26GJ"
    ;;
gpgsuite)
    # credit: Micah Lee (@micahflee)
    name="GPG Suite"
    type="pkgInDmg"
    pkgName="Install.pkg"
    downloadURL=$(curl -s https://gpgtools.org/ | grep https://releases.gpgtools.org/GPG_Suite- | grep Download | cut -d'"' -f4)
    expectedTeamID="PKV8ZPD836"
    ;;
gpgsync)
    # credit: Micah Lee (@micahflee)
    name="GPG Sync"
    type="pkg"
    downloadURL="https://github.com$(curl -s -L https://github.com/firstlookmedia/gpgsync/releases/latest | grep /firstlookmedia/gpgsync/releases/download | grep \.pkg | cut -d'"' -f2)"
    expectedTeamID="P24U45L8P5"
    ;;
dangerzone)
    # credit: Micah Lee (@micahflee)
    name="Dangerzone"
    type="dmg"
    downloadURL=$(curl -s https://dangerzone.rocks/ | grep https://github.com/firstlookmedia/dangerzone/releases/download | grep \.dmg | cut -d'"' -f2)
    expectedTeamID="P24U45L8P5"
    ;;
dbeaverce)
    # credit: Adrian Bühler (@midni9ht)
    name="DBeaver"
    type="dmg"
    downloadURL="https://dbeaver.io/files/dbeaver-ce-latest-macos.dmg"
    expectedTeamID="42B6MDKMW8"
    blockingProcesses=( dbeaver )
    ;;
androidfiletransfer)
    #credit: Sam Ess (saess-sep)
    name="Android File Transfer"
    type="dmg"
    downloadURL="https://dl.google.com/dl/androidjumper/mtp/current/AndroidFileTransfer.dmg"
    expectedTeamID="EQHXZ8M8AV"
    ;;
libreoffice)
    # credit: Micah Lee (@micahflee)
    name="LibreOffice"
    type="dmg"
    downloadURL="https://download.documentfoundation.org/libreoffice/stable/$(curl -s https://www.libreoffice.org/download/download/ | grep dl_version_number | head -n 1 | cut -d'>' -f3 | cut -d'<' -f1)/mac/x86_64/LibreOffice_$(curl -s https://www.libreoffice.org/download/download/ | grep dl_version_number | head -n 1 | cut -d'>' -f3 | cut -d'<' -f1)_MacOS_x86-64.dmg"
    expectedTeamID="7P5S3ZLCN7"
    ;;
toggltrack)
    # credit: Adrian Bühler (@midni9ht)
    name="Toggl Track"
    type="dmg"
    downloadURL=$(downloadURLFromGit toggl-open-source toggldesktop )
    appNewVersion=$(versionFromGit toggl-open-source toggldesktop )
    expectedTeamID="B227VTMZ94"
    ;;
balenaetcher)
    # credit: Adrian Bühler (@midni9ht)
    name="balenaEtcher"
    type="dmg"
    downloadURL=$(downloadURLFromGit balena-io etcher )
    appNewVersion=$(versionFromGit balena-io etcher )
    expectedTeamID="66H43P8FRG"
    ;;
fsmonitor)
    # credit: Adrian Bühler (@midni9ht)
    name="FSMonitor"
    type="zip"
    downloadURL=$(curl --location --fail --silent "https://fsmonitor.com/FSMonitor/Archives/appcast2.xml" | xpath '//rss/channel/item[last()]/enclosure/@url' 2>/dev/null  | cut -d '"' -f 2)
    expectedTeamID="V85GBYB7B9"
    ;;
ramboxce)
    # credit: Adrian Bühler (@midni9ht)
    name="Rambox"
    type="dmg"
    downloadURL=$(downloadURLFromGit ramboxapp community-edition )
    appNewVersion=$(versionFromGit ramboxapp community-edition )
    expectedTeamID="7F292FPD69"
    ;;
adobebrackets)
    # credit: Adrian Bühler (@midni9ht)
    name="Brackets"
    type="dmg"
    downloadURL=$(downloadURLFromGit adobe brackets )
    appNewVersion=$(versionFromGit adobe brackets )
    expectedTeamID="JQ525L2MZD"
    ;;
debookee)
    # credit: Adrian Bühler (@midni9ht)
    name="Debookee"
    type="zip"
    downloadURL=$(curl --location --fail --silent "https://www.iwaxx.com/debookee/appcast.xml" | xpath '//rss/channel/item[1]/enclosure/@url' 2>/dev/null  | cut -d '"' -f 2)
    expectedTeamID="AATLWWB4MZ"
    ;;
ferdi)
    # credit: Adrian Bühler (@midni9ht)
    name="Ferdi"
    type="dmg"
    downloadURL=$(downloadURLFromGit getferdi ferdi )
    appNewVersion=$(versionFromGit getferdi ferdi )
    expectedTeamID="B6J9X9DWFL"
    ;;
hyper)
    # credit: Adrian Bühler (@midni9ht)
    name="Hyper"
    type="dmg"
    downloadURL=$(downloadURLFromGit vercel hyper )
    appNewVersion=$(versionFromGit vercel hyper)
    expectedTeamID="JW6Y669B67"
    ;;
menumeters)
    # credit: Adrian Bühler (@midni9ht)
    name="MenuMeters"
    type="zip"
    downloadURL=$(downloadURLFromGit yujitach MenuMeters )
    appNewVersion=$(versionFromGit yujitach MenuMeters )
    expectedTeamID="95AQ7YKR5A"
    ;;
webexteams)
    # credit: Erik Stam (@erikstam)
    name="Webex"
    type="dmg"
    downloadURL="https://binaries.webex.com/WebexTeamsDesktop-MACOS-Gold/WebexTeams.dmg"
    #appNewVersion=$() # Cannot find version history or release notes on home page
    expectedTeamID="DE8Y96K9QP"
    ;;
mattermost)
    name="Mattermost"
    type="dmg"
    downloadURL=$(downloadURLFromGit mattermost desktop)
    appNewVersion=$(versionFromGit mattermost desktop )
    expectedTeamID="UQ8HT4Q2XM"
    ;;
bitwarden)
    name="Bitwarden"
    type="dmg"
    downloadURL=$(downloadURLFromGit bitwarden desktop )
    appNewVersion=$(versionFromGit bitwarden desktop )
    expectedTeamID="LTZ2PFU5D6"
    ;;
thunderbird)
    name="Thunderbird"
    type="dmg"
    downloadURL="https://download.mozilla.org/?product=thunderbird-latest&os=osx&lang=en-US"
    expectedTeamID="43AQ936H96"
    blockingProcesses=( thunderbird )
    ;;
tigervnc)
    name="TigerVNC Viewer"
    type="dmg"
    downloadURL=https://dl.bintray.com/tigervnc/stable/$(curl -s -l https://dl.bintray.com/tigervnc/stable/ | grep .dmg | sed 's/<pre><a onclick="navi(event)" href="://' | sed 's/".*//' | sort -V | tail -1)
    expectedTeamID="S5LX88A9BW"
    ;;
pitch)
    name="Pitch"
    type="dmg"
    downloadURL="https://desktop.pitch.com/mac/Pitch.dmg"
    expectedTeamID="KUCN8NUU6Z"
    ;;
sidekick)
    name="Sidekick"
    type="dmg"
    downloadURL="https://api.meetsidekick.com/downloads/df/mac"
    expectedTeamID="N975558CUS"
    ;;
plantronicshub)
    name="Plantronics Hub"
    type="dmg"
    downloadURL="https://www.poly.com/content/dam/www/software/PlantronicsHubInstaller.dmg"
    expectedTeamID="SKWK2Q7JJV"
    appNewVersion=$(curl -fs "https://www.poly.com/in/en/support/knowledge-base/kb-article-page?lang=en_US&urlName=Hub-Release-Notes&type=Product_Information__kav" | grep -o "(*.*<span>)" | head -1 | cut -d "(" -f2 | sed 's/\<\/span\>//g' | cut -d "<" -f1)
    ;;
jabradirect)
    name="Jabra Direct"
    type="dmg"
    downloadURL="https://jabraxpressonlineprdstor.blob.core.windows.net/jdo/JabraDirectSetup.dmg"
    expectedTeamID="55LV32M29R"
    appNewVersion=$(curl -fs https://www.jabra.com/Support/release-notes/release-note-jabra-direct | grep -o "Jabra Direct macOS:*.*<" | head -1 | cut -d ":" -f2 | cut -d " " -f2 | cut -d "<" -f1)
    ;;
vagrant)
    # credit: AP Orlebeke (@apizz)
    name="Vagrant"
    type="pkgInDmg"
    pkgName="vagrant.pkg"
    downloadURL=$(curl -fs https://www.vagrantup.com/downloads.html \
        | tr '><' '\n' | awk -F'"' '/x86_64.dmg/ {print $6}' | head -1)
    expectedTeamID="D38WU7D763"
    ;;
aircall)
    # credit: @kris-anderson
    name="Aircall"
    type="dmg"
    downloadURL="https://electron.aircall.io/download/osx"
    expectedTeamID="3ML357Q795"
    ;;
installomator_st)
    # credit: Søren Theilgaard (@theilgaard)
    name="Installomator"
    type="pkg"
    downloadURL=$(downloadURLFromGit theile Installomator )
    appNewVersion=$(versionFromGit theile Installomator )
    expectedTeamID="L8W73B6AH3"
    ;;
etrecheck)
    # credit: @dvsjr macadmins slack
    name="EtreCheckPro"
    type="zip"
    downloadURL="https://cdn.etrecheck.com/EtreCheckPro.zip"
    expectedTeamID="U87NE528LC"
    ;;
hazel)
    # credit: Søren Theilgaard (@theilgaard)
    name="Hazel"
    type="dmg"
    downloadURL=$(curl -fsI https://www.noodlesoft.com/Products/Hazel/download | grep -i "^location" | awk '{print $2}' | tr -d '\r\n')
    appNewVersion=$(curl -fsI https://www.noodlesoft.com/Products/Hazel/download | grep -i "^location" | awk '{print $2}' | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g')
    expectedTeamID="86Z3GCJ4MF"
    ;;
cormorant)
    # credit: Søren Theilgaard (@theilgaard)
    name="Cormorant"
    type="zip"
    downloadURL=$(curl -fs https://eclecticlight.co/downloads/ | grep -i $name | grep zip | sed -E 's/.*href=\"(https.*)\">.*/\1/g')
    appNewVersion=$(curl -fs https://eclecticlight.co/downloads/ | grep zip | grep -o -E "$name [0-9.]*" | awk '{print $2}')
    expectedTeamID="QWY4LRW926"
    ;;
silnite)
    # credit: Søren Theilgaard (@theilgaard)
    name="silnite"
    type="pkgInZip"
    downloadURL=$(curl -fs https://eclecticlight.co/downloads/ | grep -i $name | grep zip | sed -E 's/.*href=\"(https.*)\">.*/\1/g')
    appNewVersion=$(curl -fs https://eclecticlight.co/downloads/ | grep zip | grep -o -E "silnite [0-9.]*" | awk '{print $2}')
    expectedTeamID="QWY4LRW926"
    ;;
devonthink)
    # It's a zipped dmg file, needs function installAppInDmgInZip
    # credit: Søren Theilgaard (@theilgaard)
    name="DEVONthink 3"
    type="appInDmgInZip"
    downloadURL=$( curl -fs https://www.devontechnologies.com/apps/devonthink | grep -i "download.devon" | tr '"' '\n' | tr "'" '\n' | grep -e '^https://' )
    appNewVersion=$( echo ${downloadURL} | tr '/' '\n' | grep "[0-9]" | grep "[.]" | head -1 )
    expectedTeamID="679S2QUWR8"
    ;;
vanilla)
    # credit: Adrian Bühler (@midni9ht)
    name="Vanilla"
    type="dmg"
    downloadURL="https://macrelease.matthewpalmer.net/Vanilla.dmg"
    expectedTeamID="Z4JV2M65MH"
    ;;
taskpaper)
    # credit: Drew Diver (@grumpydrew on MacAdmins Slack)
    name="TaskPaper"
    type="dmg"
    downloadURL="https://www.taskpaper.com/assets/app/TaskPaper.dmg"
    expectedTeamID="64A5CLJP5W"
    ;;
calibre)
    # credit: Drew Diver (@grumpydrew on MacAdmins Slack)
    name="calibre"
    type="dmg"
    downloadURL="https://calibre-ebook.com/dist/osx"
    appNewVersion=$( curl -fsIL "${downloadURL}" | grep -i "^location" | awk '{print $2}' | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g' )
    expectedTeamID="NTY7FVCEKP"
    ;;
redeye)
    # credit: Drew Diver (@grumpydrew on MacAdmins Slack)
    name="Red Eye"
    type="zip"
    downloadURL="https://www.hexedbits.com/downloads/redeye.zip"
    appNewVersion=$( curl -fs "https://www.hexedbits.com/redeye/" | grep "Latest version" | sed -E 's/.*Latest version ([0-9.]*),.*/\1/g' )
    expectedTeamID="5VRJU68BZ5"
    ;;
lucifer)
    # credit: Drew Diver (@grumpydrew on MacAdmins Slack)
    name="Lucifer"
    type="zip"
    downloadURL="https://www.hexedbits.com/downloads/lucifer.zip"
    appNewVersion=$( curl -fs "https://www.hexedbits.com/lucifer/" | grep "Latest version" | sed -E 's/.*Latest version ([0-9.]*),.*/\1/g' )
    expectedTeamID="5VRJU68BZ5"
    ;;
fantastical)
    # credit: Drew Diver (@grumpydrew on MacAdmins Slack)
    name="Fantastical"
    type="zip"
    downloadURL="https://flexibits.com/fantastical/download"
    appNewVersion=$( curl -fsIL "${downloadURL}" | grep -i "^location" | awk '{print $2}' | sed -E 's/.*\/[a-zA-Z]*_([0-9.]*)\..*/\1/g' )
    expectedTeamID="85C27NK92C"
    ;;
launchbar)
    name="LaunchBar"
    type="dmg"
    downloadURL=$(curl -fs "https://obdev.at/products/launchbar/download.html" | xmllint --html --format - 2>/dev/null | grep -m 1 -o "https://.*.dmg")
    appNewVersion=$( echo ${downloadURL} | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g' )
    expectedTeamID="MLZF7K7B5R"
    ;;
klokki)
    # credit: Søren Theilgaard (@theilgaard)
    name="Klokki"
    type="dmg"
    downloadURL="https://storage.yandexcloud.net/klokki/Klokki.dmg"
    expectedTeamID="Q9SATZMHPG"
    ;;
notion)
    # credit: Søren Theilgaard (@theilgaard)
    name="notion"
    type="dmg"
    if [[ $(arch) == "arm64" ]]; then
        downloadURL="https://www.notion.so/desktop/apple-silicon/download"
    elif [[ $(arch) == "i386" ]]; then
        downloadURL="https://www.notion.so/desktop/mac/download"
    fi
    appNewVersion=$( curl -fsIL "${downloadURL}" | grep -i "^location" | awk '{print $2}' | tr -d '\r\n' | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g' )
    expectedTeamID="LBQJ96FQ8D"
    ;;
lexarrecoverytool)
    # credit: Søren Theilgaard (@theilgaard)
    name="Lexar Recovery Tool"
    type="appInDmgInZip"
    downloadURL="https://www.lexar.com$( curl -fs https://www.lexar.com/support/downloads/ | grep -i "mac" | grep -i "recovery" | head -1 | tr '"' '\n' | grep -i ".zip"  )"
    #appNewVersion=""
    expectedTeamID="Y8HM6WR2DV"
    ;;
easeusdatarecoverywizard)
    # credit: Søren Theilgaard (@theilgaard)
    name="EaseUS Data Recovery Wizard"
    type="dmg"
    downloadURL=$( curl -fsIL https://down.easeus.com/product/mac_drw_free_setup | grep -i "^location" | awk '{print $2}' | tr -d '\r\n' )
    #appNewVersion=""
    expectedTeamID="DLLVW95FSM"
    ;;
lastpass)
    name="LastPass"
    type="dmg"
    downloadURL="https://download.cloud.lastpass.com/mac/LastPass.dmg"
    expectedTeamID="N24REP3BMN"
    Company="Marvasol, Inc DBA LastPass"
    ;;
front)
    name="Front"
    type="dmg"
    downloadURL="https://dl.frontapp.com/macos/Front.dmg"
    expectedTeamID="X549L7572J"
    Company="FrontApp. Inc."
    ;;
obsidian)
    # credit: Søren Theilgaard (@theilgaard)
    name="Obsidian"
    type="dmg"
    if [[ $(arch) == "arm64" ]]; then
        downloadURL=$( downloadURLFromGit obsidianmd obsidian-releases | grep "arm64" )
    elif [[ $(arch) == "i386" ]]; then
        downloadURL=$( downloadURLFromGit obsidianmd obsidian-releases | grep -v "arm64" )
    fi
    printlog $downloadURL
    appNewVersion=$(versionFromGit obsidianmd obsidian-releases)
    expectedTeamID="6JSW4SJWN9"
    ;;
telegram)
    name="Telegram"
    type="dmg"
    downloadURL="https://telegram.org/dl/macos"
    appNewVersion=$( curl -fs https://macos.telegram.org | grep anchor | head -1 | sed -E 's/.*a>([0-9.]*) .*/\1/g' )
    expectedTeamID="6N38VWS5BX"
    ;;
wickrme)
    # credit: Søren Theilgaard (@theilgaard)
    name="WickrMe"
    type="dmg"
    downloadURL=$( curl -fs https://me-download.wickr.com/api/download/me/download/mac | tr '"' '\n' | grep -e '^https://' )
    appNewVersion=$( echo ${downloadURL} | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g' )
    expectedTeamID="W8RC3R952A"
    ;;
wickrpro)
    # credit: Søren Theilgaard (@theilgaard)
    name="WickrPro"
    type="dmg"
    downloadURL=$( curl -fs https://me-download.wickr.com/api/download/pro/download/mac | tr '"' '\n' | grep -e '^https://' )
    appNewVersion=$( echo ${downloadURL} | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g' )
    expectedTeamID="W8RC3R952A"
    ;;
exelbanstats)
    # credit: Søren Theilgaard (@theilgaard)
    name="Stats"
    type="dmg"
    downloadURL=$(downloadURLFromGit exelban stats)
    appNewVersion=$(versionFromGit exelban stats)
    expectedTeamID="RP2S87B72W"
    ;;
onionshare)
    # credit: Søren Theilgaard (@theilgaard)
    name="OnionShare"
    type="pkg"
    downloadURL="https://onionshare.org$(curl -fs https://onionshare.org | grep "button.*pkg" | tr '"' '\n' | grep ".pkg")"
    appNewVersion=$( echo "${downloadURL}" | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g' )
    expectedTeamID="N9B95FDWH4"
    ;;

# MARK: add new labels above here

# NOTE: Packages is signed but _not_ notarized, so spctl will reject it
# packages)
#    name="Packages"
#    type="pkgInDmg"
#    pkgName="Install Packages.pkg"
#    downloadURL="http://s.sudre.free.fr/Software/files/Packages.dmg"
#    expectedTeamID="NL5M9E394P"
#    ;;

# msupdate codes from:
# https://docs.microsoft.com/en-us/deployoffice/mac/update-office-for-mac-using-msupdate

# download link IDs from: https://macadmin.software

microsoftoffice365)
    name="MicrosoftOffice365"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=525133"
    expectedTeamID="UBF8T346G9"
    # using MS PowerPoint as the 'stand-in' for the entire suite
    appName="Microsoft PowerPoint.app"
    blockingProcesses=( "Microsoft AutoUpdate" "Microsoft Word" "Microsoft PowerPoint" "Microsoft Excel" "Microsoft OneNote" "Microsoft Outlook" "OneDrive" )
    updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    updateToolArguments=( --install )
    ;;
microsoftofficebusinesspro)
    name="MicrosoftOfficeBusinessPro"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=2009112"
    expectedTeamID="UBF8T346G9"
    # using MS PowerPoint as the 'stand-in' for the entire suite
    appName="Microsoft PowerPoint.app"
    blockingProcesses=( "Microsoft AutoUpdate" "Microsoft Word" "Microsoft PowerPoint" "Microsoft Excel" "Microsoft OneNote" "Microsoft Outlook" "OneDrive" "Teams")
    updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    updateToolArguments=( --install )
    ;;
microsoftedgeconsumerstable|microsoftedge)
    name="Microsoft Edge"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=2069148"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/package[id="com.microsoft.edge"]/cfbundleversion' 2>/dev/null | sed -E 's/<cfbundleversion>([0-9.]*)<.*/\1/')
    expectedTeamID="UBF8T346G9"
    updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    updateToolArguments=( --install --apps EDGE01 )
    ;;
microsoftcompanyportal)
    name="Company Portal"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=869655"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/package[id="com.microsoft.intunecompanyportal.standalone"]/cfbundleshortversionstring' 2>/dev/null | sed -E 's/<cfbundleshortversionstring>([0-9.]*)<.*/\1/')
    expectedTeamID="UBF8T346G9"
    updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    updateToolArguments=( --install --apps IMCP01 )
    ;;
microsoftskypeforbusiness)
    name="Skype for Business"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=832978"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/package[id="com.microsoft.skypeforbusiness.standalone"]/cfbundleshortversionstring' 2>/dev/null | sed -E 's/<cfbundleshortversionstring>([0-9.]*)<.*/\1/')
    expectedTeamID="UBF8T346G9"
    updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    updateToolArguments=( --install --apps MSFB16 )
    ;;
microsoftremotedesktop)
    name="Microsoft Remote Desktop"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=868963"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/package[id="com.microsoft.remotedesktop.standalone"]/cfbundleshortversionstring' 2>/dev/null | sed -E 's/<cfbundleshortversionstring>([0-9.]*)<.*/\1/')
    expectedTeamID="UBF8T346G9"
    updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    updateToolArguments=( --install --apps MSRD10 )
    ;;
microsoftteams)
    name="Microsoft Teams"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=869428"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/package[id="com.microsoft.teams.standalone"]/version' 2>/dev/null | sed -E 's/<version>([0-9.]*) .*/\1/')
    expectedTeamID="UBF8T346G9"
    blockingProcesses=( Teams "Microsoft Teams Helper" )
    #updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    #updateToolArguments=( --install --apps TEAM01 )
    ;;
microsoftyammer)
    name="Yammer"
    type="dmg"
    downloadURL="https://aka.ms/yammer_desktop_mac"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/oldpackage[id="com.microsoft.yammer.standalone"]/cfbundleshortversionstring' 2>/dev/null | sed -E 's/<cfbundleshortversionstring>([0-9.]*)<.*/\1/')
    expectedTeamID="UBF8T346G9"
    #updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    #updateToolArguments=( --install --apps ?????? )
    ;;
microsoftautoupdate)
    name="Microsoft AutoUpdate"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=830196"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/package[id="com.microsoft.autoupdate.standalone"]/cfbundleshortversionstring' 2>/dev/null | sed -E 's/<cfbundleshortversionstring>([0-9.]*)<.*/\1/')
    expectedTeamID="UBF8T346G9"
    # commented the updatetool for MSAutoupdate, because when Autoupdate is really
    # old or broken, you want to force a new install
    #updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    #updateToolArguments=( --install --apps MSau04 )
    ;;
microsoftedgeenterprisestable)
    name="Microsoft Edge"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=2093438"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/package[id="com.microsoft.edge"]/version' 2>/dev/null | sed -E 's/<version>([0-9.]*) .*/\1/')
    expectedTeamID="UBF8T346G9"
    updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    updateToolArguments=( --install --apps EDGE01 )
    ;;
microsoftword)
    name="Microsoft Word"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=525134"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/package[id="com.microsoft.word.standalone.365"]/cfbundleshortversionstring' 2>/dev/null | sed -E 's/<cfbundleshortversionstring>([0-9.]*)<.*/\1/')
    expectedTeamID="UBF8T346G9"
    updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    updateToolArguments=( --install --apps MSWD2019 )
    ;;
microsoftexcel)
    name="Microsoft Excel"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=525135"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/package[id="com.microsoft.excel.standalone.365"]/cfbundleshortversionstring' 2>/dev/null | sed -E 's/<cfbundleshortversionstring>([0-9.]*)<.*/\1/')
    expectedTeamID="UBF8T346G9"
    updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    updateToolArguments=( --install --apps XCEL2019 )
    ;;
microsoftpowerpoint)
    name="Microsoft PowerPoint"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=525136"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/package[id="com.microsoft.powerpoint.standalone.365"]/cfbundleshortversionstring' 2>/dev/null | sed -E 's/<cfbundleshortversionstring>([0-9.]*)<.*/\1/')
    expectedTeamID="UBF8T346G9"
    updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    updateToolArguments=( --install --apps PPT32019 )
    ;;
microsoftoutlook)
    name="Microsoft Outlook"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=525137"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/package[id="com.microsoft.outlook.standalone.365"]/cfbundleshortversionstring' 2>/dev/null | sed -E 's/<cfbundleshortversionstring>([0-9.]*)<.*/\1/')
    expectedTeamID="UBF8T346G9"
    updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    updateToolArguments=( --install --apps OPIM2019 )
    ;;
microsoftonenote)
    name="Microsoft OneNote"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=820886"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/package[id="com.microsoft.onenote.standalone.365"]/cfbundleshortversionstring' 2>/dev/null | sed -E 's/<cfbundleshortversionstring>([0-9.]*)<.*/\1/')
    expectedTeamID="UBF8T346G9"
    updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    updateToolArguments=( --install --apps ONMC2019 )
    ;;
microsoftonedrive)
    name="OneDrive"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=823060"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/package[id="com.microsoft.onedrive.standalone"]/cfbundleshortversionstring' 2>/dev/null | sed -E 's/<cfbundleshortversionstring>([0-9.]*)<.*/\1/')
    expectedTeamID="UBF8T346G9"
    updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    updateToolArguments=( --install --apps ONDR18 )
    ;;
microsoftsharepointplugin)
    name="MicrosoftSharePointPlugin"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=800050"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/package[id="com.microsoft.sharepointplugin.standalone"]/version' 2>/dev/null | sed -E 's/<version>([0-9.]*) .*/\1/')
    expectedTeamID="UBF8T346G9"
    # TODO: determine blockingProcesses for SharePointPlugin
    ;;
visualstudiocode)
    name="Visual Studio Code"
    type="zip"
    downloadURL="https://go.microsoft.com/fwlink/?LinkID=620882"
    appNewVersion=$(curl -fsL "https://code.visualstudio.com/Updates" | grep "/darwin" | grep -oiE ".com/([^>]+)([^<]+)/darwin" | cut -d "/" -f 2 | sed $'s/[^[:print:]\t]//g')
    expectedTeamID="UBF8T346G9"
    appName="Visual Studio Code.app"
    blockingProcesses=( Electron )
    ;;
microsoftdefenderatp)
    name="Microsoft Defender ATP"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=2097502"
    appNewVersion=$(curl -fs https://macadmins.software/latest.xml | xpath '//latest/package[id="com.microsoft.defender.standalone"]/version' 2>/dev/null | sed -E 's/<version>([0-9.]*) .*/\1/')
    expectedTeamID="UBF8T346G9"
    updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    updateToolArguments=( --install --apps WDAV00 )
    ;;
microsoftlicenseremovaltool)
    # credit: Isaac Ordonez (@isaac) macadmins slack
    name="Microsoft License Removal Tool"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=849815"
    expectedTeamID="QGS93ZLCU7"
    appNewVersion=$(curl -is "$downloadURL" | grep ocation: | grep -o "Microsoft_.*pkg" | cut -d "_" -f 5 | cut -d "." -f1-2)
    Company="Microsoft"
    PatchSkip="YES"
    ;;

# this description is so you can provide all variables as arguments
# it will only check if the required variables are setting
valuesfromarguments)
    if [[ -z $name ]]; then
        printlog "need to provide 'name'"
        exit 1
    fi
    if [[ -z $type ]]; then
        printlog "need to provide 'type'"
        exit 1
    fi
    if [[ -z $downloadURL ]]; then
        printlog "need to provide 'downloadURL'"
        exit 1
    fi
    if [[ -z $expectedTeamID ]]; then
        printlog "need to provide 'expectedTeamID'"
        exit 1
    fi
    ;;


# these descriptions exist for testing and are intentionally broken
brokendownloadurl)
    name="Google Chrome"
    type="dmg"
    downloadURL="https://broken.com/broken.dmg"
    expectedTeamID="EQHXZ8M8AV"
    ;;
brokenappname)
    name="brokenapp"
    type="dmg"
    downloadURL="https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
    expectedTeamID="EQHXZ8M8AV"
    ;;
brokenteamid)
    name="Google Chrome"
    type="dmg"
    downloadURL="https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
    expectedTeamID="broken"
    ;;
*)
    # unknown label
    #printlog "unknown label $label"
    cleanupAndExit 1 "unknown label $label"
    ;;
esac

}
