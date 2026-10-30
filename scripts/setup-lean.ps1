# Install Lean inside this checkout without changing the user's PATH.
$ErrorActionPreference = 'Stop'
$taskRoot = Split-Path -Parent $PSScriptRoot
$taskTools = Join-Path $taskRoot '.tools'
$taskBootstrap = Join-Path $taskTools 'bootstrap'
$env:ELAN_HOME = Join-Path $taskTools 'elan'
$env:MATHLIB_CACHE_DIR = Join-Path $taskTools 'mathlib-cache'
New-Item -ItemType Directory -Force -Path $taskBootstrap | Out-Null
$taskElan = Join-Path $env:ELAN_HOME 'bin\elan.exe'
if (-not (Test-Path -LiteralPath $taskElan)) {
    $taskArchive = Join-Path $taskBootstrap 'elan.zip'
    & curl.exe --fail --location --silent --show-error --output $taskArchive 'https://github.com/leanprover/elan/releases/download/v4.2.4/elan-x86_64-pc-windows-msvc.zip'
    if ($LASTEXITCODE -ne 0) { throw 'Could not download elan.' }
    Expand-Archive -LiteralPath $taskArchive -DestinationPath $taskBootstrap -Force
    & (Join-Path $taskBootstrap 'elan-init.exe') -y --no-modify-path --default-toolchain none
    if ($LASTEXITCODE -ne 0) { throw 'Could not install elan.' }
}
& $taskElan toolchain install 'leanprover/lean4:v4.24.0'
if ($LASTEXITCODE -ne 0) { throw 'Could not install the pinned Lean toolchain.' }
Write-Output 'Project-local Lean toolchain is ready. Use scripts/check-lean.ps1 to check the proof.'
