@echo off
setlocal

:: Set the download URL and destination file
set "url=https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe"
set "destination=%TEMP%\putty.exe"

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
