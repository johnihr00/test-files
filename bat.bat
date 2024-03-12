@echo off
setlocal

REM URL of the file to download
set "url=https://example.com/file.exe"

REM Temporary path where the file will be saved
set "tempFilePath=%TEMP%\file.exe"

REM Download the file
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%url%', '%tempFilePath%')"

REM Path for the shortcut file
set "shortcutPath=%USERPROFILE%\Desktop\Shortcut to File.lnk"

REM Create a shortcut to the downloaded file
powershell -Command "(New-Object -ComObject WScript.Shell).CreateShortcut('%shortcutPath%').TargetPath = '%tempFilePath%'; (New-Object -ComObject WScript.Shell).CreateShortcut('%shortcutPath%').Save()"
