# Run from any directory; all downloaded tools and dependencies stay in this checkout.
param([switch]$Fetch)
$ErrorActionPreference = 'Stop'
$taskRoot = Split-Path -Parent $PSScriptRoot
$env:ELAN_HOME = Join-Path $taskRoot '.tools\elan'
$env:MATHLIB_CACHE_DIR = Join-Path $taskRoot '.tools\mathlib-cache'
$env:PATH = (Join-Path $env:ELAN_HOME 'bin') + [IO.Path]::PathSeparator + $env:PATH
$taskLake = Join-Path $env:ELAN_HOME 'bin\lake.exe'
if (-not (Test-Path -LiteralPath $taskLake)) {
    throw 'Run scripts/setup-lean.ps1 first, or use your own installed lake from the lean directory.'
}
Push-Location (Join-Path $taskRoot 'lean')
try {
    if ($Fetch) {
        $env:MATHLIB_NO_CACHE_ON_UPDATE = '1'
        & $taskLake update
        if ($LASTEXITCODE -ne 0) { throw 'Lake dependency update failed.' }
        $taskImports = Get-Content -LiteralPath 'TwoSquares.lean' |
            Where-Object { $_ -match '^import ' } |
            ForEach-Object { ($_ -replace '^import ', '').Trim() }
        & $taskLake exe cache get @taskImports
        if ($LASTEXITCODE -ne 0) { throw 'Mathlib cache download failed.' }
    }
    & $taskLake build
    if ($LASTEXITCODE -ne 0) { throw 'Lean proof check failed.' }
} finally {
    Pop-Location
}
