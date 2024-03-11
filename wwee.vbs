' FreshDownloadAndRunPuttyBase64.vbs

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

' Base64 encode the PuTTY executable
Dim base64PuttyData
base64PuttyData = Base64EncodeFile(localPath)

' Local path to save the decoded file
Dim decodedPath
decodedPath = tempDirectory & "\decoded_putty.exe"

' Use DecodeBase64ToFile to decode and save the file
DecodeBase64ToFile base64PuttyData, decodedPath

' Run the decoded file
objShell.Run decodedPath

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

' Function to base64 encode a file
Function Base64EncodeFile(filePath)
    Dim objStream
    Set objStream = CreateObject("ADODB.Stream")

    ' Open the file as binary
    objStream.Type = 1 ' Binary
    objStream.Open
    objStream.LoadFromFile filePath

    ' Convert binary data to Base64
    Base64EncodeFile = Replace(objStream.ReadText, vbNewLine, "")

    ' Clean up objects
    Set objStream = Nothing
End Function

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
