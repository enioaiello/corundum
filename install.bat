@echo off
title Corundum Setup

set VERSION=2.0.0 > nul
set BRANCH=beta > nul

reg add "HKCU\Software\Corundum\Maintenance" /v "Version" /t REG_SZ /d "%VERSION%" /f > nul
reg add "HKCU\Software\Corundum\Maintenance" /v "Branch" /t REG_SZ /d "%BRANCH%" /f > nul

NET SESSION >nul 2>&1
if %errorlevel% NEQ 0 (
    powershell.exe -Command "Start-Process '%~0' -Verb RunAs"
    exit /b
)

if exist "%USERPROFILE%\Corundum" (
    goto CorundumInstalled
) else (
    goto StartInstallation
)

:ChooseLanguage
cls
echo Setup
echo.
echo Welcome to the Corundum installation wizard.
echo.
echo Please choose your language:
echo 1. English
echo 2. Français
echo 3. Exit
echo.
set /p language="Enter your choice: "

if "%language%"=="1" goto english
if "%language%"=="2" goto french
if "%language%"=="3" goto cancel

:english
cls
echo Installation
echo.
echo The Corundum version in this package is v%VERSION%-%BRANCH%.
echo.
echo Please choose the installation method:
echo 1. Install Corundum on the hard disk
echo 2. Choose a location for the portable installation
set /p choice="Enter your choice: "

if "%choice%"=="1" goto StartCorundumStartupEN
if "%choice%"=="2" goto PortableModeEN

cls
goto english

:StartCorundumStartupEN
cls
echo Installation
echo.
echo Corundum can be started when your Windows session starts.
echo.
echo Would you like to launch Corundum when your Windows session starts?
echo 1. Enable this option
echo 2. Disable this option
echo 3. Exit
set /p startup="Enter your choice: "

if "%startup%"=="1" goto InstallHardDiskShortcutEN
if "%startup%"=="2" goto InstallHardDiskEN
if "%startup%"=="3" goto StartInstallationEN

cls
goto StartCorundumStartupEN

:InstallHardDiskShortcutEN
cls
echo Installation
echo.
echo You are about to install Corundum on your local hard disk (C:). You have selected automatic execution at login for user %USERNAME%.
echo.
echo Please choose the installation method:
echo 1. Install Corundum
echo 2. Go back
set /p install="Enter your choice: "

if "%install%"=="1" goto InstallNowShortcutEN
if "%install%"=="2" goto StartInstallationEN

cls
goto InstallHardDiskEN

:InstallNowShortcutEN
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments, Corundum will be installed on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Creating the Corundum folder...
mkdir "%USERPROFILE%\Corundum" > nul
echo Status: Copying files...
copy "%~dp0\main.bat" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\install.bat" "%USERPROFILE%\Corundum" > nul
xcopy "%~dp0\utility" "%USERPROFILE%\Corundum\utility" /s /e /i > nul
copy "%~dp0\README.md" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\LICENSE" "%USERPROFILE%\Corundum" > nul
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Creating the shortcut...

set "target=%USERPROFILE%\Corundum\main.bat"
set "shortcut_folder=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Enio Aiello"
set "shortcut_name=Corundum.lnk"

if not exist "%shortcut_folder%" (
    mkdir "%shortcut_folder%"
)

set "vbs_file=%temp%\create_shortcut.vbs"
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%vbs_file%"
echo Set oShellLink = WshShell.CreateShortcut("%shortcut_folder%\%shortcut_name%") >> "%vbs_file%"
echo oShellLink.TargetPath = "%target%" >> "%vbs_file%"
echo oShellLink.Save >> "%vbs_file%"

cscript //nologo "%vbs_file%" > nul
del "%vbs_file%" > nul
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments, Corundum will be installed on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Adding Corundum to startup...
set "shortcut_folder=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"
if not exist "%shortcut_folder%" (
    mkdir "%shortcut_folder%"
)

set "vbs_file=%temp%\create_startup_shortcut.vbs"
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%vbs_file%"
echo Set oShellLink = WshShell.CreateShortcut("%shortcut_folder%\%shortcut_name%") >> "%vbs_file%"
echo oShellLink.TargetPath = "%target%" >> "%vbs_file%"
echo oShellLink.Save >> "%vbs_file%"

cscript //nologo "%vbs_file%" > nul
del "%vbs_file%" > nul

cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Installation completed!
timeout /t 3 > nul
goto EndEN

:InstallHardDiskEN
cls
echo Installation
echo.
echo You are about to install Corundum on your local hard disk (C:).
echo.
echo Please choose the installation method:
echo 1. Install Corundum
echo 2. Go back
set /p install="Enter your choice: "

if "%install%"=="1" goto InstallNowWithoutStartupEN
if "%install%"=="2" goto StartInstallationEN

cls
goto InstallHardDiskEN

:InstallNowWithoutStartupEN
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments, Corundum will be installed on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Creating the Corundum folder...
mkdir "%USERPROFILE%\Corundum" > nul
echo Status: Copying files...
copy "%~dp0\main.bat" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\install.bat" "%USERPROFILE%\Corundum" > nul
xcopy "%~dp0\utility" "%USERPROFILE%\Corundum\utility" /s /e /i > nul
copy "%~dp0\README.md" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\LICENSE" "%USERPROFILE%\Corundum" > nul
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Creating the shortcut...

set "target=%USERPROFILE%\Corundum\main.bat"
set "shortcut_folder=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Enio Aiello"
set "shortcut_name=Corundum.lnk"

if not exist "%shortcut_folder%" (
    mkdir "%shortcut_folder%"
)

set "vbs_file=%temp%\create_shortcut.vbs"
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%vbs_file%"
echo Set oShellLink = WshShell.CreateShortcut("%shortcut_folder%\%shortcut_name%") >> "%vbs_file%"
echo oShellLink.TargetPath = "%target%" >> "%vbs_file%"
echo oShellLink.Save >> "%vbs_file%"

cscript //nologo "%vbs_file%" > nul
del "%vbs_file%" > nul
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Installation completed!
timeout /t 3 > nul
goto EndEN

:PortableModeEN
cls
echo Installation
echo.
echo You are about to install Corundum in portable mode.
set /p portable_location="Enter the location: "

if not exist "%portable_location%" (
    cls
    echo The location does not exist. Please try again.
    timeout /t 3 > nul
    goto PortableMode
)

mkdir "%portable_location%\Corundum" > nul
copy "%~dp0\main.bat" "%portable_location%\Corundum" > nul
copy "%~dp0\install.bat" "%portable_location%\Corundum" > nul
xcopy "%~dp0\utility" "%portable_location%\Corundum\utility" /s /e /i > nul
copy "%~dp0\README.md" "%portable_location%\Corundum" > nul
copy "%~dp0\LICENSE" "%portable_location%\Corundum" > nul
echo Portable installation completed!
timeout /t 3 > nul
goto EndEN

:CorundumInstalledEN
cls
echo Setup
echo.
echo Corundum is currently installed on your computer.
echo Please choose the action:
echo 1. Uninstall Corundum
echo 2. Update Corundum
echo 3. Modify startup option
set /p action="Enter your choice: "

if "%action%"=="1" goto UninstallCorundumEN
if "%action%"=="2" goto UpdateCorundumEN
if "%action%"=="3" goto ModifyStartupEN

cls
goto CorundumInstalledEN

:ModifyStartupEN
cls
echo Setup
echo.
echo Modify Startup Options
echo 1. Enable Corundum on startup
echo 2. Disable Corundum on startup
set /p startup_option="Enter your choice: "

if "%startup_option%"=="1" goto InstallNowShortcutEN
if "%startup_option%"=="2" goto DisableStartupEN

cls
goto ModifyStartupEN

:DisableStartupEN
cls
echo Setup
echo.
echo Status: Disabling startup...
del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Corundum.lnk" > nul
cls
echo Setup
echo.
echo Status: Startup has been disabled.
timeout /t 3 > nul
goto CorundumInstalledEN

:UninstallCorundumEN
cls
echo Setup
echo.
echo Please wait while Corundum is uninstalling.
echo.
echo Status: Uninstalling...
rmdir /s /q "%USERPROFILE%\Corundum" > nul
del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Corundum.lnk" > nul
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Enio Aiello\Corundum.lnk" > nul
cls
echo Setup
echo.
echo Please wait while Corundum is uninstalling.
echo.
echo Status: Uninstallation completed!
timeout /t 3 > nul
goto EndEN

