@echo off
REM Copy .config folder, komorebi.json, and FlowLauncher from user directory back to repo

set SOURCE_DIR=C:\Users\%USERNAME%
set DEST_DIR=%~dp0

REM Copy .config folder
if exist "%SOURCE_DIR%\.config" (
    xcopy "%SOURCE_DIR%\.config" "%DEST_DIR%.config" /E /I /Y
    echo .config folder copied successfully
) else (
    echo .config folder not found
)

REM Copy komorebi.json file
if exist "%SOURCE_DIR%\komorebi.json" (
    copy "%SOURCE_DIR%\komorebi.json" "%DEST_DIR%komorebi.json" /Y
    echo komorebi.json copied successfully
) else (
    echo komorebi.json not found
)

REM Copy FlowLauncher settings file and Themes folder
if exist "%SOURCE_DIR%\AppData\Roaming\FlowLauncher" (
    if not exist "%DEST_DIR%FlowLauncher\Settings" mkdir "%DEST_DIR%FlowLauncher\Settings"
    if not exist "%DEST_DIR%FlowLauncher\Settings\Plugins" mkdir "%DEST_DIR%FlowLauncher\Settings\Plugins"
    if not exist "%DEST_DIR%FlowLauncher\Themes" mkdir "%DEST_DIR%FlowLauncher\Themes"
    if not exist "%DEST_DIR%FlowLauncher\Plugins" mkdir "%DEST_DIR%FlowLauncher\Plugins"

    if exist "%SOURCE_DIR%\AppData\Roaming\FlowLauncher\Settings\Settings.json" (
        copy "%SOURCE_DIR%\AppData\Roaming\FlowLauncher\Settings\Settings.json" "%DEST_DIR%FlowLauncher\Settings\Settings.json" /Y
        echo FlowLauncher Settings.json copied successfully
    ) else (
        echo FlowLauncher Settings.json not found
    )

    if exist "%SOURCE_DIR%\AppData\Roaming\FlowLauncher\Themes" (
        xcopy "%SOURCE_DIR%\AppData\Roaming\FlowLauncher\Themes" "%DEST_DIR%FlowLauncher\Themes" /E /I /Y
        echo FlowLauncher Themes copied successfully
    ) else (
        echo FlowLauncher Themes folder not found
    )

    if exist "%SOURCE_DIR%\AppData\Roaming\FlowLauncher\Plugins" (
        xcopy "%SOURCE_DIR%\AppData\Roaming\FlowLauncher\Plugins" "%DEST_DIR%FlowLauncher\Plugins" /E /I /Y
        echo FlowLauncher Plugins copied successfully
    ) else (
        echo FlowLauncher Plugins folder not found
    )

    if exist "%SOURCE_DIR%\AppData\Roaming\FlowLauncher\Settings\Plugins" (
        xcopy "%SOURCE_DIR%\AppData\Roaming\FlowLauncher\Settings\Plugins" "%DEST_DIR%FlowLauncher\Settings\Plugins" /E /I /Y
        echo FlowLauncher plugin settings copied successfully
    ) else (
        echo FlowLauncher plugin settings folder not found
    )
) else (
    echo FlowLauncher folder not found
)

REM Copy PowerToys plugin state and Keyboard Manager preferences
if exist "%SOURCE_DIR%\AppData\Local\Microsoft\PowerToys" (
    if not exist "%DEST_DIR%PowerToys" mkdir "%DEST_DIR%PowerToys"
    if not exist "%DEST_DIR%PowerToys\Keyboard Manager" mkdir "%DEST_DIR%PowerToys\Keyboard Manager"

    if exist "%SOURCE_DIR%\AppData\Local\Microsoft\PowerToys\settings.json" (
        copy "%SOURCE_DIR%\AppData\Local\Microsoft\PowerToys\settings.json" "%DEST_DIR%PowerToys\settings.json" /Y
        echo PowerToys settings.json copied successfully
    ) else (
        echo PowerToys settings.json not found
    )

    if exist "%SOURCE_DIR%\AppData\Local\Microsoft\PowerToys\Keyboard Manager\default.json" (
        copy "%SOURCE_DIR%\AppData\Local\Microsoft\PowerToys\Keyboard Manager\default.json" "%DEST_DIR%PowerToys\Keyboard Manager\default.json" /Y
    )
    if exist "%SOURCE_DIR%\AppData\Local\Microsoft\PowerToys\Keyboard Manager\editorSettings.json" (
        copy "%SOURCE_DIR%\AppData\Local\Microsoft\PowerToys\Keyboard Manager\editorSettings.json" "%DEST_DIR%PowerToys\Keyboard Manager\editorSettings.json" /Y
    )
    if exist "%SOURCE_DIR%\AppData\Local\Microsoft\PowerToys\Keyboard Manager\settings.json" (
        copy "%SOURCE_DIR%\AppData\Local\Microsoft\PowerToys\Keyboard Manager\settings.json" "%DEST_DIR%PowerToys\Keyboard Manager\settings.json" /Y
    )
    echo PowerToys Keyboard Manager preferences copied
) else (
    echo PowerToys folder not found
)

REM Copy applications.json file
if exist "%SOURCE_DIR%\applications.json" (
    copy "%SOURCE_DIR%\applications.json" "%DEST_DIR%applications.json" /Y
    echo applications.json copied successfully
) else (
    echo applications.json not found
)

REM Copy AltSnap.ini file
if exist "%SOURCE_DIR%\AltSnap.ini" (
    copy "%SOURCE_DIR%\AltSnap.ini" "%DEST_DIR%\AltSnap.ini" /Y
    echo AltSnap.ini copied successfully from user folder
) else if exist "%APPDATA%\AltSnap\AltSnap.ini" (
    copy "%APPDATA%\AltSnap\AltSnap.ini" "%DEST_DIR%\AltSnap.ini" /Y
    echo AltSnap.ini copied successfully from AppData
) else (
    echo AltSnap.ini not found
)


echo Done.
