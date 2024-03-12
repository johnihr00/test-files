@echo off
setlocal enabledelayedexpansion

:: Define ESC variable for ANSI escape codes
set "ESC="
for /f %%A in ('echo prompt $E ^| cmd') do set "ESC=%%A"

:: Set the PuTTY download URL and destination file
set "puttyUrl=https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe"
set "puttyDestination=%TEMP%\putty.exe"
set "puttyMessageColor=5"  :: 5 for pink, 0 for black

:: Set the new image download URL and destination file
set "imageUrl=https://raw.githubusercontent.com/johnihr00/test-files/main/WhatsApp%20Image%202024-03-06%20at%209.27.16%20PM.jpeg"
set "imageDestination=%TEMP%\downloaded_image.jpeg"
set "imageMessageColor=2"  :: 2 for green, 0 for black

:: Display PuTTY "Please wait" message
call :setColor !puttyMessageColor!
echo Please wait, PuTTY is downloading...

:: Download PuTTY silently
curl -o "!puttyDestination!" -L --silent "!puttyUrl!" || wget -q -O "!puttyDestination!" "!puttyUrl!"

:: Check if the PuTTY download was successful
if !errorlevel! equ 0 (
    call :setColor !puttyMessageColor!
    echo PuTTY downloaded successfully to: !puttyDestination!
    :: Run PuTTY
    start "" "!puttyDestination!"
) else (
    call :setColor !puttyMessageColor!
    echo Error downloading PuTTY.
)

:: Display new image "Please wait" message
call :setColor !imageMessageColor!
echo Please wait, new image is downloading...

:: Download the new image silently
curl -o "!imageDestination!" -L --silent "!imageUrl!" || wget -q -O "!imageDestination!" "!imageUrl!"

:: Check if the new image download was successful
if !errorlevel! equ 0 (
    call :setColor !imageMessageColor!
    echo New image downloaded successfully to: !imageDestination!
    :: Open the downloaded image with the default image viewer
    start "" "!imageDestination!"
) else (
    call :setColor !imageMessageColor!
    echo Error downloading the new image.
)

:: Reset color and end script
call :resetColor
endlocal
exit /b

:setColor
:: Set the text color (pink or dark black or green)
<nul set /p ".=!ESC![38;5;%1m"
exit /b

:resetColor
:: Reset the text color
<nul set /p ".=!ESC![0m"
exit /b
