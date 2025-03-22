@echo off
title Corundum maintenance
:otherFunctions
cls
echo Other functions
echo.
echo Welcome to the other functions section!
echo This section allows you to perform other functions.
echo.
echo 1. Display system events
echo 2. Clean the current drive
echo 3. Launch an executable
echo 4. Exit
echo.
set /p otherChoice="Enter your choice: "
if "%otherChoice%"=="1" goto displayEvents
if "%otherChoice%"=="2" goto cleanDrive
if "%otherChoice%"=="3" goto startProgram
if "%otherChoice%"=="4" goto home

goto otherFunctions

:displayEvents
cls
echo Display system events
echo.
echo Press any key to display system events.
echo.
echo This will display the system events.
echo This will take a few seconds.
echo.
echo [31mPlease do not turn off your computer during the operation![0m
pause > nul
cls
echo Display system events
echo.
echo Displaying system events, please wait.
start eventvwr.msc
cls
echo Display system events
echo.
echo System events have been displayed in a new window successfully!
echo.
echo Press any key to return to home.
pause > nul
goto otherFunctions

:cleanDrive
cls
echo Cleaning the drive
echo.
echo Disk cleaning in the background, please wait.
start cleanmgr /autoclean
cls
echo Cleaning the drive
echo.
echo The operation was a success!
echo Press any key to return home.
pause > nul
goto otherFunctions

:startProgram
cls
echo Start a program
echo.
echo Type the path of the program you want to start.
echo.
set /p programPath="Program path: "
start %programPath%
cls
echo Start a program
echo.
echo The program has been started successfully!
echo.
echo Press any key to return to home.
pause > nul
goto home