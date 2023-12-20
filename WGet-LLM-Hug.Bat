@echo off
mode con cols=60 lines=30
color 0E

:: Run Script
echo.
echo Launching PowerShell Script...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\main.ps1"
echo.

:: Exit Launcher
echo PowerShell Script Exited!
pause