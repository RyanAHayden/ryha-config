' Starts komorebi with no visible console window.
' Used by a Startup shortcut to autostart quickly with whkd and masir.
Set objShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

komorebicPath = objShell.ExpandEnvironmentStrings("%ProgramFiles%") & "\komorebi\bin\komorebic.exe"
If Not fso.FileExists(komorebicPath) Then
    komorebicPath = objShell.ExpandEnvironmentStrings("%ProgramFiles(x86)%") & "\komorebi\bin\komorebic.exe"
End If

If Not fso.FileExists(komorebicPath) Then
    Set execObj = objShell.Exec("cmd /c where komorebic.exe")
    Do While execObj.Status = 0
        WScript.Sleep 50
    Loop

    whereOut = Trim(execObj.StdOut.ReadAll)
    If whereOut <> "" Then
        lines = Split(whereOut, vbCrLf)
        komorebicPath = Trim(lines(0))
    End If
End If

If fso.FileExists(komorebicPath) Then
    objShell.Run """" & komorebicPath & """ start --masir --whkd", 0, False
End If
