@echo off
mode con cols=60 lines=30
color 0E
setlocal

:: Startup Welcome
echo.
echo Setup-Installer Initiated!
echo.
timeout /t 2 /nobreak >nul

:: Create necessary folders
cls
echo.
echo Checking Program Folders...
timeout /t 2 /nobreak >nul
if not exist ".\libraries" (
    echo Creating .\libraries folder...
    mkdir ".\libraries"
)
if not exist ".\temporary" (
    echo Creating .\temporary folder...
    mkdir ".\temporary"
)
if not exist ".\Completed" (
    echo Creating .\Completed folder...
    mkdir ".\Completed"
)
echo ...Folder Setup Complete.
timeout /t 4 /nobreak >nul

:menu
cls
echo.
echo.
echo.
echo.
echo                       -= OS Selection =-
echo.
echo                        1) x86 (32-Bit)
echo                        2) x64 (64-Bit)
echo                        3) ARM64 (????)
echo                        0) Exit Program
echo.

:: Prompt for user input
set /p choice="Enter your choice: "
echo.
timeout /t 2 /nobreak >nul

:: Process user input
if "%choice%"=="1" goto x86
if "%choice%"=="2" goto x64
if "%choice%"=="3" goto arm64
if "%choice%"=="0" exit
echo Invalid choice, try again.
pause
goto menu

:x86
set WGET_URL=https://eternallybored.org/misc/wget/1.21.4/32/wget.exe
goto prepare_download

:x64
set WGET_URL=https://eternallybored.org/misc/wget/1.21.4/64/wget.exe
goto prepare_download

:arm64
set WGET_URL=https://eternallybored.org/misc/wget/1.21.4/a64/wget.exe
goto prepare_download

:prepare_download
:: Delete existing wget.exe if it exists
if exist ".\libraries\wget.exe" (
    echo Deleting Existing WGet...
    del ".\libraries\wget.exe"
)
goto download

:download
:: Download wget using PowerShell
echo ...Download Pre-Compiled WGet...
powershell -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%WGET_URL%' -OutFile '.\libraries\wget.exe' }"
echo ...Download Process Finished.

:: Check if wget.exe exists in the target location
echo.
echo Checking For Download....
if exist ".\libraries\wget.exe" (
    echo ...WGet Install Success.
) else (
    echo ...WGet Install Failure.
)
echo.
timeout /t 2 /nobreak >nul

:end
echo Setup-Install Processes Copmplete!
pause
