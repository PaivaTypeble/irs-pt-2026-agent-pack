$repo = if ($env:IRS_PT_2026_REPO) { $env:IRS_PT_2026_REPO } else { 'PaivaTypeble/irs-pt-2026-agent-pack' }
$mode = if ($env:IRS_PT_2026_MODE) { $env:IRS_PT_2026_MODE } else { 'both' }
$destination = if ($env:IRS_PT_2026_DESTINATION) { $env:IRS_PT_2026_DESTINATION } else { (Get-Location).Path }
$assetName = if ($env:IRS_PT_2026_ASSET) { $env:IRS_PT_2026_ASSET } else { 'irs-pt-2026-template.zip' }

$downloadUrl = "https://github.com/$repo/releases/latest/download/$assetName"
$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("irs-pt-2026-" + [System.Guid]::NewGuid().ToString('N'))
$zipPath = Join-Path $tempRoot $assetName
$extractPath = Join-Path $tempRoot 'extract'

New-Item -ItemType Directory -Force -Path $tempRoot | Out-Null
New-Item -ItemType Directory -Force -Path $extractPath | Out-Null

Invoke-WebRequest -Uri $downloadUrl -OutFile $zipPath
Expand-Archive -LiteralPath $zipPath -DestinationPath $extractPath -Force

$packageRoot = Join-Path $extractPath 'irs-pt-2026-template'
$installer = Join-Path $packageRoot 'scripts\install-irs-pt-2026.ps1'

if (-not (Test-Path -LiteralPath $installer)) {
    throw "Installer not found inside downloaded package: $installer"
}

& $installer -Destination $destination -Mode $mode

Write-Host "Installed IRS PT 2026 pack from $downloadUrl"
Write-Host "Mode: $mode"
Write-Host "Destination: $destination"