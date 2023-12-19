@echo off
mode con cols=60 lines=30
color 0E

:: Run Script
echo.
echo Launching PowerShell Script!
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\main.ps1"
echo.
echo PowerShell Script Exited!
echo.

:: Exit Launcher
pause