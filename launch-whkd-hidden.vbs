' Launches whkd.exe with no visible console window.
' Used by the "Launch whkd" Start Menu shortcut so it can be triggered
' from the Windows Command Palette without flashing a cmd/console window.
Set objShell = CreateObject("WScript.Shell")
objShell.Run """C:\Program Files\whkd\bin\whkd.exe""", 0, False
