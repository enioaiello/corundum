@echo off
title Corundum maintenance

:software
cls
echo Software
echo.
echo Welcome to the software function!
echo This function allows you to install, update or remove programs via winget.
echo If you don't have winget installed, please install it before continuing.
echo.
echo 1. Install a program
echo 2. Update a program
echo 3. Remove a program
echo 4. Exit
echo.
set /p softwareChoice="Enter your choice: "

if "%softwareChoice%"=="1" goto installProgram
if "%softwareChoice%"=="2" goto updateProgram
if "%softwareChoice%"=="3" goto removeProgram
if "%softwareChoice%"=="4" goto home

goto software

:installProgram
cls
echo Install a program
echo.
echo Please enter the name of the program you want to install.
echo.
set /p programName="Program name: "
cls
echo Install a program
echo.
echo Searching for %programName%, please wait.
winget search --exact --name %programName% > temp.txt
for /f "tokens=1,2 delims= " %%a in ('findstr /i "%programName%" temp.txt') do (
    set packageID=%%a
    set packageName=%%b
)
if "%packageID%"=="" (
    cls
    echo Error
    echo.
    echo Could not find %programName%.
    echo Press any key to exit.
    pause > nul
    goto software
)
cls
echo Install a program
echo.
echo Installing %packageName% (%packageID%), please wait.
winget install --id %packageID% > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to install %programName%.
    echo Press any key to exit.
) else (
    cls
    echo Install a program
    echo.
    echo %programName% has been installed successfully!
    echo.
    echo Press any key to exit.
)
pause > nul
goto software

:updateProgram
cls
echo Update a program
echo.
echo Please enter the name of the program you want to update.
echo.
set /p programName="Program name: "
cls
echo Update a program
echo.
echo Searching for %programName%, please wait.
winget search --exact --name %programName% > temp.txt
for /f "tokens=1,2 delims= " %%a in ('findstr /i "%programName%" temp.txt') do (
    set packageID=%%a
    set packageName=%%b
)
if "%packageID%"=="" (
    cls
    echo Error
    echo.
    echo Could not find %programName%.
    echo Press any key to exit.
    pause > nul
    goto software
)
cls
echo Update a program
echo.
echo Updating %packageName% (%packageID%), please wait.
winget upgrade --id %packageID% > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to update %programName%.
    echo Press any key to exit.
) else (
    cls
    echo Update a program
    echo.
    echo %programName% has been updated successfully!
    echo.
    echo Press any key to exit.
)
pause > nul
goto software

:removeProgram
cls
echo Remove a program
echo.
echo Please enter the name of the program you want to remove.
echo.
set /p programName="Program name: "
cls
echo Remove a program
echo.
echo Searching for %programName%, please wait.
winget search --exact --name %programName% > temp.txt
for /f "tokens=1,2 delims= " %%a in ('findstr /i "%programName%" temp.txt') do (
    set packageID=%%a
    set packageName=%%b
)
if "%packageID%"=="" (
    cls
    echo Error
    echo.
    echo Could not find %programName%.
    echo Press any key to exit.
    pause > nul
    goto software
)
cls
echo Remove a program
echo.
echo Removing %packageName% (%packageID%), please wait.
winget uninstall --id %packageID% > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to remove %programName%.
    echo Press any key to exit.
) else (
    cls
    echo Remove a program
    echo.
    echo %programName% has been removed successfully!
    echo.
    echo Press any key to exit.
)
pause > nul
goto software