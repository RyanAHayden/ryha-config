' Runs startup-priority.ps1 hidden.
Set objShell = CreateObject("WScript.Shell")
scriptPath = objShell.ExpandEnvironmentStrings("%USERPROFILE%") & "\startup-priority.ps1"
objShell.Run "powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & scriptPath & """", 0, False
