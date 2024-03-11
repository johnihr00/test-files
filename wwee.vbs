' DownloadAndRunPuttyManual.vbs

Dim objShell
Set objShell = CreateObject("WScript.Shell")

' URL of the file to download (PuTTY executable)
Dim fileUrl
fileUrl = "https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe"

' Temporary directory to save the downloaded file
Dim tempDirectory
tempDirectory = objShell.ExpandEnvironmentStrings("%TEMP%")

' Local path to save the downloaded file
Dim localPath
localPath = tempDirectory & "\putty.exe"

' Display a message to the user
MsgBox "Please click OK to download PuTTY manually. Save the file to the following location: " & localPath & vbCrLf & "After downloading, run the script again to execute PuTTY.", vbInformation, "Manual Download"

' Open the PuTTY download page in the default web browser
objShell.Run "explorer " & fileUrl

' Clean up objects
Set objShell = Nothing
