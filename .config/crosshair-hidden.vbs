Set objWsh = CreateObject("WScript.Shell")
Set objWMI = GetObject("winmgmts:\\.\root\cimv2")

On Error Resume Next
Set colProcs = objWMI.ExecQuery("SELECT * FROM Win32_Process WHERE Name = 'crosshair.exe'")
If Not colProcs Is Nothing Then
    For Each objProc In colProcs
        objProc.Terminate()
    Next
End If
On Error GoTo 0

WScript.Sleep 300

img = "dot.png"
If WScript.Arguments.Count > 0 Then
    img = WScript.Arguments(0)
End If

imgPath = "C:\Users\admin\win-crosshair-custom-png\" & img
objWsh.CurrentDirectory = "C:\Users\admin\win-crosshair-custom-png"
objWsh.Run """C:\Users\admin\win-crosshair-custom-png\crosshair.exe"" -i """" & imgPath & """"", 0, False
