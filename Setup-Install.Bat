REM Script: Setup-Install.Bat
@echo off
:: Initialization
mode con cols=60 lines=30
color 0E
title Setup-Install Launcher
echo.
echo Setup-Installer Initiated...

REM Function
:menu
timeout /t 2 /nobreak >nul
cls
echo.
echo ======================[ Setup-Install ]=====================        
echo.
echo                        1. x86 (32-Bit),
echo                        2. x64 (64-Bit),
echo                        3. x64a (ARM64),
echo                       0. Exit Installer.
echo.

REM Variables
set /p choice=Select, Architecture '1-3' or '0' To Exit: 

REM Function
if "%choice%"=="1" (
    set WGET_URL=https://eternallybored.org/misc/wget/1.21.4/32/wget.exe
    goto prepare_download
)

REM Function
if "%choice%"=="2" (
    set WGET_URL=https://eternallybored.org/misc/wget/1.21.4/64/wget.exe
    goto prepare_download
)

REM Function
if "%choice%"=="3" (
    set WGET_URL=https://eternallybored.org/misc/wget/1.21.4/a64/wget.exe
    goto prepare_download
)
if "%choice%"=="0" goto end
echo.
echo Invalid choice. Try again.
goto menu

REM Function
:prepare_download
echo.
echo.
echo Checking Program Folders...
timeout /t 1 /nobreak >nul

REM Function
if not exist ".\libraries" (
    echo Creating .\libraries folder...
    mkdir ".\libraries"
    echo ...Libraries Folder Created.
)

REM Function
if not exist ".\cache" (
    echo Creating .\cache folder...
    mkdir ".\cache"
    echo ...Cache Folder Created.
)

REM Function
if not exist ".\Completed" (
    echo Creating .\Completed folder...
    mkdir ".\Completed"
    echo ...Completed Folder Created.
)
echo ...Folders Setup Complete.
timeout /t 2 /nobreak >nul
echo.
echo Clearing Libraries...
if exist ".\libraries\*.exe" del ".\libraries\*.exe"
echo ...Libraries Emptied.
echo.
timeout /t 1 /nobreak >nul
echo Clearing Cache...
if exist ".\cache\*.txt" del ".\cache\*.txt"
if exist ".\cache\*.exe" del ".\cache\*.exe"
if exist ".\cache\*.zip" del ".\cache\*.zip"
echo ...Cache Emptied.
echo.
goto download_files

REM Function
:download_files
echo Downloading WGet...
timeout /t 1 /nobreak >nul
powershell -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%WGET_URL%' -OutFile '.\libraries\wget.exe' }"
echo WGet Download Finished.
echo.

REM Function
:cleanup_process
timeout /t 1 /nobreak >nul
echo Deleting Cache Files...
if exist ".\cache\*.txt" del ".\cache\*.txt"
if exist ".\cache\*.exe" del ".\cache\*.exe"
if exist ".\cache\*.zip" del ".\cache\*.zip"
echo ...Cache Files Deleted.
echo.
goto check_libraries

REM Function
:check_libraries
timeout /t 2 /nobreak >nul
cls
echo.
echo ======================[ Setup-Install ]=====================
echo.
echo Checking For Libraries...
echo.
dir .\libraries
echo.

REM Function
if exist ".\libraries\wget.exe" (
    echo ...WGet Install Success.
) else (
    echo ...WGet Install Failure.
)
echo.
timeout /t 2 /nobreak >nul
goto end

REM Function
:end
echo.
echo ...Setup-Install Processes Completed!
echo.
pause
