@echo off
setlocal

rem Check for administrative rights
openfiles >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo *** This script requires administrative privileges. ***
    echo *** Please right-click the script and select "Run as administrator". ***
    pause
    exit /b 1
)

set "script_path=%~dp0"

call :backup_and_link "%script_path%.gitconfig" "%USERPROFILE%\.gitconfig"
call :backup_and_link "%script_path%.gitignore" "%USERPROFILE%\.gitignore"
call :backup_and_link "%script_path%.gitconfig.user" "%USERPROFILE%\.gitconfig.user"

call :backup_and_link "%script_path%.editorconfig" "%USERPROFILE%\.editorconfig"

call :backup_and_link "%script_path%.npmrc" "%USERPROFILE%\.npmrc"
call :backup_and_link "%script_path%.yarnrc.yml" "%USERPROFILE%\.yarnrc.yml"
call :backup_and_link "%script_path%bunfig.toml" "%USERPROFILE%\.bunfig.toml"

if not exist "%APPDATA%\uv" mkdir "%APPDATA%\uv"
if not exist "%APPDATA%\pip" mkdir "%APPDATA%\pip"

call :backup_and_link "%script_path%.config\uv\uv.toml" "%APPDATA%\uv\uv.toml"
call :backup_and_link "%script_path%.config\pip\pip.conf" "%APPDATA%\pip\pip.ini"

pause

rem ----------------------------
rem    End of the main body
rem ----------------------------


:backup_and_link
set "src=%~1"
set "dest=%~2"

rem Check if destination exists and is a symlink
if exist "%dest%" (
    fsutil reparsepoint query "%dest%" >nul 2>&1
    if %ERRORLEVEL% equ 0 (
        echo Removing symlink %dest%
        del "%dest%"
    ) else (
        echo File %dest% already existed, backing it up to %dest%.bak...
        move "%dest%" "%dest%.bak"
    )
)

echo Creating symlink %dest% to %src%
mklink "%dest%" "%src%"
if %ERRORLEVEL% neq 0 (
    echo Failed to create symlink %dest% to %src%
)

echo:

goto :eof

endlocal
