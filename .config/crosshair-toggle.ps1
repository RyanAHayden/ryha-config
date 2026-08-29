$ErrorActionPreference = 'SilentlyContinue'

Get-Process crosshair -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Milliseconds 250

$exe = "$env:USERPROFILE\win-crosshair-custom-png\crosshair.exe"
$img = if ($args.Count -gt 0) { $args[0] } else { 'dot.png' }

$argList = @('-i', $img)
Start-Process -FilePath $exe -ArgumentList $argList -WorkingDirectory "$env:USERPROFILE\win-crosshair-custom-png" -WindowStyle Hidden | Out-Null
