@echo off
title Corundum maintenance

NET SESSION >nul 2>&1
if %errorlevel% NEQ 0 (
    powershell.exe -Command "Start-Process '%~0' -Verb RunAs"
    exit /b
)

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
echo 2. Administrator status
echo 3. Exit
echo.
set /p usrSettingsToModify="Enter your choice: "

if "%usrSettingsToModify%"=="1" goto editPassword
if "%usrSettingsToModify%"=="2" goto changeAdminStatus
if "%usrSettingsToModify%"=="3" goto userAccManagemnt

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

:changeAdminStatus
cls
echo Change the administrator status of %modifyUserName%
echo.
echo Would you like to add or remove %modifyUserName% from the administrator group?
echo.
echo 1. Add
echo 2. Remove
echo.
set /p adminStatus="Enter your choice: "

if "%adminStatus%"=="1" goto addAdmin
if "%adminStatus%"=="2" goto removeAdmin

:addAdmin 
cls
echo Add %modifyUserName% to the administrator group
echo.
echo Adding %modifyUserName% to the administrator group, please wait.
net localgroup administrators %modifyUserName% /add > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to add %modifyUserName% to the administrator group. 
    echo Press any key to exit.
) else (
    cls
    echo Add %modifyUserName% to the administrator group
    echo.
    echo %modifyUserName% added to the administrator group successfully!
    echo.
    echo Press any key to exit.
)
pause > nul
goto userAccManagemnt

:removeAdmin
cls
echo Remove %modifyUserName% from the administrator group
echo.
echo Removing %modifyUserName% from the administrator group, please wait.
net localgroup administrators %modifyUserName% /delete > nul
if errorlevel 1 (
    cls
    echo Error
    echo.
    echo Failed to remove %modifyUserName% from the administrator group. 
    echo Press any key to exit.
) else (
    cls
    echo Remove %modifyUserName% from the administrator group
    echo.
    echo %modifyUserName% removed from the administrator group successfully!
    echo.
    echo Press any key to exit.
)
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