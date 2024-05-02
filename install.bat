@echo off
title Corundum installation
echo Welcome to Corundum installation script!
echo.
echo Corundum is a set of maintenance and administration scripts for Microsoft Windows.
echo Corundum is completely free of charge and can be installed or used in portable mode.
echo.
echo Note: Some features require elevation, and some features may not be compatible with older versions of Windows.
echo.
echo For this installation, you will need to have Git installed on your computer. If you don't have it, you can download it from the official website.
echo.
echo [31mInstallation may be interrupted if certain Windows Defender settings are enabled, such as controlled folder access. Before launching the installation, please check your settings, or temporarily deactivate your antivirus software (don't forget to reactivate it!).[0m
echo.
echo For more information about this program, see the official GitHub repository.
echo When you're ready, press any key to answer a few questions, then start the installation.
pause > nul
goto settings

:settings
cls
echo System settings
echo.
echo Select the type of installation by entering the corresponding number.
echo 1. Install Corundum on your hard disk
echo 2. Choose a place to install Corundum (portable mode)
set /p choice="Enter your choice: "

if "%choice%"=="1" goto InstallHardDisk
if "%choice%"=="2" goto PortableMode
echo Invalid choice. Please enter either 1 or 2.
pause
exit /b

:InstallHardDisk
cls
echo System settings
echo.
echo You are about to install Corundum on your local hard disk (C:). You can choose the type of installation you prefer, or select another installation mode.
echo.
echo Select the type of installation by entering the corresponding number.
echo 1. Install Corundum
echo 2. Go back
set /p install="Enter your choice: "

if "%install%"=="1" goto InstallNow
if "%install%"=="2" goto GoBackHome

:InstallNow
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
cd %USERPROFILE%
mkdir corundum
cd corundum
git clone https://github.com/enioaiello/corundum/

setlocal

set start_menu=%APPDATA%\Microsoft\Windows\Start Menu\Programs

set enio_aiello_folder=%start_menu%\Enio Aiello
if not exist "%enio_aiello_folder%" mkdir "%enio_aiello_folder%"

set main_bat_path="%USERPROFILE%\corundum\main.bat"

set shortcut_path=%enio_aiello_folder%\Corundum.lnk

if not exist %main_bat_path% (
    echo Error: main.bat does not exist.
    goto End
)

echo Creating shortcut...
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%shortcut_path%'); $Shortcut.TargetPath = '%main_bat_path%'; $Shortcut.Save()"

echo Shortcut created successfully!

:End
echo Installation complete.
pause > nul
endlocal

goto End

:GoBackHome
goto 

:PortableMode
echo Choosing a place to install Corundum (portable mode)...
REM Ajoutez ici le code pour choisir l'emplacement d'installation en mode portable
goto End

:End
cls
echo The installation has been canceled.
echo Press any key to exit the installation script.
pause > nul
exit