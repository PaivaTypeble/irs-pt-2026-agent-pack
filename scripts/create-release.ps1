param(
    [Parameter(Mandatory = $true)]
    [string]$GitHubRepo,

    [string]$Tag = ('v' + (Get-Date -Format 'yyyy.MM.dd')),
    [string]$Title = 'IRS PT 2026 Agent Pack',
    [string]$Notes = 'Public release of the IRS PT 2026 agent pack with template zip and bootstrap installers.',
    [switch]$Latest
)

$sourceRoot = Split-Path -Parent $PSScriptRoot
$buildScript = Join-Path $PSScriptRoot 'build-template.ps1'
$zipPath = Join-Path (Join-Path $sourceRoot 'dist') 'irs-pt-2026-template.zip'
$bootstrapPs1 = Join-Path $PSScriptRoot 'bootstrap-install.ps1'
$bootstrapSh = Join-Path $PSScriptRoot 'bootstrap-install.sh'
$assets = @($zipPath, $bootstrapPs1, $bootstrapSh)

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    throw 'gh CLI is required to create a GitHub release.'
}

& $buildScript | Out-Null

gh release view $Tag --repo $GitHubRepo *> $null
if ($LASTEXITCODE -eq 0) {
    gh release upload $Tag $assets --repo $GitHubRepo --clobber | Out-Null
    if ($Latest) {
        gh release edit $Tag --repo $GitHubRepo --latest
    }
    Write-Host "Updated release $Tag on $GitHubRepo"
    return
}

$args = @('release', 'create', $Tag)
$args += $assets
$args += @('--repo', $GitHubRepo, '--title', $Title, '--notes', $Notes)
if ($Latest) {
    $args += '--latest'
}

gh @args | Out-Null
Write-Host "Created release $Tag on $GitHubRepo"