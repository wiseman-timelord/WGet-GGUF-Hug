REM Script: WGetLlmHug-Psc.Bat
@echo off
:: Initialization
mode con cols=60 lines=85
color 0E
title WGetLlmHug-Psc Launcher
echo.
echo Launcher Script Started...

REM Function
:menu
timeout /t 2 /nobreak >nul
cls
echo.
echo ====================( WGetLlmHug-Psc )======================
echo.
echo                   1. Start WGetLlmHug-Psc,
echo                   2. Check File Structure,
echo                      0. Exit Launcher.
echo.

REM Variables
set /p choice=Select, Options '1-2' or '0' To Exit : 
if "%choice%"=="1" goto startScript
if "%choice%"=="2" goto checkScript
if "%choice%"=="0" goto end
echo Invalid choice. Try again.
pause
goto menu

REM Function
:startScript
echo.
echo.
echo Launching PowerShellCore Script...
timeout /t 1 /nobreak >nul
pwsh.exe -NoProfile -ExecutionPolicy Bypass -File ".\main.ps1"
echo.
echo ...PowerShellCore Script Exited.
timeout /t 1 /nobreak >nul
goto end

REM Function
:checkScript
echo.
echo.
set missing=0
echo Checking Library Files...
timeout /t 1 /nobreak >nul

REM Function
if exist ".\libraries\wget.exe" (
    echo ...WGet Library Present.
) else (
    echo ...WGet Library Missing.
    set missing=1
)
echo.
echo Checking Program Folders...
timeout /t 1 /nobreak >nul

REM Function
if exist ".\libraries" (
    echo ...Libraries Folder Present.
) else (
    echo ...Libraries Folder Missing.
    set missing=1
)

REM Function
if exist ".\Completed" (
    echo ...Completed Folder Present.
) else (
    echo ...Completed Folder Missing.
    set missing=1
)

REM Function
if exist ".\cache" (
    echo ...Cache Folder Present.
) else (
    echo ...Cache Folder Missing.
    set missing=1
)
timeout /t 1 /nobreak >nul

REM Function
if %missing%==1 (
    echo.
    echo File Structure: Incorrect!
    echo.
    echo Run Setup-Install Now!
	echo.
    timeout /t 2 /nobreak >nul
	goto end
) else (
	echo.
    echo File Structure: Correct!
	echo.
        echo Returning To Menu...
	echo.
    timeout /t 2 /nobreak >nul
)
goto menu

REM Function
:end
echo.
echo ...Launcher Script Finished.
echo.
pause
