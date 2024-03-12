; AutoIt Demo Script: Download and Run File (Hide Notepad)
; This script opens Notepad, types a message, downloads an executable file from a link,
; saves it to the system's temporary directory, and then runs it, while hiding Notepad.

; Open Notepad
Run("notepad.exe")
WinWaitActive("Untitled - Notepad")

; Type a message
Send("Hello, this is an AutoIt demo script!")

; Wait for a moment
Sleep(2000)

; Minimize Notepad
WinSetState("Untitled - Notepad", "", @SW_MINIMIZE)

; Download an executable file to the temporary directory
Local $url = "https://www.example.com/path/to/your/executable_file.exe"
Local $tempDir = @TempDir
Local $destination = $tempDir & "\downloaded_file.exe"
InetGet($url, $destination, 1, 0)

; Wait for the download to complete
While @InetGetActive
    Sleep(250)
WEnd

; Display a message indicating the download is complete
MsgBox(64, "Download Complete", "File downloaded successfully to:" & @CRLF & $destination)

; Run the downloaded executable file
Run($destination)

; Close Notepad (optional)
WinClose("Untitled - Notepad")
WinWaitClose("Untitled - Notepad")
