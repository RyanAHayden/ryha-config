@echo off
REM Copy .config folder and FlowLauncher to user directory

set SOURCE_DIR=%~dp0
set DEST_DIR=C:\Users\%USERNAME%

REM Copy .config folder
if exist "%SOURCE_DIR%.config" (
    xcopy "%SOURCE_DIR%.config" "%DEST_DIR%\.config" /E /I /Y
    echo .config folder copied successfully
) else (
    echo .config folder not found
)


REM Copy FlowLauncher settings file and Themes folder
if exist "%SOURCE_DIR%FlowLauncher" (
    if not exist "%DEST_DIR%\AppData\Roaming\FlowLauncher\Settings" mkdir "%DEST_DIR%\AppData\Roaming\FlowLauncher\Settings"
    if not exist "%DEST_DIR%\AppData\Roaming\FlowLauncher\Settings\Plugins" mkdir "%DEST_DIR%\AppData\Roaming\FlowLauncher\Settings\Plugins"
    if not exist "%DEST_DIR%\AppData\Roaming\FlowLauncher\Themes" mkdir "%DEST_DIR%\AppData\Roaming\FlowLauncher\Themes"
    if not exist "%DEST_DIR%\AppData\Roaming\FlowLauncher\Plugins" mkdir "%DEST_DIR%\AppData\Roaming\FlowLauncher\Plugins"

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

    if exist "%SOURCE_DIR%FlowLauncher\Plugins" (
        xcopy "%SOURCE_DIR%FlowLauncher\Plugins" "%DEST_DIR%\AppData\Roaming\FlowLauncher\Plugins" /E /I /Y
        echo FlowLauncher Plugins copied successfully
    ) else (
        echo FlowLauncher Plugins folder not found
    )

    if exist "%SOURCE_DIR%FlowLauncher\Settings\Plugins" (
        xcopy "%SOURCE_DIR%FlowLauncher\Settings\Plugins" "%DEST_DIR%\AppData\Roaming\FlowLauncher\Settings\Plugins" /E /I /Y
        echo FlowLauncher plugin settings copied successfully
    ) else (
        echo FlowLauncher plugin settings folder not found
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

REM Copy GlazeWM configuration
if exist "%SOURCE_DIR%.glzr" (
    xcopy "%SOURCE_DIR%.glzr" "%DEST_DIR%\.glzr" /E /I /Y
    echo GlazeWM configuration copied successfully
) else (
    echo GlazeWM folder not found
)

REM Copy AltSnap.ini file
if exist "%SOURCE_DIR%AltSnap.ini" (
    copy "%SOURCE_DIR%AltSnap.ini" "%DEST_DIR%\AltSnap.ini" /Y
    if not exist "%APPDATA%\AltSnap" mkdir "%APPDATA%\AltSnap"
    copy "%SOURCE_DIR%AltSnap.ini" "%APPDATA%\AltSnap\AltSnap.ini" /Y
    echo AltSnap.ini copied successfully to user folder and AppData
) else (
    echo AltSnap.ini not found
)

echo Done.