@echo off

:: Initialization
mode con cols=60 lines=30
color 0E
title Setup-Install Launcher
echo.
echo Setup-Installer Initiated...
timeout /t 1 /nobreak >nul

:: Create necessary folders
cls
echo.
echo ======================[ Setup-Install ]=====================
echo.
echo Checking Program Folders...
timeout /t 1 /nobreak >nul
if not exist ".\libraries" (
    echo Creating .\libraries folder...
    mkdir ".\libraries"
) else (
    echo ...libraries folder exists.
)
if not exist ".\temporary" (
    echo Creating .\temporary folder...
    mkdir ".\temporary"
) else (
    echo ...temporary folder exists.
)
if not exist ".\Completed" (
    echo Creating .\Completed folder...
    mkdir ".\Completed"
) else (
    echo ...Completed folder exists.
)
echo ...Folder Setup Complete.
timeout /t 3 /nobreak >nul

:menu
cls
echo.
echo ======================[ Setup-Install ]=====================
echo.
echo                       1. x86 (32-Bit),
echo                       2. x64 (64-Bit),
echo                       3. x64a (ARM64),
echo.
echo                       0. Exit Program.
echo.
echo.
echo \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
set /p choice=Enter your choice: 

if "%choice%"=="1" goto x86
if "%choice%"=="2" goto x64
if "%choice%"=="3" goto arm64
if "%choice%"=="0" goto end
echo Invalid choice. Try again.
timeout /t 2 /nobreak >nul
goto menu

:x86
set WGET_URL=https://eternallybored.org/misc/wget/1.21.4/32/wget.exe
echo.
echo x86 (32-Bit) Selected.
goto prepare_download

:x64
set WGET_URL=https://eternallybored.org/misc/wget/1.21.4/64/wget.exe
echo.
echo x64 (64-Bit) Selected.
goto prepare_download

:arm64
set WGET_URL=https://eternallybored.org/misc/wget/1.21.4/a64/wget.exe
echo.
echo x64a (ARM64) Selected.
goto prepare_download

:prepare_download
echo.
echo Preparing WGet Download ...
timeout /t 1 /nobreak >nul
if exist ".\libraries\wget.exe" (
    echo Deleting Existing WGet...
    del ".\libraries\wget.exe"
)
echo ...Preparation Is Complete.
goto download

:download
echo.
echo Downloading Pre-Compiled WGet...
powershell -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%WGET_URL%' -OutFile '.\libraries\wget.exe' }"
echo ...Download Process Finished.
echo.
echo Checking For Library...
timeout /t 1 /nobreak >nul
if exist ".\libraries\wget.exe" (
    echo ...WGet Install Success.
) else (
    echo ...WGet Install Failure.
)
echo.
timeout /t 2 /nobreak >nul
goto end

:end
echo.
echo ...Setup-Install Processes Complete!
echo.
pause
