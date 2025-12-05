@echo off
REM Copy .config folder, komorebi.json, and FlowLauncher to user directory

set SOURCE_DIR=%~dp0
set DEST_DIR=C:\Users\%USERNAME%

REM Copy .config folder
if exist "%SOURCE_DIR%.config" (
    xcopy "%SOURCE_DIR%.config" "%DEST_DIR%\.config" /E /I /Y
    echo .config folder copied successfully
) else (
    echo .config folder not found
)

REM Copy komorebi.json file
if exist "%SOURCE_DIR%komorebi.json" (
    copy "%SOURCE_DIR%komorebi.json" "%DEST_DIR%\komorebi.json" /Y
    echo komorebi.json copied successfully
) else (
    echo komorebi.json not found
)

REM Copy FlowLauncher folder
if exist "%SOURCE_DIR%FlowLauncher" (
    xcopy "%SOURCE_DIR%FlowLauncher/Settings/Settings.json" "%DEST_DIR%\AppData\Roaming\FlowLauncher/Settings/Settings.json" /E /I /Y
    xcopy "%SOURCE_DIR%FlowLauncher/Themes" "%DEST_DIR%\AppData\Roaming\FlowLauncher/Themes" /E /I /Y
    echo FlowLauncher folder copied successfully
) else (
    echo FlowLauncher folder not found
)

REM Copy applications.json file
if exist "%SOURCE_DIR%applications.json" (
    copy "%SOURCE_DIR%applications.json" "%DEST_DIR%\applications.json" /Y
    echo applications.json copied successfully
) else (
    echo applications.json not found
)

REM Copy start_apps.bat to shell:startup
if exist "%SOURCE_DIR%start_apps.bat" (
    xcopy "%SOURCE_DIR%start_apps.bat" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" /Y
    echo start_apps.bat copied to shell:startup successfully
) else (
    echo start_apps.bat not found
)

echo Done.