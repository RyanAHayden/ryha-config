@echo off
REM Copy .config folder, komorebi.json, and FlowLauncher to user directory

set SOURCE_DIR=%~dp0
set DEST_DIR=C:\Users\%USERNAME%

REM Copy Process Killer Whitelist
if exist "%SOURCE_DIR%\ProcessKiller" (
    xcopy "%SOURCE_DIR%\ProcessKiller" "%DEST_DIR%\ProcessKiller" /E /I /Y
    echo Process Killer copied successfully
) else (
    echo Process Killer not found
)


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

REM Copy FlowLauncher settings file and Themes folder
if exist "%SOURCE_DIR%FlowLauncher" (
    if not exist "%DEST_DIR%\AppData\Roaming\FlowLauncher\Settings" mkdir "%DEST_DIR%\AppData\Roaming\FlowLauncher\Settings"
    if not exist "%DEST_DIR%\AppData\Roaming\FlowLauncher\Themes" mkdir "%DEST_DIR%\AppData\Roaming\FlowLauncher\Themes"

    if exist "%SOURCE_DIR%FlowLauncher\Settings\Settings.json" (
        copy "%SOURCE_DIR%FlowLauncher\Settings\Settings.json" "%DEST_DIR%\AppData\Roaming\FlowLauncher\Settings\Settings.json" /Y
        echo FlowLauncher Settings.json copied successfully
    ) else (
        echo FlowLauncher Settings.json not found
    )

    if exist "%SOURCE_DIR%FlowLauncher\Themes" (
        xcopy "%SOURCE_DIR%FlowLauncher\Themes" "%DEST_DIR%\AppData\Roaming\FlowLauncher\Themes" /E /I /Y
        echo FlowLauncher Themes copied successfully
    ) else (
        echo FlowLauncher Themes folder not found
    )
) else (
    echo FlowLauncher folder not found
)

REM Copy PowerToys plugin state and Keyboard Manager preferences
if exist "%SOURCE_DIR%PowerToys" (
    if not exist "%DEST_DIR%\AppData\Local\Microsoft\PowerToys" mkdir "%DEST_DIR%\AppData\Local\Microsoft\PowerToys"
    if not exist "%DEST_DIR%\AppData\Local\Microsoft\PowerToys\Keyboard Manager" mkdir "%DEST_DIR%\AppData\Local\Microsoft\PowerToys\Keyboard Manager"

    if exist "%SOURCE_DIR%PowerToys\settings.json" (
        copy "%SOURCE_DIR%PowerToys\settings.json" "%DEST_DIR%\AppData\Local\Microsoft\PowerToys\settings.json" /Y
        echo PowerToys settings.json copied successfully
    ) else (
        echo PowerToys settings.json not found
    )

    if exist "%SOURCE_DIR%PowerToys\Keyboard Manager\default.json" (
        copy "%SOURCE_DIR%PowerToys\Keyboard Manager\default.json" "%DEST_DIR%\AppData\Local\Microsoft\PowerToys\Keyboard Manager\default.json" /Y
    )
    if exist "%SOURCE_DIR%PowerToys\Keyboard Manager\editorSettings.json" (
        copy "%SOURCE_DIR%PowerToys\Keyboard Manager\editorSettings.json" "%DEST_DIR%\AppData\Local\Microsoft\PowerToys\Keyboard Manager\editorSettings.json" /Y
    )
    if exist "%SOURCE_DIR%PowerToys\Keyboard Manager\settings.json" (
        copy "%SOURCE_DIR%PowerToys\Keyboard Manager\settings.json" "%DEST_DIR%\AppData\Local\Microsoft\PowerToys\Keyboard Manager\settings.json" /Y
    )
    echo PowerToys Keyboard Manager preferences copied
) else (
    echo PowerToys folder not found
)

REM Copy applications.json file
if exist "%SOURCE_DIR%applications.json" (
    copy "%SOURCE_DIR%applications.json" "%DEST_DIR%\applications.json" /Y
    echo applications.json copied successfully
) else (
    echo applications.json not found
)

REM Copy AltSnap.ini file
if exist "%SOURCE_DIR%AltSnap.ini" (
    copy "%SOURCE_DIR%AltSnap.ini" "%APPDATA%\AltSnap\AltSnap.ini" /Y
    echo AltSnap.ini copied successfully
) else (
    echo AltSnap.ini not found
)

REM Copy launch-whkd-hidden.vbs file
if exist "%SOURCE_DIR%launch-whkd-hidden.vbs" (
    copy "%SOURCE_DIR%launch-whkd-hidden.vbs" "%DEST_DIR%\launch-whkd-hidden.vbs" /Y
    echo WHKD Launcher copied successfully
) else (
    echo WHKD Launcher not found
)

@REM REM Copy start_apps.bat to shell:startup
@REM if exist "%SOURCE_DIR%start_apps.bat" (
@REM     xcopy "%SOURCE_DIR%start_apps.bat" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" /Y
@REM     echo start_apps.bat copied to shell:startup successfully
@REM ) else (
@REM     echo start_apps.bat not found
@REM )

echo Done.