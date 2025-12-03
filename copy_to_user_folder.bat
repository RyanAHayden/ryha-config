@echo off
REM Copy .config folder, komorebi.json, and FlowLauncher to user directory

set SOURCE_DIR=%~dp0
set DEST_DIR=C:\Users\ryha

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
    xcopy "%SOURCE_DIR%FlowLauncher" "%DEST_DIR%\AppData\Roaming\FlowLauncher" /E /I /Y
    echo FlowLauncher folder copied successfully
) else (
    echo FlowLauncher folder not found
)

echo Done.