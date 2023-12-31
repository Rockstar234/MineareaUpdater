@shift /0
@shift /0
@echo off
set local enableextensions


Color 0F

set scriptpath=%~dp0
echo %scriptpath%
chcp 437 > nul

::Idea took from https://github.com/SlejmUr/Manifest_Tool_TB.
::Credits 
::https://github.com/SlejmUr
::JVAV

::requirements check
:7zipcheck
MODE 62,50
if exist "Resources\7z.exe" (
goto cmdCheck
) else (
mkdir Resources
goto no7zip
)
goto 7zipcheck

:no7zip
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo ###########################  Downloading 7-Zip... #############################
echo -------------------------------------------------------------------------------
curl.exe -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/7z.exe" --ssl-no-revoke --output 7z.exe
move 7z.exe Resources
goto 7zipcheck

:cmdCheck
if exist "Resources\cmdmenusel.exe" (
goto java17Check
) else (
goto GetCmd
)
goto cmdCheck

:GetCmd
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo ########################### Downloading cmdmenusel... #########################
echo -------------------------------------------------------------------------------
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/cmdmenusel.exe" --ssl-no-revoke --output cmdmenusel.exe
move cmdmenusel.exe Resources
goto cmdCheck

:java17Check
if exist "C:\Program Files\Java\jdk-17\bin\java.exe" (
goto foldercheck
) else (
goto javaWarning
)

:javaWarning
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo ########################### Java 17 is missing! ###############################
echo ########## You can install/update Java in main menu. Redirecting... ###########
echo -------------------------------------------------------------------------------
timeout /T 3 >nul
goto foldercheck
::requirements check end

::check for updates
:foldercheck
Title Checking updates...1
if exist "%userprofile%\.minearea\temp" (
goto getVer
) else (
    goto foldercreate
)

:foldercreate
Title Creating folder...
mkdir "%userprofile%\.minearea"
mkdir "%userprofile%\.minearea\temp"
goto foldercheck

:getVer
Title Checking updates...2
cls 
MODE 79,20
echo -------------------------------------------------------------------------------
echo ######################## Trying to verify version... ##########################
echo -------------------------------------------------------------------------------
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/version.verify" --ssl-no-revoke --output version.verify
move version.verify %userprofile%\.minearea
goto versioncheck 

:versioncheck
Title Checking updates...3
::BYABCQAAAEAeif/nFOE= 110
::BYAxCQAAAIMayXbYv5qcYQ== 105
findstr /m "BYABCQAAAEAeif/nFOE=" %userprofile%\.minearea\version.verify >Nul
if %errorlevel%==0 (
goto noupdatesfound
)

if %errorlevel%==1 (
goto updatesfound
)

:updatesfound
Title Checking updates...4
cls
MODE 87,17
echo -------------------------------------------------------------------------------
echo  Your dowloader is outdated and it downloads wrong MC modpack. Please update.
echo                             Redirecting you...
echo              Don't forget to delete outdated downloader folder.
echo -------------------------------------------------------------------------------
timeout 5 >nul
start "" https://github.com/Rockstar234/MineareaUpdater/releases
exit 

:noupdatesfound
Title Verify complete
cls
echo -------------------------------------------------------------------------------
echo ###################### Your downloader is up to date. #########################
echo -------------------------------------------------------------------------------
timeout 2 >nul
goto welcome
::check for updates end

::welcome screen
:welcome
Title Select one of options...
cls
MODE 87,17
echo -------------------------------------------------------------------------------
echo ########################## What launcher do you use? ##########################
echo -------------------------------------------------------------------------------
echo *Means this option is recommended
echo **Means not portable version and recommended
echo ***Means work in progress
echo. 
Resources\cmdMenuSel f870 "  Minecraft Launcher" "  **PrismLauncher" "  TLauncher" "  CurseForge" "  Not listed here"
if %ERRORLEVEL% == 1 goto minecraftcheck
if %ERRORLEVEL% == 2 goto prismcheck
if %ERRORLEVEL% == 3 goto tlaunchercheck
if %ERRORLEVEL% == 4 goto launchercurseforge
if %ERRORLEVEL% == 5 goto notlistedcheck

:launcherminecraft
Title Minecraft Launcher was selected as default launcher...
cls
MODE 81,10
set launcherpath=%appdata%\.minecraft
goto mainmenu

:minecraftcheck
Title Checking minecraft folder...
if exist "%appdata%\.minecraft" (
    goto launcherminecraft
) else (
    goto createminecraft
)

:createminecraft
Title Creating minecraft folder...
mkdir "%appdata%\.minecraft"
mkdir "%appdata%\.minecraft\mods"
mkdir "%appdata%\.minecraft\versions"
goto minecraftcheck

:launcherprism
Title PrismLauncher was selected as default launcher...
cls
MODE 81,10
set launcherpath=%appdata%\PrismLauncher\instances\1.19.2\.minecraft
goto mainmenu

