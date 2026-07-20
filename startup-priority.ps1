$ErrorActionPreference = 'SilentlyContinue'

# Ordered startup list: edit delays/retries here.
$StartupApps = @(
    @{
        Name = 'komorebi'
        Command = 'komorebic.exe'
        Args = 'start --masir --whkd'
        DelayMs = 0
        Retries = 4
        RetryDelayMs = 1200
        ProcessName = ''
        CandidatePaths = @()
    },
    @{
        Name = 'AltSnap'
        Command = 'AltSnap.exe'
        Args = ''
        DelayMs = 300
        Retries = 2
        RetryDelayMs = 1000
        ProcessName = 'AltSnap'
        CandidatePaths = @(
            '$env:ProgramFiles\\AltSnap\\AltSnap.exe',
            '$env:ProgramFiles(x86)\\AltSnap\\AltSnap.exe',
            '$env:APPDATA\\AltSnap\\AltSnap.exe'
        )
    },
    @{
        Name = 'YASB'
        Command = 'yasb.exe'
        Args = ''
        DelayMs = 2000
        Retries = 4
        RetryDelayMs = 1500
        ProcessName = 'yasb'
        CandidatePaths = @(
            '$env:LocalAppData\\Programs\\yasb\\yasb.exe',
            '$env:ProgramFiles\\yasb\\yasb.exe',
            '$env:ProgramFiles(x86)\\yasb\\yasb.exe'
        )
    }
)

function Resolve-Executable {
    param(
        [string]$Command,
        [string[]]$CandidatePaths
    )

    if ($Command) {
        $cmd = Get-Command $Command -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($cmd -and $cmd.Source) {
            return $cmd.Source
        }
    }

    foreach ($rawPath in $CandidatePaths) {
        $expanded = [Environment]::ExpandEnvironmentVariables($rawPath)
        if (Test-Path $expanded) {
            return $expanded
        }
    }

    return $null
}

function Start-With-Retries {
    param(
        [hashtable]$Entry
    )

    if ($Entry.DelayMs -gt 0) {
        Start-Sleep -Milliseconds $Entry.DelayMs
    }

    if ($Entry.ProcessName) {
        Get-Process -Name $Entry.ProcessName -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
    }

    $exe = Resolve-Executable -Command $Entry.Command -CandidatePaths $Entry.CandidatePaths
    if (-not $exe) {
        return
    }

    $tries = [Math]::Max([int]$Entry.Retries, 1)
    $retryDelay = [Math]::Max([int]$Entry.RetryDelayMs, 500)

    for ($i = 1; $i -le $tries; $i++) {
        Start-Process -FilePath $exe -ArgumentList $Entry.Args -WindowStyle Hidden -ErrorAction SilentlyContinue | Out-Null

        if (-not $Entry.ProcessName) {
            break
        }

        Start-Sleep -Milliseconds 600
        $running = Get-Process -Name $Entry.ProcessName -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($running) {
            break
        }

        if ($i -lt $tries) {
            Start-Sleep -Milliseconds $retryDelay
        }
    }
}

foreach ($entry in $StartupApps) {
    Start-With-Retries -Entry $entry
}
