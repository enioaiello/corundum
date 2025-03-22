@echo off
title Corundum maintenance

NET SESSION >nul 2>&1
if %errorlevel% NEQ 0 (
    powershell.exe -Command "Start-Process '%~0' -Verb RunAs"
    exit /b
)

:manageKMS
cls
echo KMS management
echo.
echo Welcome to the KMS management function!
echo This function allows you to activate or deactivate the KMS service.
echo.
echo 1. Activate KMS
echo 2. Deactivate KMS
echo 3. Exit
echo.
set /p kmsChoice="Enter your choice: "

if "%kmsChoice%"=="1" goto activateKMS
if "%kmsChoice%"=="2" goto deactivateKMS
if "%kmsChoice%"=="3" goto home

goto manageKMS

:activateKMS
cls
echo Activate KMS
echo.
echo Press any key to register a KMS provider.
echo.
echo This will activate the KMS service.
echo This will take a few seconds.
echo.
echo [31mPlease do not turn off your computer during the operation![0m
pause > nul
cls
echo Activate KMS
echo.
echo To register a KMS provider, you'll need the product key and the KMS server.
echo The default KMS provider is kms8.msguides.com.
echo.
echo If you want to change the KMS server, type the new KMS server. Otherwise, press Enter.
echo.
set /p kmsServer="KMS server: "
if "%kmsServer%"=="" set kmsServer=kms8.msguides.com
goto activateKMS

:activateKMS
cls
echo Activate KMS
echo.
echo One last step, please enter your product key.
echo.
set /p productKey="Product key: "

if "%kmsServer%"=="" 

cls
echo Activate KMS
echo.
echo Activating KMS, please wait.
slmgr /ipk %productKey% > nul
slmgr /skms %kmsServer% > nul
slmgr /ato > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to activate KMS. 
    echo Press any key to exit.
) else (
    cls
    echo Activate KMS
    echo.
    echo KMS activated successfully!
    echo.
    echo Press any key to exit.
)
pause > nul
goto manageKMS

:deactivateKMS
cls
echo Deactivate KMS
echo.
echo Press any key to unregister the KMS provider.
echo.
echo This will deactivate the KMS service.
echo This will take a few seconds.
echo.
echo [31mPlease do not turn off your computer during the operation![0m
pause > nul
cls
echo Deactivate KMS
echo.
echo Deactivating KMS, please wait.
slmgr /upk > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to deactivate KMS. 
    echo Press any key to exit.
) else (
    cls
    echo Deactivate KMS
    echo.
    echo KMS deactivated successfully!
    echo.
    echo Press any key to exit.
)
pause > nul
goto manageKMS