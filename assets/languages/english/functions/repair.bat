@echo off
title Corundum maintenance

:repairWindows
cls
echo Repair
echo.
echo Welcome to the repair function!
echo This function allows you to repair Windows and diagnose hardware problems.
echo.
echo What type of repair would you like to do?
echo.
echo 1. Automatic Windows repair
echo 2. Manual Windows repair
echo 3. Hardware diagnosis
echo 4. Exit
echo.
set /p repairChoice="Enter your choice: "

if "%repairChoice%"=="1" goto automaticRepair
if "%repairChoice%"=="2" goto manualRepair
if "%repairChoice%"=="3" goto hardwareDiagnosis
if "%repairChoice%"=="4" goto home

goto repairWindows

:automaticRepair
cls
echo Automatic repair
echo.
echo Please disable your antivirus before starting the automatic repair.
echo If Corundum was not started as an administrator, please restart it as an administrator.
echo.
echo This will execute sfc /scannow and dism /online /cleanup-image /restorehealth.
echo This will take a few minutes.
echo.
echo Press any key to start the automatic repair.
pause > nul
cls
echo Automatic repair
echo.
echo Starting the automatic repair, please wait.
sfc /scannow > nul
dism /online /cleanup-image /restorehealth > nul
taskkill /f /im explorer.exe > nul
start explorer.exe > nul
cls
echo Automatic repair
echo.
echo The automatic repair has been completed successfully!
echo.
echo Press any key to return to home.
pause > nul
goto home

:manualRepair
cls
echo Manual repair
echo.
echo Please disable your antivirus before starting the manual repair.
echo If Corundum was not started as an administrator, please restart it as an administrator.
echo.
echo Please, enter the commands you want to execute.
echo The commands must be separated by &.
echo.
set /p manualCommand="Commands: "
cls
echo Manual repair
echo.
echo Starting the manual repair, please wait.
start cmd /c %manualCommand%
cls
echo Manual repair
echo.
echo The manual repair has been executed successfully!
echo.
echo Press any key to return to home.
pause > nul
goto home

:hardwareDiagnosis
cls
echo Hardware diagnosis
echo.
echo Please disable your antivirus before starting the hardware diagnosis.
echo If Corundum was not started as an administrator, please restart it as an administrator.
echo.
echo Please select a diagnostic:
echo.
echo 1. Memory diagnostic
echo 2. Disk diagnostic
echo 3. Battery report
echo 4. Malware Recovery Tools
echo 5. Exit
echo.
set /p hardwareChoice="Enter your choice: "

if "%hardwareChoice%"=="1" goto memoryDiagnostic
if "%hardwareChoice%"=="2" goto diskDiagnostic
if "%hardwareChoice%"=="3" goto batteryReport
if "%hardwareChoice%"=="4" goto malwareRecovery
if "%hardwareChoice%"=="5" goto home

goto hardwareDiagnosis

:memoryDiagnostic
cls
echo Memory diagnostic
echo.
echo Press any key to start the memory diagnostic.
echo.
echo This will start the Windows Memory Diagnostic tool.
echo This will take a few minutes.
echo.
echo [31mPlease do not turn off your computer during the operation![0m
pause > nul
cls
echo Memory diagnostic
echo.
echo Starting the memory diagnostic, please wait.
start mdsched.exe
cls
echo Memory diagnostic
echo.
echo The memory diagnostic has been executed successfully!
echo.
echo Press any key to return to home.
pause > nul
goto home

:diskDiagnostic
cls
echo Disk diagnostic
echo.
echo Press any key to start the disk diagnostic.
echo.
echo This will start the Windows Disk Diagnostic tool.
echo This will take a few minutes.
echo.
echo [31mPlease do not turn off your computer during the operation![0m
pause > nul
cls
echo Disk diagnostic
echo.
echo Starting the disk diagnostic, please wait.
start chkdsk /f /r
cls
echo Disk diagnostic
echo.
echo The disk diagnostic has been executed successfully!
echo.
echo Press any key to return home.
pause > nul
goto home

:batteryReport
cls
echo Battery report
echo.
echo This function will generate a battery-report in HTML at %USERPROFILE%.
echo And the battery-report will automatically be opened in your default PDF viewer.
echo.
echo Press any key to start.
pause > nul
powercfg /batteryreport > nul
start %USERPROFILE%\battery-report.html > nul
cls
echo Battery report
echo.
echo The battery report has been generated and opened successfully!
echo.
echo Press any key to return to home.
pause > nul
goto home

:malwareRecovery
cls
echo Malware Recovery Tools
echo.
echo This function launch MRT.
echo MRT doesn't replace an antivirus, it's a tool to remove malware.
echo.
echo Press any key to start.
pause > nul
start mrt > nul
cls
echo Malware Recovery Tools
echo.
echo MRT has been started successfully!
echo.
echo Press any key to return to home.
pause > nul
goto home