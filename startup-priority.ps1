$ErrorActionPreference = 'SilentlyContinue'

# Launch komorebi first via direct command invocation.
$komorebic = "$env:ProgramFiles\komorebi\bin\komorebic.exe"
if (Test-Path $komorebic) {
    & $komorebic start --masir --whkd | Out-Null
}

# Launch all other startup apps immediately.
# Add a new app by adding one line with ExePath + optional Args.
$StartupApps = @(
    @{ ExePath = "$env:APPDATA\AltSnap\AltSnap.exe";                 Args = '' },
    @{ ExePath = "$env:ProgramFiles\YASB\yasb.exe";                   Args = '' }
)

foreach ($app in $StartupApps) {
    if (-not (Test-Path $app.ExePath)) {
        continue
    }

    if ([string]::IsNullOrWhiteSpace($app.Args)) {
        Start-Process -FilePath $app.ExePath -ErrorAction SilentlyContinue | Out-Null
    } else {
        Start-Process -FilePath $app.ExePath -ArgumentList $app.Args -ErrorAction SilentlyContinue | Out-Null
    }
}
