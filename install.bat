@echo off
title Corundum installation

if exist "%USERPROFILE%\Corundum" (
    goto CorundumInstalled
) else (
    goto StartInstallation
)

:StartInstallation
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

goto settings

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
if "%install%"=="2" goto settings

:InstallNow
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
set %installLocation%=%USERPROFILE%\Corundum > nul
cd %USERPROFILE% > nul
git clone https://github.com/enioaiello/corundum.git > nul

setlocal

set start_menu=%APPDATA%\Microsoft\Windows\Start Menu\Programs > nul

set enio_aiello_folder=%start_menu%\Enio Aiello > nul
if not exist "%enio_aiello_folder%" mkdir "%enio_aiello_folder%" > nul

set main_bat_path="%USERPROFILE%\corundum\main.bat" > nul

set shortcut_path=%enio_aiello_folder%\Corundum.lnk > nul

if not exist %main_bat_path% (
    endlocal
    goto End
)

powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%shortcut_path%'); $Shortcut.TargetPath = '%main_bat_path%'; $Shortcut.Save()" > nul

goto EndFinish

:PortableMode
cls
echo Installation
echo.
echo In order to continue, please type the location where you want to install Corundum.
echo Example: C:\Users\YourName\Documents\
echo.
set /p installLocation="Enter the installation path: "
cd %installLocation%
git clone https://github.com/enioaiello/corundum.git
goto EndFinish

:EndFinish
cls
echo Installation
echo.
echo Installation complete.
echo Press any key to exit the installation script.
echo The program has been installed on your computer. You can now access it from the Start menu.
echo.
echo You can check the installed version by starting the program and type "v".
echo.
echo If you want to uninstall this script, you can relaunch this script and select the uninstall option.
echo.
echo Corundum has been installed in:
echo %installLocation%
pause > nul
exit

:End
cls
echo The installation has been canceled.
echo Press any key to exit the installation script.
pause > nul
exit

:EndUninstall
cls
echo Uninstallation
echo.
echo Uninstallation complete.
echo Press any key to exit the uninstallation script.
echo.
echo We're sorry to see you go. If you have any feedback, please let us know.
pause > nul
exit

:CorundumInstalled
cls
echo Installation
echo.
echo Corundum is already installed on your computer.
echo You can reinstall it or uninstall it via this page.
echo.
echo Select the type of installation by entering the corresponding number.
echo 1. Reinstall Corundum
echo 2. Uninstall Corundum
echo 3. Exit
echo.
set /p choice="Enter your choice: "

if "%choice%"=="1" goto Reinstall
if "%choice%"=="2" goto Uninstall
if "%choice%"=="3" goto End

goto CorundumInstalled

:Reinstall
cls
echo Installation
echo.
echo Please wait while Corundum is being reinstalled.
echo.
rmdir /s /q %USERPROFILE%\corundum > nul
goto InstallNow 

:Uninstall
cls
echo Installation
echo.
echo Please wait while Corundum is being uninstalled.
echo.
rmdir /s /q %USERPROFILE%\corundum > nul
rmdir /s /q %APPDATA%\Microsoft\Windows\Start Menu\Programs\Enio Aiello > nul
goto EndUninstall