:UpdateCorundumEN
cls
echo Setup
echo.
echo Please wait while setup is updating Corundum.
echo.
echo Status: Updating Corundum...
rmdir /s /q "%USERPROFILE%\Corundum\utility" > nul
copy "%~dp0\main.bat" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\install.bat" "%USERPROFILE%\Corundum" > nul
xcopy "%~dp0\utility" "%USERPROFILE%\Corundum\utility" /s /e /i > nul
cls
echo Setup
echo.
echo Please wait while setup is updating Corundum.
echo.
echo Status: Update completed!
timeout /t 3 > nul
goto EndEN

:EndEN
cls
echo Setup
echo.
echo The request has been completed successfully.
echo Press any key to exit the setup wizard.
pause > nul
exit

:french
cls
echo Installation
echo.
echo La version de Corundum dans ce package est v%VERSION%-%BRANCH%.
echo.
echo Veuillez choisir la méthode d'installation :
echo 1. Installer Corundum sur le disque dur
echo 2. Choisir un emplacement pour l'installation portable
set /p choice="Entrez votre choix : "

if "%choice%"=="1" goto StartCorundumStartupFR
if "%choice%"=="2" goto PortableModeFR

cls
goto StartInstallationFR

:StartCorundumStartupFR
cls
echo Installation
echo.
echo Corundum peut être lancé au démarrage de votre session Windows.
echo.
echo Souhaitez-vous lancer Corundum au démarrage de votre session Windows ?
echo 1. Activer cette option
echo 2. Désactiver cette option
echo 3. Quitter
set /p startup="Entrez votre choix : "

if "%startup%"=="1" goto InstallHardDiskShortcutFR
if "%startup%"=="2" goto InstallHardDiskFR
if "%startup%"=="3" goto StartInstallationFR

cls
goto StartCorundumStartupFR

:InstallHardDiskShortcutFR
cls
echo Installation
echo.
echo Vous êtes sur le point d'installer Corundum sur votre disque dur local (C:). Vous avez sélectionné l'exécution automatique au démarrage pour l'utilisateur %USERNAME%.
echo.
echo Veuillez choisir la méthode d'installation :
echo 1. Installer Corundum
echo 2. Retour
set /p install="Entrez votre choix : "

if "%install%"=="1" goto InstallNowShortcutFR
if "%install%"=="2" goto StartInstallationFR

cls
goto InstallHardDiskFR

:InstallNowShortcutFR
cls
echo Installation
echo.
echo Merci d'avoir choisi Corundum ! Dans quelques instants, Corundum sera installé sur votre ordinateur.
echo Restez sur cette fenêtre, l'installation ne prendra pas longtemps !
echo.
echo Statut : Création du dossier Corundum...
mkdir "%USERPROFILE%\Corundum" > nul
echo Statut : Copie des fichiers...
copy "%~dp0\main.bat" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\install.bat" "%USERPROFILE%\Corundum" > nul
xcopy "%~dp0\utility" "%USERPROFILE%\Corundum\utility" /s /e /i > nul
copy "%~dp0\README.md" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\LICENSE" "%USERPROFILE%\Corundum" > nul
cls
echo Installation
echo.
echo Merci d'avoir choisi Corundum ! Dans quelques instants, vous pourrez profiter de Corundum directement sur votre ordinateur.
echo Restez sur cette fenêtre, l'installation ne prendra pas longtemps !
echo.
echo Statut : Création du raccourci...

set "target=%USERPROFILE%\Corundum\main.bat"
set "shortcut_folder=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Enio Aiello"
set "shortcut_name=Corundum.lnk"

if not exist "%shortcut_folder%" (
    mkdir "%shortcut_folder%"
)

set "vbs_file=%temp%\create_shortcut.vbs"
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%vbs_file%"
echo Set oShellLink = WshShell.CreateShortcut("%shortcut_folder%\%shortcut_name%") >> "%vbs_file%"
echo oShellLink.TargetPath = "%target%" >> "%vbs_file%"
echo oShellLink.Save >> "%vbs_file%"

cscript //nologo "%vbs_file%" > nul
del "%vbs_file%" > nul
cls
echo Installation
echo.
echo Merci d'avoir choisi Corundum ! Dans quelques instants, Corundum sera installé sur votre ordinateur.
echo Restez sur cette fenêtre, l'installation ne prendra pas longtemps !
echo.
echo Statut : Ajout de Corundum au démarrage...
set "shortcut_folder=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"
if not exist "%shortcut_folder%" (
    mkdir "%shortcut_folder%"
)

