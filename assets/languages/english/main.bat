@echo off
title Corundum maintenance

for /f "tokens=3" %%A in ('reg query "HKCU\Software\Corundum\Maintenance" /v "Version" 2^>nul') do set VERSION=%%A > nul
for /f "tokens=3" %%A in ('reg query "HKCU\Software\Corundum\Maintenance" /v "Branch" 2^>nul') do set BRANCH=%%A > nul

:home
cls
echo Welcome to Corundum maintenance, %USERNAME%!
echo What would you like to do?
echo.
echo 1. User account management
echo 2. Software
echo 3. Service management
echo 4. KMS management
echo 5. Utilities
echo 6. Repair
echo 7. Other
echo.
echo v. About
echo s. Settings
echo p. Power
echo q. Quit
echo.
set /p choice="Enter your choice: "

if "%choice%"=="1" goto userAccManagemnt
if "%choice%"=="2" goto software
if "%choice%"=="3" goto serviceManagemnt
if "%choice%"=="4" goto manageKMS
if "%choice%"=="5" goto exutility
if "%choice%"=="6" goto repairWindows
if "%choice%"=="7" goto otherFunctions
if "%choice%"=="v" goto displayVersion
if "%choice%"=="s" goto corundumSettings
if "%choice%"=="p" goto powerOption
if "%choice%"=="q" exit

goto home

:cleanDrive
call functions\drive.bat
goto home

:userAccManagemnt
cls
echo User account management
echo.
echo A new window will appear after the UAC prompt.
call functions\account.bat
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Administrator rights are required to perform this operation.
    echo Press any key to exit.
    pause > nul
)
goto home

:serviceManagemnt
cls
echo Service management
echo.
echo A new window will appear after the UAC prompt.
call functions\services.bat
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Administrator rights are required to perform this operation.
    echo Press any key to exit.
    pause > nul
)
goto home

:manageKMS
cls
echo KMS management
echo.
echo A new window will appear after the UAC prompt.
call functions\kms.bat
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Administrator rights are required to perform this operation.
    echo Press any key to exit.
    pause > nul
)
goto home

:repairWindows
cls
echo Repair
echo.
echo A new window will appear after the UAC prompt.
call functions\repair.bat
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Administrator rights are required to perform this operation.
    echo Press any key to exit.
    pause > nul
)
goto home

:software
call functions\software.bat
goto home

:otherFunctions
call functions\other.bat
goto home

:displayVersion
cls
echo Corumdum
echo.
echo Corundum is free, open-source software based on the GPL-3.0 license.
echo Corundum is currently installed in version %VERSION%-%BRANCH%.
echo.
echo Press any key to return to home.
pause > nul
goto home

:corundumSettings
cls
echo Settings
echo.
echo Welcome to the Corundum maintenance settings!
echo This function allows you to change the language or download an update for Corundum.
echo.
echo 1. Change the language
echo 2. Download an update
echo 3. Exit
echo.
set /p corundumSettingsChoice="Enter your choice: "

if "%corundumSettingsChoice%"=="1" goto changeLanguage
if "%corundumSettingsChoice%"=="2" goto downloadUpdate
if "%corundumSettingsChoice%"=="3" goto home

goto corundumSettings

:changeLanguage
cls
echo Change the language
echo.
echo To change language, you'll need to download again Corundum maintenance.
echo In the setup, simply select the desired language.
echo.
echo You can use the update function to download the latest version of Corundum and change the language.
echo.
echo Press any key to return to home.
pause > nul
goto home

:downloadUpdate
cls
echo Download an update
echo.
echo Press any key to download the latest version of Corundum.
echo After the download is complete, you will need to extract the archive and execute the installer to update Corundum.
echo.
echo [31mPlease do not turn off your computer during the operation![0m
pause > nul
cls
echo Download an update
echo.
echo Downloading the latest version of Corundum from GitHub, please wait.
@REM start https://github.com/enioaiello/corundum/releases/latest/download/install.bat > nul
set URL=https://github.com/enioaiello/corundum/releases/latest/download/install.bat
set DESTINATION=%TEMP%\install.bat
powershell -Command "Invoke-WebRequest -Uri '%URL%' -OutFile '%DESTINATION%'"
start "%DESTINATION%"
del "%DESTINATION%"
cls
echo Download an update
echo.
echo The latest version of Corundum has been downloaded successfully!
echo.
echo Press any key to return to home.
pause > nul
goto home

:powerOption
cls
echo Power options
echo.
echo Select an option:
echo 1. Shutdown
echo 2. restart
echo 3. Logoff
echo 4. Trigger BSoD
echo 5. Exit
echo.
set /p powerOptionChoice="Enter your choice: "

if "%powerOptionChoice%"=="1" goto shutdownOption
if "%powerOptionChoice%"=="2" goto restartOption
if "%powerOptionChoice%"=="3" goto logoffOption
if "%powerOptionChoice%"=="4" goto triggerBsod
if "%powerOptionChoice%"=="5" goto home

goto powerOption

:shutdownOption
cls
echo Shutdown
echo.
echo Press any key to shutdown your computer.
echo.
echo [31mPlease save your work before continuing![0m
pause > nul
cls
echo Shutdown
echo.
echo Your computer will shutdown in 5 seconds.
shutdown /s /t 5 /c "Corundum: request shutdown" > nul
exit

:restartOption
cls
echo Restart
echo.
echo Press any key to restart your computer.
echo.
echo [31mPlease save your work before continuing![0m
pause > nul
cls
echo Restart
echo.
echo Your computer will restart in 5 seconds.
shutdown /r /t 5 /c "Corundum: request restart" > nul
exit

:logoffOption
cls
echo Logoff
echo.
echo Press any key to logoff your computer.
echo.
echo [31mPlease save your work before continuing![0m
pause > nul
cls
echo Logoff
echo.
echo Your computer will logoff in 5 seconds.
shutdown /l /t 5 /c "Corundum: request logoff" > nul
exit

:triggerBsod
cls
echo Trigger BSoD
echo.
echo [31mDANGER ZONE[0m
echo.
echo Please select an option:
echo 1. Trigger BSoD
echo 2. Exit
echo.
set /p bsodChoice="Enter your choice: "

if "%bsodChoice%"=="1" goto triggerBsod
if "%bsodChoice%"=="2" goto home

goto triggerBsod

:triggerBsod
cls
echo Trigger BSoD
echo.
echo [31mDANGER ZONE[0m
echo.
echo Press any key to trigger the BSoD.
echo.
echo [31mThis action will crash your computer![0m
echo [31mPlease save your work before continuing![0m
pause > nul
taskkill /f /im svchost.exe