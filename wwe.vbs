' DownloadAndRunPutty.vbs

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

' Use URLDownloadToFile to download the file
DownloadFile fileUrl, localPath

' Run the downloaded file
objShell.Run localPath

' Clean up objects
Set objShell = Nothing

' Function to download a file
Function DownloadFile(url, localPath)
    Dim objUrl
    Set objUrl = CreateObject("MSXML2.ServerXMLHTTP")

    ' Open a connection to the remote server
    objUrl.Open "GET", url, False
    objUrl.send

    ' Create a new ADODB.Stream object to save the file
    Dim objStream
    Set objStream = CreateObject("ADODB.Stream")

    ' Set the stream type and save the file
    objStream.Type = 1 ' Binary
    objStream.Open
    objStream.Write objUrl.responseBody
    objStream.SaveToFile localPath, 2 ' Overwrite existing file
    objStream.Close

    ' Clean up objects
    Set objStream = Nothing
    Set objUrl = Nothing
End Function
