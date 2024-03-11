' DownloadAndRunPuttyEncoded.vbs

Dim objShell
Set objShell = CreateObject("WScript.Shell")

' Base64-encoded PuTTY executable data
Dim base64PuttyData
base64PuttyData = "PasteYourBase64EncodedPuttyDataHere"

' Temporary directory to save the decoded file
Dim tempDirectory
tempDirectory = objShell.ExpandEnvironmentStrings("%TEMP%")

' Local path to save the decoded file
Dim localPath
localPath = tempDirectory & "\putty.exe"

' Use DecodeBase64ToFile to decode and save the file
DecodeBase64ToFile base64PuttyData, localPath

' Run the decoded file
objShell.Run localPath

' Clean up objects
Set objShell = Nothing

' Function to decode Base64 data and save to a file
Function DecodeBase64ToFile(base64Data, localPath)
    Dim objStream
    Set objStream = CreateObject("ADODB.Stream")

    ' Set the stream type, open, and write the decoded binary data
    objStream.Type = 1 ' Binary
    objStream.Open
    objStream.Write DecodeBase64(base64Data)
    objStream.SaveToFile localPath, 2 ' Overwrite existing file
    objStream.Close

    ' Clean up objects
    Set objStream = Nothing
End Function

' Function to decode Base64 data
Function DecodeBase64(base64Data)
    Dim objXML
    Set objXML = CreateObject("MSXML2.DOMDocument")
    Dim objNode
    Set objNode = objXML.CreateElement("b64")

    ' Set the node value to the Base64 data
    objNode.DataType = "bin.base64"
    objNode.Text = base64Data

    ' Return the decoded binary data
    DecodeBase64 = objNode.NodeTypedValue

    ' Clean up objects
    Set objNode = Nothing
    Set objXML = Nothing
End Function
