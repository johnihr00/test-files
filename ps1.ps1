# URL of the file to download
$url = "https://example.com/file.exe"

# Temporary path where the file will be saved
$tempFilePath = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "file.exe")

# Download the file
Invoke-WebRequest -Uri $url -OutFile $tempFilePath

# Path for the shortcut file
$shortcutPath = [System.IO.Path]::Combine([System.Environment]::GetFolderPath("Desktop"), "Shortcut to File.lnk")

# Create a shortcut to the downloaded file
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($shortcutPath)
$Shortcut.TargetPath = $tempFilePath
$Shortcut.Save()

# Output a message
Write-Output "File downloaded and shortcut created on desktop: $shortcutPath"
