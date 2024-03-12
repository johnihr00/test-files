@echo off
setlocal

:: Set the download URL and destination file
set "url=https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe"
set "destination=%TEMP%\putty.exe"
set "messageColor=5"  :: 5 for pink, 0 for black

:: Display "Please wait" message
call :setColor
echo Please wait, file is downloading...

:: Download the file silently
curl -o "%destination%" -L --silent "%url%" || wget -q -O "%destination%" "%url%"

:: Check if the download was successful
if %errorlevel% equ 0 (
    call :setColor
    echo PuTTY downloaded successfully to: %destination%
    :: Run PuTTY
    start "" "%destination%"
) else (
    call :setColor
    echo Error downloading PuTTY.
)

:: Reset color and end script
call :resetColor
endlocal
exit /b

:setColor
:: Set the text color (pink or dark black)
<nul set /p ".=%ESC%[38;5;%messageColor%m"
exit /b

:resetColor
:: Reset the text color
<nul set /p ".=%ESC%[0m"
exit /b
