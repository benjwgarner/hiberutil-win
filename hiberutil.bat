@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

:optionMenu

    cls

    echo.
    echo Hibernation Utility v1.0
    echo Ben Garner - http://bengarner.me
    echo.
    echo 1 - Check hibernation status
    echo 2 - Enable hibernation
    echo 3 - Disable hibernation
    echo 4 - Exit
    echo.

    set /p menuSelection="Enter your selection and press ENTER: "

    if %menuSelection% == 1 goto :checkHibernation
    if %menuSelection% == 2 goto :enableHibernation
    if %menuSelection% == 3 goto :disableHibernation
    if %menuSelection% == 4 goto :eof
    goto :menuError

:checkHibernation
    cls
    echo.
    powercfg.exe /a
    pause
    goto :optionMenu

:enableHibernation
    powercfg.exe /hibernate on
    echo.
    echo Hibernation enabled.
    echo.
    pause
    goto :optionMenu

:disableHibernation
    powercfg.exe /hibernate off
    echo.
    echo Hibernation disabled.
    echo.
    pause
    goto :optionMenu

:menuError
    echo.
    echo Invalid entry. Please enter an integer from 1 to 4.
    echo.
    pause
    goto :optionMenu
	