set "vbs_file=%temp%\create_startup_shortcut.vbs"
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%vbs_file%"
echo Set oShellLink = WshShell.CreateShortcut("%shortcut_folder%\%shortcut_name%") >> "%vbs_file%"
echo oShellLink.TargetPath = "%target%" >> "%vbs_file%"
echo oShellLink.Save >> "%vbs_file%"

cscript //nologo "%vbs_file%" > nul
del "%vbs_file%" > nul

cls
echo Installation
echo.
echo Merci d'avoir choisi Corundum ! Dans quelques instants, vous pourrez profiter de Corundum directement sur votre ordinateur.
echo Restez sur cette fenêtre, l'installation ne prendra pas longtemps !
echo.
echo Statut : Installation terminée !
timeout /t 3 > nul
goto EndFR

:InstallHardDiskFR
cls
echo Installation
echo.
echo Vous êtes sur le point d'installer Corundum sur votre disque dur local (C:).
echo.
echo Veuillez choisir la méthode d'installation :
echo 1. Installer Corundum
echo 2. Retour
set /p install="Entrez votre choix : "

if "%install%"=="1" goto InstallNowWithoutStartupFR
if "%install%"=="2" goto StartInstallationFR

cls
goto InstallHardDiskFR

:InstallNowWithoutStartupFR
cls
echo Installation
echo.
echo Merci d'avoir choisi Corundum ! Dans quelques instants, Corundum sera installé sur votre ordinateur.
echo Restez sur cette fenêtre, l'installation ne prendra pas longtemps !
echo.
echo Statut : Création du dossier Corundum...
mkdir "%USERPROFILE%\Corundum" > nul
echo Statut : Copie des fichiers...
copy "%~dp0\main.bat" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\install.bat" "%USERPROFILE%\Corundum" > nul
xcopy "%~dp0\utility" "%USERPROFILE%\Corundum\utility" /s /e /i > nul
copy "%~dp0\README.md" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\LICENSE" "%USERPROFILE%\Corundum" > nul
cls
echo Installation
echo.
echo Merci d'avoir choisi Corundum ! Dans quelques instants, vous pourrez profiter de Corundum directement sur votre ordinateur.
echo Restez sur cette fenêtre, l'installation ne prendra pas longtemps !
echo.
echo Statut : Création du raccourci...

set "target=%USERPROFILE%\Corundum\main.bat"
set "shortcut_folder=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Enio Aiello"
set "shortcut_name=Corundum.lnk"

if not exist "%shortcut_folder%" (
    mkdir "%shortcut_folder%"
)

set "vbs_file=%temp%\create_shortcut.vbs"
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%vbs_file%"
echo Set oShellLink = WshShell.CreateShortcut("%shortcut_folder%\%shortcut_name%") >> "%vbs_file%"
echo oShellLink.TargetPath = "%target%" >> "%vbs_file%"
echo oShellLink.Save >> "%vbs_file%"

cscript //nologo "%vbs_file%" > nul
del "%vbs_file%" > nul
cls
echo Installation
echo.
echo Merci d'avoir choisi Corundum ! Dans quelques instants, vous pourrez profiter de Corundum directement sur votre ordinateur.
echo Restez sur cette fenêtre, l'installation ne prendra pas longtemps !
echo.
echo Statut : Installation terminée !
timeout /t 3 > nul
goto EndFR

:PortableModeFR
cls
echo Installation
echo.
echo Vous êtes sur le point d'installer Corundum en mode portable.
set /p portable_location="Entrez l'emplacement : "

if not exist "%portable_location%" (
    cls
    echo L'emplacement n'existe pas. Veuillez réessayer.
    timeout /t 3 > nul
    goto PortableModeFR
)

mkdir "%portable_location%\Corundum" > nul
copy "%~dp0\main.bat" "%portable_location%\Corundum" > nul
copy "%~dp0\install.bat" "%portable_location%\Corundum" > nul
xcopy "%~dp0\utility" "%portable_location%\Corundum\utility" /s /e /i > nul
copy "%~dp0\README.md" "%portable_location%\Corundum" > nul
copy "%~dp0\LICENSE" "%portable_location%\Corundum" > nul
echo Installation portable terminée !
timeout /t 3 > nul
goto EndFR

:EndFR
cls
echo Installation
echo.
echo La demande a été complétée avec succès.
echo Appuyez sur une touche pour quitter l'assistant d'installation.
pause > nul
exit