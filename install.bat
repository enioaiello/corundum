@echo off
title Corundum Setup

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

:StartInstallation
echo Installation
echo.
echo Welcome to the Corundum installation wizard.
echo.
echo The Corundum version in this package is v1.1.0-stable.
echo.
echo Please choose the installation method:
echo 1. Install Corundum on the hard disk
echo 2. Choose a location for the portable installation
set /p choice="Enter your choice: "

if "%choice%"=="1" goto InstallHardDisk
if "%choice%"=="2" goto PortableMode

cls
goto StartInstallation

:InstallHardDisk
cls
echo Installation
echo.
echo You are about to install Corundum on your local hard disk (C:). You can choose the type of installation you prefer, or select another installation mode.
echo.
echo Please choose the installation method:
echo 1. Install Corundum
echo 2. Go back
set /p install="Enter your choice: "

if "%install%"=="1" goto InstallNow
if "%install%"=="2" goto StartInstallation

cls
goto InstallHardDisk

:InstallNow
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Initiliasation...
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Creating the Corundum folder...
mkdir "%USERPROFILE%\Corundum" > nul
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
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
goto End

:PortableMode
cls
echo Installation
echo.
echo You are about to install Corundum in portable mode. Please choose the location where you want to install Corundum.
echo Note: The location must exist on your computer.
echo The Corundum folder will be created in the location you choose.
echo Example: C:\Users\John\Documents
echo.
set /p portable_location="Enter the location: "

if not exist "%portable_location%" (
    cls
    echo Installation
    echo.
    echo The location you entered does not exist. Please try again.
    timeout /t 3 > nul
    goto PortableMode
)

cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Creating the Corundum folder...
mkdir "%portable_location%\Corundum" > nul
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Copying files...
copy "%~dp0\main.bat" "%portable_location%\Corundum" > nul
copy "%~dp0\install.bat" "%portable_location%\Corundum" > nul
xcopy "%~dp0\utility" "%portable_location%\Corundum\utility" /s /e /i > nul
copy "%~dp0\README.md" "%portable_location%\Corundum" > nul
copy "%~dp0\LICENSE" "%portable_location%\Corundum" > nul
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Installation completed!
timeout /t 3 > nul
goto End

:CorundumInstalled
echo Setup wizard
echo.
echo Corundum is currently installed on your computer.
echo The Corundum version in this package is v1.1.0-stable.
echo You can uninstall Corundum or update it here.
echo.
echo Please choose the action you want to perform:
echo 1. Uninstall Corundum
echo 2. Update Corundum
set /p action="Enter your choice: "

if "%action%"=="1" goto UninstallCorundum
if "%action%"=="2" goto UpdateCorundum

cls
goto CorundumInstalled

:UninstallCorundum
cls
echo Uninstallation
echo.
echo You are about to uninstall Corundum from your computer. Are you sure you want to continue?
echo.
echo Please choose the action you want to perform:
echo 1. Uninstall Corundum
echo 2. Go back
set /p uninstall="Enter your choice: "

if "%uninstall%"=="1" goto UninstallNow
if "%uninstall%"=="2" goto CorundumInstalled

goto UninstallCorundum

:UninstallNow
cls
echo Uninstallation
echo.
echo Thank you for using Corundum! We're sorry to see you go.
echo In a few moments, Corundum will be uninstalled from your computer.
echo.
echo Status: Removing the Corundum folder...
rmdir /s /q "%USERPROFILE%\Corundum" > nul
cls
echo Uninstallation
echo.
echo Thank you for using Corundum! We're sorry to see you go.
echo In a few moments, Corundum will be uninstalled from your computer.
echo.
echo Status: Removing the shortcut...
rmdir /s /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Enio Aiello" > nul
cls
echo Uninstallation
echo.
echo Thank you for using Corundum! We're sorry to see you go.
echo In a few moments, Corundum will be uninstalled from your computer.
echo.
echo Status: Uninstallation completed!
timeout /t 3 > nul
goto End

:UpdateCorundum
cls
echo Update
echo.
echo You are about to update Corundum on your computer. Please wait while the update is being performed.
echo Note: You'll need Git installed on your computer to update Corundum.
echo.
echo Status: Updating Corundum...
copy "%~dp0\main.bat" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\install.bat" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\utility" "%USERPROFILE%\Corundum\utility" > nul
copy "%~dp0\README.md" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\LICENSE" "%USERPROFILE%\Corundum" > nul
cls
echo Update
echo.
echo You are about to update Corundum on your computer. Please wait while the update is being performed.
echo Note: You'll need Git installed on your computer to update Corundum.
echo.
echo Status: Update completed!
timeout /t 3 > nul
goto End

:End
cls
echo Setup wizard
echo.
echo The request has been completed successfully.
echo Press any key to exit the setup wizard.
pause > nul
exit
