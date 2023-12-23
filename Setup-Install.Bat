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

if "%choice%"=="1" (
    set WGET_URL=https://eternallybored.org/misc/wget/1.21.4/32/wget.exe
    set SIGCHECK_EXE=sigcheck.exe
    goto prepare_download
)
if "%choice%"=="2" (
    set WGET_URL=https://eternallybored.org/misc/wget/1.21.4/64/wget.exe
    set SIGCHECK_EXE=sigcheck64.exe
    goto prepare_download
)
if "%choice%"=="3" (
    set WGET_URL=https://eternallybored.org/misc/wget/1.21.4/a64/wget.exe
    set SIGCHECK_EXE=sigcheck64a.exe
    goto prepare_download
)
if "%choice%"=="0" goto end
echo Invalid choice. Try again.
timeout /t 2 /nobreak >nul
goto menu

:prepare_download
echo.
echo Clearing Libraries...
if exist ".\libraries\wget.exe" del ".\libraries\wget.exe"
if exist ".\libraries\sigcheck.exe" del ".\libraries\sigcheck.exe"
echo ...Libraries Emptied.
echo.
echo Downloading Libraries...
timeout /t 1 /nobreak >nul
goto download_wget

:download_wget
powershell -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%WGET_URL%' -OutFile '.\libraries\wget.exe'; Invoke-WebRequest -Uri 'https://download.sysinternals.com/files/Sigcheck.zip' -OutFile '.\temporary\Sigcheck.zip' }"
echo ...Downloading Finished.
echo.
goto process_sigcheck

:process_sigcheck
echo Extracting and Preparing SigCheck...
powershell -Command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('.\temporary\Sigcheck.zip', '.\temporary'); Move-Item -Path '.\temporary\%SIGCHECK_EXE%' -Destination '.\libraries\sigcheck.exe' }"
del ".\temporary\Sigcheck.zip"
del ".\temporary\sigcheck*.exe"
echo ...SigCheck Preparation Complete.
echo.
goto check_libraries

:check_libraries
echo Checking For Libraries...
timeout /t 1 /nobreak >nul
if exist ".\libraries\wget.exe" (
    echo ...WGet Install Success.
) else (
    echo ...WGet Install Failure.
)
if exist ".\libraries\sigcheck.exe" (
    echo ...SigCheck Install Success.
) else (
    echo ...SigCheck Install Failure.
)
echo.
timeout /t 2 /nobreak >nul
goto end

:end
echo.
echo ...Setup-Install Processes Complete!
echo.
pause
