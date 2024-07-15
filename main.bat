@echo off
title Corundum

NET SESSION >nul 2>&1
if %errorlevel% NEQ 0 (
    powershell.exe -Command "Start-Process '%~0' -Verb RunAs"
    exit /b
)

@REM net session >nul 2>&1
@REM if %errorLevel% == 0 (
@REM     goto home
@REM ) else (
@REM     echo Corundum
@REM     echo.
@REM     echo [31mPlease run this script as an administrator![0m
@REM     echo If you can, contact your system administrator.
@REM     echo.
@REM     echo Press any key to exit.
@REM     pause > nul
@REM     exit
@REM )

:home
cls
echo Welcome to Corundum, %USERNAME%!
echo What would you like to do?
echo.
echo 1. Cleaning the drive
echo 2. User account management
echo 3. Software
echo 4. Service management
echo 5. Display system events
echo 6. KMS management
echo 7. Launch an utility
echo 8. Start a program
echo 9. Repair
echo.
echo v. Display version
echo s. Corundum settings
echo p. Power
echo q. Quit
echo.
set /p choice="Enter your choice: "

if "%choice%"=="1" goto cleanDrive
if "%choice%"=="2" goto userAccManagemnt
if "%choice%"=="3" goto software
if "%choice%"=="4" goto serviceManagemnt
if "%choice%"=="5" goto displayEvents
if "%choice%"=="6" goto manageKMS
if "%choice%"=="7" goto exutility
if "%choice%"=="8" goto startProgram
if "%choice%"=="9" goto repairWindows
if "%choice%"=="v" goto displayVersion
if "%choice%"=="s" goto corundumSettings
if "%choice%"=="p" goto powerOption
if "%choice%"=="q" exit

goto home

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
goto home

:userAccManagemnt
cls
echo User account management
echo.
echo Welcome to the user account management function!
echo This function allows you to create, modify or delete users accounts.
echo You can also add or remove an user from a group.
echo.
echo 1. Create an user 
echo 2. Modify an user
echo 3. Delete an user 
echo 4. Add an user to a group
echo 5. Remove an user from a group
echo 6. Change UAC
echo 7. Exit
echo.
set /p usrChoice="Enter your choice: "

if "%usrChoice%"=="1" goto createUser
if "%usrChoice%"=="2" goto modifyUser
if "%usrChoice%"=="3" goto deleteUser
if "%usrChoice%"=="4" goto addGroup
if "%usrChoice%"=="5" goto removeGroup
if "%usrChoice%"=="6" goto manageUAC
if "%usrChoice%"=="7" goto home

goto userAccManagemnt

:createUser
cls
echo Create an user 
echo.
set /p newUserName="Enter a username: "
net user %newUserName% /add
goto newAdmin

:newAdmin
cls 
echo Create an user 
echo.
echo The user %newUserName% was created successfully!
set /p newUserAdmin="Would you like to add the new user to the administrator group? (y/n) "

if "%newUserAdmin%"=="y" goto registerAdmin
if "%newUserAdmin%"=="n" goto newUserEnd

goto newAdmin

:registerAdmin
net localgroup administrators "%newUserAdmin%" /add
goto newUserEnd

:newUserEnd
cls
echo Create an user
echo.
echo The operation ended successfully!
echo To add a password, modify the user account settings.
echo.
echo Summary:
echo Username: %newUserName%

if "%newUserAdmin%"=="y" echo Administrator: Yes
if "%newUserAdmin%"=="n" echo Administrator: No

echo.
echo Press any key to exit.
pause > nul
goto userAccManagemnt

:modifyUser
cls
echo Modify an user
echo.
echo Which user would you like to change?
echo.
set /p modifyUserName="Username: "

goto modifyUserSettings

:modifyUserSettings
cls
echo Modify %modifyUserName%
echo.
echo Which parameter do you want to change?
echo 1. Password
echo.
echo Type exit to return to home.
echo.
set /p usrSettingsToModify="Enter your choice: "

if "%usrSettingsToModify%"=="1" goto editPassword
if "%usrSettingsToModify%"=="exit" goto userAccManagemnt

goto modifyUserSettings

:editPassword
cls
echo Modify the password of %modifyUserName%
echo.
echo Tip: Use at least 8 characters, including numbers, letters, special characters and no personal information.
echo.
set /p newPassword="Enter a new password for %modifyUserName%: "
net user %modifyUserName% %newPassword%
cls
echo Modify the password
echo.
echo The password for %modifyUserName% has been modified successfully.
echo.
echo Press any key to return to home.
pause > nul
goto userAccManagemnt

:deleteUser
cls
echo Delete an user
echo.
echo [31mThis action will delete all data linked to the deleted user![0m
echo.
echo To continue, press any key.
pause > nul
cls 
echo Delete an user
echo.
set /p accountDelName="Type the username to be deleted: "
cls
echo Delete an user
echo.
echo Deleting an user, please wait.
net user %accountDelName% /delete > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to delete %accountDelName%. 
    echo Press any key to exit.
) else (
    cls
    echo Delete an user
    echo.
    echo %accountDelName% deleted successfully!
    echo.
    echo Press any key to exit.
)
pause > nul
goto userAccManagemnt

:addGroup 
cls
echo Add an user to a group
echo.
echo This utility supports only the administrator and the default user account group.
echo.
set /p userNewGroup="Type the username to be modified: "
cls
echo Add %userNewGroup% to a group
echo.
echo Type the name of the group to which you want to add %userNewGroup%.
echo.
set /p addUserToGroup="Localgroup: "
net localgroup %addUserToGroup% "%userNewGroup%" /add > nul

if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to add %userNewGroup% to %addUserToGroup%. 
    echo Press any key to exit.
) else (
    cls
    echo %userNewGroup% added to %addUserToGroup%
    echo.
    echo You may need to restart your computer for the changes to take effect.
    echo Press any key to exit.
)
pause > nul
goto userAccManagemnt

:removeGroup
cls
echo Remove an user from a group
echo.
echo This utility supports only the administrator and the default user account group.
echo.
set /p userRemoveGroup="Type the username to be modified: "
cls
echo Remove %userRemoveGroup% from a group
echo.
echo Type the name of the group from which you want to remove %userRemoveGroup%.
echo.
set /p removeUserFromGroup="Localgroup: "
net localgroup %removeUserFromGroup% "%userRemoveGroup%" /delete > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to remove %userRemoveGroup% to %removeUserFromGroup%. 
    echo Press any key to exit.
) else (
    cls
    echo %userRemoveGroup% removed to %removeUserFromGroup%
    echo.
    echo You may need to restart your computer for the changes to take effect.
    echo Press any key to exit.
)
pause > nul
goto userAccManagemnt

:manageUAC
cls
echo Change UAC
echo.
echo Press any key to change the UAC level.
echo [31mThis action could harm your computer![0m
echo.
pause > nul
cls
echo Change UAC
echo.
echo Select the UAC level by entering the corresponding number.
echo 1. Always notify
echo 2. Never notify
echo.
set /p uacLevel="Enter your choice: "

if "%uacLevel%"=="1" goto alwaysNotify
if "%uacLevel%"=="2" goto disableUAC

goto manageUAC

:alwaysNotify
cls
echo Change UAC
echo.
echo Setting UAC to always notify, please wait.
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 1 /f
cls
echo Change UAC
echo.
echo UAC set to always notify successfully!
echo.
echo Press any key to return to home.
pause > nul
goto userAccManagemnt

:disableUAC
cls
echo Change UAC
echo.
echo Disabling UAC, please wait.
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
cls
echo Change UAC
echo.
echo UAC disabled successfully!
echo.
echo Press any key to return to home.
pause > nul
goto userAccManagemnt

:updateWinPrgm
cls
echo Update Windows and installed programs
echo.
echo Press any key to update Windows and installed programs.
echo.
echo This will install the latest updates for Windows and installed programs.
echo This will take a few minutes.
echo.
echo [31mPlease do not turn off your computer during the update![0m
pause > nul
cls
echo Update Windows and installed programs
echo.
echo Updating Windows and installed programs, please wait.
start ms-settings:windowsupdate-action
cls
echo Update Windows and installed programs
echo.
echo Windows and installed programs have been updated successfully!
echo.
echo Press any key to return to home.
pause > nul
goto home

:serviceManagemnt
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
goto home

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
echo Starting adwcleaner, please wait.
start /B "AdwCleaner" "%~dp0utility\adwcleaner.exe" /eula
start /B "AdwCleaner" "%~dp0utility\adwcleaner.exe" /clean /preinstalled
cls
echo Execute adwcleaner
echo.
echo Adwcleaner has been executed successfully!
echo.
echo Press any key to return to home.
pause > nul
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
    echo 4. Custom utility
) else (
    echo 4. Custom utility (Setup^)
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

echo 2. Exit
echo.
set /p offlineUtilityChoice="Enter your choice: "

if "%offlineUtilityChoice%"=="1" goto adwCleaner
if "%offlineUtilityChoice%"=="2" goto exutility

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


:displayVersion
cls
echo Corumdum
echo.
echo Corundum is free, open-source software based on the GPL-3.0 license.
echo Corundum is currently installed in version 1.0.0-stable.
echo.
echo Press any key to return to home.
pause > nul
goto home

:corundumSettings
cls
echo Corundum settings
echo.
echo Welcome to the Corundum settings function!
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
echo Due to complication with the development, this function is currently disabled.
echo.
echo Press any key to return to Corundum settings.
pause > nul
goto corundumSettings

@REM echo Change the language
@REM echo.
@REM echo Please select the language you want to use.
@REM echo.
@REM echo 1. English (default)
@REM echo 2. French (not available)
@REM echo 3. Exit
@REM echo.

@REM set /p languageChoice="Enter your choice: "

@REM if "%languageChoice%"=="1" goto englishLanguage
@REM if "%languageChoice%"=="2" goto frenchLanguage
@REM if "%languageChoice%"=="3" goto corundumSettings

@REM goto changeLanguage

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
start https://github.com/enioaiello/corundum/releases/latest/download/corundum.zip > nul
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