:prismcheck
Title Checking Prism folders...
findstr /m "BYABCQAAAEAeif/nFOE=" %appdata%\PrismLauncher\instances\1.19.2\check.verify >Nul
if %errorlevel%==0 (
goto launcherprism
)

if %errorlevel%==1 (
goto prismcreate
)

:prismcreate
Title Creating Prism folders...
mkdir "%appdata%\PrismLauncher\instances"
mkdir "%appdata%\PrismLauncher\icons"
mkdir "%appdata%\PrismLauncher\instances\1.19.2"
mkdir "%appdata%\PrismLauncher\instances\1.19.2\.minecraft"
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/prismlauncher/instance.cfg" --ssl-no-revoke --output instance.cfg
move /y instance.cfg %appdata%\PrismLauncher\instances\1.19.2
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/prismlauncher/mmc-pack.json" --ssl-no-revoke --output mmc-pack.json
move /y mmc-pack.json %appdata%\PrismLauncher\instances\1.19.2
curl -L  "https://raw.githubusercontent.com/Rockstar234/RequirementsForScripts/main/MineareaUpdater/minearea.ico" --ssl-no-revoke --output minearea.ico
move /y minearea.ico %appdata%\PrismLauncher\icons
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/prismlauncher/check.verify" --ssl-no-revoke --output check.verify
move /y check.verify %appdata%\PrismLauncher\instances\1.19.2
goto prismcheck

:launchertlauncher
Title TLauncher was selected as default launcher...
cls
MODE 81,10
set launcherpath=%appdata%\.minecraft
goto mainmenu

:tlaunchercheck
Title Checking minecraft folder...
if exist "%appdata%\.minecraft\mods" (
    goto launchertlauncher
) else (
    goto createtlauncher
)

:createtlauncher
Title Creating minecraft folder...
mkdir "%appdata%\.minecraft"
mkdir "%appdata%\.minecraft\mods"
mkdir "%appdata%\.minecraft\versions"
goto tlaunchercheck

:launchercurseforge
Title Minecraft Launcher was selected as default launcher...
cls
MODE 81,10
mkdir "%userprofile%\curseforge\minecraft\Instances\BetterMC+Modified+by+Rockstar234"
mkdir "%userprofile%\curseforge\minecraft\Instances\BetterMC+Modified+by+Rockstar234\mods"
mkdir "%userprofile%\curseforge\minecraft\Instances\BetterMC+Modified+by+Rockstar234\profileImage"
curl -L  "https://raw.githubusercontent.com/Rockstar234/RequirementsForScripts/main/MineareaUpdater/minearea2k20_avatar.jpg" --ssl-no-revoke --output minearea2k20_avatar.jpg
move /y minearea2k20_avatar.jpg %userprofile%\curseforge\minecraft\Instances\BetterMC+Modified+by+Rockstar234\profileImage
set launcherpath=%userprofile%\curseforge\minecraft\Instances\BetterMC+Modified+by+Rockstar234
goto mainmenu

:notlistedcheck
Title Selecting game folder...
if exist "%appdata%\.minecraft" (
    goto notlistedpath
) else (
    goto createnotlisted
)

:notlistedpath
MODE 79,13
set "psCommand="(new-object -COM 'Shell.Application')^.BrowseForFolder(0,'Please choose your .minecraft folder.',0,0).self.path""

for /f "usebackq delims=" %%A in (`powershell %psCommand%`) do set "launcherpath=%%A"
goto mainmenu

:createnotlisted
Title Creating minecraft folder...
mkdir "%appdata%\.minecraft"
mkdir "%appdata%\.minecraft\mods"
mkdir "%appdata%\.minecraft\versions"
goto notlistedcheck
::welcome screen end

::main part
:mainmenu
Title Game Downloader
cls
MODE 87,17
echo -------------------------------------------------------------------------------
echo Welcome to Game Downloader menu. Current version is 1.1.0. If this version
echo doesn't match the version in discord, then click Update Client. If version is
echo fine and you need to update your mods, then click Update Game. You can also update
echo game files, configs and etc by clicking Install Game button.
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  Install Game" "  Install Fabric" "  Install Java" "  Update Launcher" "  Discord Server" "  Exit"
if %ERRORLEVEL% == 1 goto installgame
if %ERRORLEVEL% == 2 goto fabricinstall
if %ERRORLEVEL% == 3 goto javainstall
if %ERRORLEVEL% == 4 goto updatelauncher
if %ERRORLEVEL% == 5 goto discordserver
if %ERRORLEVEL% == 6 goto closescript

:javainstall
Title Installing Java...
cls
MODE 81,17
echo -------------------------------------------------------------------------------
echo ####### Please, use this method if you REALLY don't have Java installed. ######
echo ###################### Are you sure you want to continue? #####################
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  Yes" "  No"
if %ERRORLEVEL% == 1 goto javainstall2
if %ERRORLEVEL% == 2 goto mainmenu

