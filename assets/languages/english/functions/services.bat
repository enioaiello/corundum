@echo off
title Corundum maintenance

NET SESSION >nul 2>&1
if %errorlevel% NEQ 0 (
    powershell.exe -Command "Start-Process '%~0' -Verb RunAs"
    exit /b
)

:serviceManagement
cls
echo Service management
echo.
echo Welcome to the service management function!
echo This function allows you to start, stop, pause or resume a service.
echo You can also change the startup type of a service.
echo.
echo 1. Start a service
echo 2. Stop a service
echo 3. Pause a service
echo 4. Resume a service
echo 5. Change the startup type of a service
echo 6. Exit
echo.
set /p serviceChoice="Enter your choice: "

if "%serviceChoice%"=="1" goto startService
if "%serviceChoice%"=="2" goto stopService
if "%serviceChoice%"=="3" goto pauseService
if "%serviceChoice%"=="4" goto resumeService
if "%serviceChoice%"=="5" goto changeStartup
if "%serviceChoice%"=="6" goto home

goto serviceManagemnt

:startService
cls
echo Start a service
echo.
echo Type the name of the service you want to start.
echo.
set /p startServiceName="Service name: "
net start %startServiceName% > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to start %startServiceName%. 
    echo Press any key to exit.
) else (
    cls
    echo Start a service
    echo.
    echo %startServiceName% started successfully!
    echo.
    echo Press any key to exit.
)
pause > nul
goto serviceManagemnt

:stopService
cls
echo Stop a service
echo.
echo Type the name of the service you want to stop.
echo.
set /p stopServiceName="Service name: "
net stop %stopServiceName% > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to stop %stopServiceName%. 
    echo Press any key to exit.
) else (
    cls
    echo Stop a service
    echo.
    echo %stopServiceName% stopped successfully!
    echo.
    echo Press any key to exit.
)
pause > nul
goto serviceManagemnt

:pauseService
cls
echo Pause a service
echo.
echo Type the name of the service you want to pause.
echo.
set /p pauseServiceName="Service name: "
net pause %pauseServiceName% > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to pause %pauseServiceName%. 
    echo Press any key to exit.
) else (
    cls
    echo Pause a service
    echo.
    echo %pauseServiceName% paused successfully!
    echo.
    echo Press any key to exit.
)
pause > nul
goto serviceManagemnt

:resumeService
cls
echo Resume a service
echo.
echo Type the name of the service you want to resume.
echo.
set /p resumeServiceName="Service name: "
net continue %resumeServiceName% > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to resume %resumeServiceName%. 
    echo Press any key to exit.
) else (
    cls
    echo Resume a service
    echo.
    echo %resumeServiceName% resumed successfully!
    echo.
    echo Press any key to exit.
)
pause > nul
goto serviceManagemnt

:changeStartup
cls
echo Change the startup type of a service
echo.
echo Type the name of the service you want to change the startup type.
echo.
set /p changeStartupName="Service name: "
cls
echo Change the startup type of %changeStartupName%
echo.
echo Select the startup type by entering the corresponding number.
echo 1. Automatic
echo 2. Manual
echo 3. Disabled
echo.
set /p startupType="Enter your choice: "

if "%startupType%"=="1" goto automaticStartup
if "%startupType%"=="2" goto manualStartup
if "%startupType%"=="3" goto disabledStartup

goto changeStartup

:automaticStartup
cls
echo Change the startup type of %changeStartupName%
echo.
echo Setting the startup type to automatic, please wait.
sc config %changeStartupName% start= auto > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to set the startup type of %changeStartupName% to automatic. 
    echo Press any key to exit.
) else (
    cls
    echo Change the startup type of %changeStartupName%
    echo.
    echo The startup type of %changeStartupName% has been set to automatic successfully!
    echo.
    echo Press any key to exit.
)
pause > nul
goto serviceManagemnt

:manualStartup
cls
echo Change the startup type of %changeStartupName%
echo.
echo Setting the startup type to manual, please wait.
sc config %changeStartupName% start= demand > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to set the startup type of %changeStartupName% to manual. 
    echo Press any key to exit.
) else (
    cls
    echo Change the startup type of %changeStartupName%
    echo.
    echo The startup type of %changeStartupName% has been set to manual successfully!
    echo.
    echo Press any key to exit.
)
pause > nul
goto serviceManagemnt

:disabledStartup
cls
echo Change the startup type of %changeStartupName%
echo.
echo Setting the startup type to disabled, please wait.
sc config %changeStartupName% start= disabled > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to set the startup type of %changeStartupName% to disabled. 
    echo Press any key to exit.
) else (
    cls
    echo Change the startup type of %changeStartupName%
    echo.
    echo The startup type of %changeStartupName% has been set to disabled successfully!
    echo.
    echo Press any key to exit.
)
pause > nul
goto serviceManagemnt