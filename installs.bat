@REM CONFIG
winget install DEVCOM.JetBrainsMonoNerdFont
winget install RamenSoftware.Windhawk
winget install AltSnap.AltSnap
winget install xanderfrangos.twinkletray
winget install Microsoft.PowerToys
winget install Flow-Launcher.Flow-Launcher
winget install python

@REM Browser
winget install Zen-Team.Zen-Browser 

@REM Misc
winget install AntibodySoftware.WizTree
winget install KeePassXCTeam.KeePassXC
winget install Spotify.Spotify

@REM DEV
winget install Microsoft.VisualStudioCode

start cmd.exe /c "python -m pip install websockets"

ECHO done.
pause