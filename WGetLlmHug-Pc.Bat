@echo off

:: Initialization
mode con cols=60 lines=30
color 0E
title WGet-LLM-Hug Launcher
echo.
echo Launcher Script Started...
timeout /t 1 /nobreak >nul

:menu
cls
echo.
echo =====================( WGetLlmHug-Psc )=====================
echo.
echo.
echo                    1. Start WGetLlmHug-Psc,
echo.
echo                    0. Exit Launcher.
echo.
echo.
echo \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
set /p choice=Enter your choice: 

if "%choice%"=="1" goto startScript
if "%choice%"=="0" goto end
echo Invalid choice. Try again.
pause
goto menu

:startScript
echo.
echo Launching PowerShellCore Script...
timeout /t 1 /nobreak >nul
pwsh.exe -NoProfile -ExecutionPolicy Bypass -File ".\main.ps1"
echo.
echo ...PowerShellCore Script Exited.
timeout /t 1 /nobreak >nul
goto end

:end
echo.
echo ...Launcher Script Finished.
echo.
pause