:javainstall2
Title Installing Java...
cls
MODE 81,17
curl -L  "https://download.oracle.com/java/17/archive/jdk-17.0.9_windows-x64_bin.exe" --ssl-no-revoke --output jdk-17.0.9_windows-x64_bin.exe
move /y jdk-17.0.9_windows-x64_bin.exe %userprofile%\.minearea\temp
cls
echo -------------------------------------------------------------------------------
echo ################## Downloading and launching your installer. ##################
echo ################# Press Enter when installation is finished. ##################
echo -------------------------------------------------------------------------------
timeout 3 >nul
start "" "%userprofile%\.minearea\temp\jdk-17.0.9_windows-x64_bin.exe"
pause
cls
echo -------------------------------------------------------------------------------
echo Was the installation successful?
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  Yes" "  No"
if %ERRORLEVEL% == 1 goto downloadcomplete
if %ERRORLEVEL% == 2 goto somethingwentwrong

:installgame
Title Installing client...
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo                        Trying to install your game...
echo        After success you need to select fabric loader in your MC launcher.
echo -------------------------------------------------------------------------------
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/prismlauncher/fabric/fabric.7z.001" --ssl-no-revoke --output fabric.7z.001
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/prismlauncher/fabric/fabric.7z.002" --ssl-no-revoke --output fabric.7z.002
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/prismlauncher/fabric/fabric.7z.003" --ssl-no-revoke --output fabric.7z.003
for %%I in ("fabric.7z.001") do (
    "Resources\7z.exe" x -y -o"Resources\.minecraft" "%%I" -aoa && del %%I
    )
move /y fabric.7z.001 %userprofile%\.minearea\temp
move /y fabric.7z.002 %userprofile%\.minearea\temp
move /y fabric.7z.003 %userprofile%\.minearea\temp
robocopy Resources\.minecraft %launcherpath% /E /MOVE
if exist "%launcherpath%\config\puzzle.json" (
    goto modsinstall
) else (
    goto somethingwentwrong
)

:discordserver
Title Discord Server
cls MODE 79,20
echo -------------------------------------------------------------------------------
echo               You're being redirected to our discord server.
echo                     You will be redirected in 5 seconds.
echo -------------------------------------------------------------------------------
timeout 5 >nul
start "" https://discord.gg/5GVb9UwsY7
Resources\cmdMenuSel f870 "  <- Back to Main Menu"
if %ERRORLEVEL% == 1 goto mainmenu

:updatelauncher
Title Update Client
cls MODE 79,20
echo -------------------------------------------------------------------------------
echo   You're being redirected to our github page to download latest version.
echo                     You will be redirected in 5 seconds.
echo                   Don't forget to delete outdated folder.
echo -------------------------------------------------------------------------------
timeout 5 >nul
start "" https://github.com/Rockstar234/MineareaUpdater/releases
exit
::later add automatic update. yes im crazy mf.

:closescript
Title GOODBYE!
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo ################################# GOODBYE! #####################################
echo --------------------------------------------------------------------------------
timeout 2 >nul
exit
::main part end

:downloadcomplete
Title Update Complete
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo ########################### Download Complete! #################################
echo --------------------------------------------------------------------------------
timeout 2 >nul
goto mainmenu

:somethingwentwrong
Title Something went wrong!
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo ##### Woops! Something went wrong and gives an error. Please report back. #####
echo --------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "                               Continue" "                            Report an issue"
if %ERRORLEVEL% == 1 goto mainmenu
if %ERRORLEVEL% == 2 goto reportissue

:reportissue
start "" https://github.com/Rockstar234/MineareaUpdater/issues
goto mainmenu

:modsinstall
Title Client installed
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo ### Your client is installed, but mods are missing. Launching update.bat... ###
echo #### HINT: Click Update Game to install mods and then you can launch game. ####
echo --------------------------------------------------------------------------------
timeout 5 >nul
start update.bat
goto fabricinstall

:fabricinstall
if exist "%appdata%\.minecraft\versions\fabric-loader-0.14.21-1.19.2\fabric-loader-0.14.21-1.19.2.jar" (
    goto downloadcomplete
) else (
    goto fabricmissing
)

:fabricmissing
Title Fabric Laoder is missing.
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo Your Fabric loader is missing, so it will be installed in a few seconds.
echo If it gives an error, then try to launch the file manually. Report back issues.
echo If you download fabric via your launcher make sure the version is 0.14.21.
echo --------------------------------------------------------------------------------
timeout 5 >nul
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/fabric-installer-0.11.2.jar" --ssl-no-revoke --output fabric-installer-0.11.2.jar
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/java.ps1" --ssl-no-revoke --output java.ps1
Powershell.exe -executionpolicy remotesigned -File java.ps1
move /y fabric-installer-0.11.2.jar %userprofile%\.minearea\temp
move /y java.ps1 %userprofile%\.minearea\temp
goto fabricinstall