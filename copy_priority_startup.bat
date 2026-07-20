@echo off
REM Set up priority startup launcher and scheduled task/fallback shortcut.

REM Self-elevate when launched from VS Code task or normal shell.
net session >nul 2>&1
if not "%errorlevel%"=="0" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Start-Process -FilePath '%~f0' -WorkingDirectory '%cd%' -Verb RunAs -ErrorAction Stop; exit 0 } catch { exit 1 }"
    if not "%errorlevel%"=="0" (
        echo Admin prompt canceled or access denied. Continuing with non-admin fallback mode.
    ) else (
        exit /b
    )
)

set SOURCE_DIR=%~dp0
set DEST_DIR=C:\Users\%USERNAME%

if exist "%SOURCE_DIR%startup-priority.ps1" (
    copy "%SOURCE_DIR%startup-priority.ps1" "%DEST_DIR%\startup-priority.ps1" /Y
    echo Priority startup script copied successfully
) else (
    echo Priority startup script not found
)

if exist "%SOURCE_DIR%launch-priority-startup-hidden.vbs" (
    copy "%SOURCE_DIR%launch-priority-startup-hidden.vbs" "%DEST_DIR%\launch-priority-startup-hidden.vbs" /Y
    echo Priority startup launcher copied successfully

    if not exist "%DEST_DIR%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" mkdir "%DEST_DIR%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"

    set TASK_OK=0
    powershell -NoProfile -ExecutionPolicy Bypass -Command "try { $taskName='Ryha Priority Startup'; $action=New-ScheduledTaskAction -Execute 'wscript.exe' -Argument ('//B ' + [char]34 + $env:USERPROFILE + '\\launch-priority-startup-hidden.vbs' + [char]34); $trigger=New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME; $settings=New-ScheduledTaskSettingsSet -StartWhenAvailable -DontStopIfGoingOnBatteries; $settings.DisallowStartIfOnBatteries=$false; $principal=New-ScheduledTaskPrincipal -UserId $env:USERNAME -LogonType Interactive -RunLevel Limited; Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $settings -Principal $principal -Force -ErrorAction Stop | Out-Null; exit 0 } catch { exit 1 }" >nul 2>nul
    if not errorlevel 1 (
        powershell -NoProfile -ExecutionPolicy Bypass -Command "try { $t=Get-ScheduledTask -TaskName 'Ryha Priority Startup' -ErrorAction Stop; if($t.Settings.DisallowStartIfOnBatteries -or $t.Settings.StopIfGoingOnBatteries){ exit 2 } else { exit 0 } } catch { exit 1 }" >nul 2>nul
        if not errorlevel 1 set TASK_OK=1
    )

    if "%TASK_OK%"=="0" (
        schtasks /Delete /TN "Ryha Priority Startup" /F >nul 2>nul
        powershell -NoProfile -ExecutionPolicy Bypass -Command "$ws=New-Object -ComObject WScript.Shell; $lnk=$ws.CreateShortcut('%DEST_DIR%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Priority startup.lnk'); $lnk.TargetPath=$env:SystemRoot + '\\System32\\wscript.exe'; $lnk.Arguments='//B ' + [char]34 + '%DEST_DIR%\launch-priority-startup-hidden.vbs' + [char]34; $lnk.WorkingDirectory='%DEST_DIR%'; $lnk.Description='Ordered startup: komorebi, AltSnap, YASB'; $lnk.Save()"
        echo Priority scheduled task unavailable or restrictive. Startup shortcut fallback created.
    ) else (
        if exist "%DEST_DIR%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Priority startup.lnk" del /F /Q "%DEST_DIR%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Priority startup.lnk"
        echo Priority startup scheduled task created and validated
    )
) else (
    echo Priority startup launcher not found
)

echo Done.
