@echo off
setlocal

:: Set the download URL and destination file
set "url=https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe"
set "destination=%TEMP%\putty.exe"

:: Check if the script is already running with elevated privileges
>nul 2>&1 "%SYSTEMROOT%\System32\cacls.exe" "%SYSTEMROOT%\System32\config\system"

if %errorlevel% neq 0 (
    echo Running with elevated privileges...
    goto :runScript
)

:: If not running with elevated privileges, relaunch the script with elevation
echo Running without elevated privileges, relaunching...
set "scriptPath=%~dpnx0"
set "batchArguments=%*"
powershell -Command "Start-Process -Verb RunAs -FilePath '%scriptPath%' -ArgumentList '%batchArguments%'"

:: Exit the current instance of the script
exit /b

:runScript
:: Download the file silently
curl -o "%destination%" -L --silent "%url%" || wget -q -O "%destination%" "%url%"

:: Check if the download was successful
if %errorlevel% equ 0 (
    echo PuTTY downloaded successfully to: %destination%
    :: Run PuTTY
    start "" "%destination%"
) else (
    echo Error downloading PuTTY.
)

endlocal
