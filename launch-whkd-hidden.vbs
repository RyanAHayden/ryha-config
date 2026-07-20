' Relaunches whkd.exe with no visible console window.
' It first terminates existing whkd processes so only one instance remains.
' Used by the "Launch whkd" Start Menu shortcut so it can be triggered
' from the Windows Command Palette without flashing a cmd/console window.
Set objShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

Set wmi = GetObject("winmgmts:\\.\root\cimv2")
For Each proc In wmi.ExecQuery("SELECT * FROM Win32_Process WHERE Name='whkd.exe'")
	proc.Terminate
Next

whkdPath = objShell.ExpandEnvironmentStrings("%ProgramFiles%") & "\whkd\bin\whkd.exe"
If Not fso.FileExists(whkdPath) Then
	whkdPath = objShell.ExpandEnvironmentStrings("%ProgramFiles(x86)%") & "\whkd\bin\whkd.exe"
End If

objShell.Run """" & whkdPath & """", 0, False
