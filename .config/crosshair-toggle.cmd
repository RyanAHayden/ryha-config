@echo off
setlocal

taskkill /F /IM crosshair.exe /T >nul 2>&1

set IMG=%~1
if "%IMG%"=="" set IMG=dot.png

start "" /B /D "%USERPROFILE%\win-crosshair-custom-png" "%USERPROFILE%\win-crosshair-custom-png\crosshair.exe" -i "%USERPROFILE%\win-crosshair-custom-png\%IMG%"
