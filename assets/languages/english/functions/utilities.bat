@echo off
title Corundum maintenance

goto exutility

:adwCleaner
cls
echo Execute adwcleaner
echo.
echo Press any key to execute adwcleaner.
echo.
echo This will start the adwcleaner program.
echo This will take a few seconds.
echo Your computer will reboot after the operation.
echo.
echo [31mPlease do not turn off your computer during the operation![0m
pause > nul
cls
echo Execute adwcleaner
echo.
echo Executing adwcleaner, please wait.
start /B "AdwCleaner" "%~dp0utility\adwcleaner.exe" /eula > nul
start /B "AdwCleaner" "%~dp0utility\adwcleaner.exe" /clean /preinstalled
timeout 5 > nul
cls
echo Execute adwcleaner
echo.
echo Adwcleaner has been executed successfully!
echo.
echo Press any key to return to home.
pause > nul
goto home

:OOSHUT
cls
echo Execute OOSU10
echo.
echo OOSU10 has been opened in a new window.
start %~dp0utility\OOSU10.exe > nul
timeout 5 > nul
goto home

:ISO
cls
echo Execute Windows-ISO-Downloader
echo.
echo Windows-ISO-Downloader has been opened in a new window.
start %~dp0utility\Windows-ISO-Downloader.exe > nul
timeout 5 > nul
goto home

:exutility
cls
echo Launch an utility
echo.
echo What type of utility would you like to launch?
echo.
echo 1. Online utility
echo 2. Offline utility
echo 3. Custom online utility
if exist "%~dp0utility\custom" (
    echo 4. Custom offline utility
) else (
    echo 4. Setup custom offline utility
)
echo 5. Exit
echo.
set /p utilityChoice="Enter your choice: "

if "%utilityChoice%"=="1" goto onlineUtility
if "%utilityChoice%"=="2" goto offlineUtility
if "%utilityChoice%"=="3" goto customUtility
if "%utilityChoice%"=="4" goto userUtility
if "%utilityChoice%"=="5" goto home

goto exutility

:onlineUtility
cls
echo Launch an online utility
echo.
echo What utility do you want to start?
echo.
echo 1. Chris Titus Tools
echo 2. Revert8Plus
echo 3. Exit
echo.
set /p onlineUtilityChoice="Enter your choice: "

if "%onlineUtilityChoice%"=="1" goto chrisTitusTools
if "%onlineUtilityChoice%"=="2" goto revert8plus
if "%onlineUtilityChoice%"=="3" goto exutility

goto onlineUtility

:chrisTitusTools
cls
echo Launch Chris Titus Tools
echo.
echo This action will open the Chris Titus Tools in a new Powershell window.
echo.
echo [31mThis tool is external, be careful![0m
echo.
echo Press any key to start Chris Titus Tools.
pause > nul
cls
echo Launch Chris Titus Tools
echo.
echo Starting Chris Titus Tools, please wait.
@REM start powershell -windowstyle -command "irm https://christitus.com/win | iex" > nul
powershell -Command "Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command \"& {irm https://christitus.com/win | iex}\"' -Verb RunAs" > nul
cls
echo Launch Chris Titus Tools
echo.
echo Chris Titus Tools has been started successfully!
echo.
echo Press any key to return to home.
pause > nul
goto home

:revert8plus
cls
echo Launch Revert8Plus
echo.
echo This action will open the Revert8Plus utility.
echo This will transform your Windows 8.1 UI or Windows 10 UI into Windows 7 UI.
echo.
echo [31mThis tool is external, be careful![0m
echo [31mPlease do a backup before launching.[0m
echo.
echo Press any key to start Revert8Plus.
pause > nul
cls
echo Launch Revert8Plus
echo.
echo Starting Revert8Plus, please wait.
@REM start powershell -windowstyle -command "irm https://christitus.com/win | iex" > nul
powershell iex (irm r8p.teknixstuff.com)
cls
echo Launch Revert8Plus
echo.
echo Revert8Plus has been started successfully!
echo.
echo Press any key to return to home.
pause > nul
goto home

:offlineUtility
cls
echo Launch an offline utility
echo.
echo What utility do you want to start?
echo.
@REM Check if the AdwCleaner utility is present, if it is, display it in the menu. If it is not, display "Not installed"
if exist "%~dp0utility\adwcleaner.exe" (
    echo 1. AdwCleaner
) else (
    echo 1. AdwCleaner (Not installed^)
)

@REM Check if the OOSU10 utility is present, if it is, display it in the menu. If it is not, display "Not installed"
if exist "%~dp0utility\OOSU10.exe" (
    echo 2. OOSU10
) else (
    echo 2. OOSU10 (Not installed^)
)

@REM Check if the Windows-ISO-Downloader utility is present, if it is, display it in the menu. If it is not, display "Not installed"
if exist "%~dp0utility\Windows-ISO-Downloader.exe" (
    echo 3. Windows-ISO-Downloader
) else (
    echo 3. Windows-ISO-Downloader (Not installed^)
)

echo 4. Exit
echo.
set /p offlineUtilityChoice="Enter your choice: "

if "%offlineUtilityChoice%"=="1" goto adwCleaner
if "%offlineUtilityChoice%"=="2" goto OOSHUT
if "%offlineUtilityChoice%"=="3" goto ISO
if "%offlineUtilityChoice%"=="4" goto exutility

goto offlineUtility

:customUtility
cls
echo Launch a custom online utility
echo.
echo Type the URL of the utility you want to start.
echo The utility need to be a Powershell script.
echo.
set /p customUtilityURL="Utility URL: "
cls
echo Launch a custom online utility
echo.
echo Starting the utility, please wait.
start powershell -windowstyle -command "irm %customUtilityURL% | iex" > nul
cls
echo Launch a custom online utility
echo.
echo The utility has been started successfully!
echo.
echo Press any key to return to home.
pause > nul
goto home

:userUtility
cls
echo Launch a custom utility
echo.
if exist "%~dp0utility\custom" (
    echo What utility do you want to start?
    echo.
    setlocal enabledelayedexpansion
    set "count=1"
    set "found=0"
    for /r "%~dp0utility\custom" %%G in (*.exe, *.bat, *.ps1) do (
        echo !count!. %%~nG
        set "utility!count!=%%G"
        set /a "count+=1"
        set "found=1"
    )
    if "!found!"=="0" (
        echo No utilities found.
        echo Press any key to return to home.
        pause > nul
        goto exutility
    ) else (
        echo !count!. Exit
        set "utility!count!=Exit"
        set /p choice="Enter your choice: "
        for /l %%i in (1, 1, !count!) do (
            if "!choice!"=="%%i" (
                if "!utility%%i!"=="Exit" (
                    goto exutility
                ) else (
                    start "" "!utility%%i!"
                )
            )
        )
    )
    endlocal
    pause > nul

    goto userUtility
) else (
    echo No custom utility found.
    echo.
    echo Do you want to install a custom utility environment? (y/n^)
    set /p installCustom="Enter your choice: "
    if "%installCustom%"=="y" goto installCustom
    if "%installCustom%"=="n" goto exutility
)

:installCustom
cls
echo Install a custom utility environement
echo.
echo This action will install a custom utility environement.
echo This will take a few seconds.
echo.
echo Press any key to install the custom utility environement.
pause > nul
cls
echo Install a custom utility environement
echo.
echo Installing the custom utility environement, please wait.
mkdir "%~dp0utility\custom" > nul
cls
echo Install a custom utility environement
echo.
echo The custom utility environement has been installed successfully!
echo.
echo Press any key to return to home.
pause > nul
goto home