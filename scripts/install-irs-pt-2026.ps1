param(
    [Parameter(Mandatory = $true)]
    [string]$Destination,

    [ValidateSet('copilot', 'claude', 'both')]
    [string]$Mode = 'both'
)

$sourceRoot = Split-Path -Parent $PSScriptRoot

function Copy-PortableFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$SourceRelativePath,

        [Parameter(Mandatory = $true)]
        [string]$DestinationRelativePath
    )

    $sourcePath = Join-Path $sourceRoot $SourceRelativePath
    $destinationPath = Join-Path $Destination $DestinationRelativePath
    $destinationDir = Split-Path -Parent $destinationPath

    if (-not (Test-Path -LiteralPath $sourcePath)) {
        throw "Source file not found: $sourcePath"
    }

    New-Item -ItemType Directory -Force -Path $destinationDir | Out-Null
    Copy-Item -LiteralPath $sourcePath -Destination $destinationPath -Force
    Write-Host "Copied $SourceRelativePath -> $DestinationRelativePath"
}

New-Item -ItemType Directory -Force -Path $Destination | Out-Null

$docs = @(
    'docs/irs-2026.md',
    'docs/mcp-devtools-irs-2026.md',
    'docs/irs-2026-interview-flow.md',
    'docs/install-portability.md',
    'docs/release-versioning.md'
)

if ($Mode -in @('copilot', 'both')) {
    Copy-PortableFile '.github/skills/irs-portugal-2026/SKILL.md' '.github/skills/irs-portugal-2026/SKILL.md'
    Copy-PortableFile '.github/agents/preencher-irs-pt-2026.agent.md' '.github/agents/preencher-irs-pt-2026.agent.md'
    Copy-PortableFile '.github/prompts/preencher-irs-pt-2026.prompt.md' '.github/prompts/preencher-irs-pt-2026.prompt.md'

    foreach ($doc in $docs) {
        Copy-PortableFile $doc $doc
    }
}

if ($Mode -in @('claude', 'both')) {
    Copy-PortableFile '.claude/skills/irs-portugal-2026/SKILL.md' '.claude/skills/irs-portugal-2026/SKILL.md'
    Copy-PortableFile 'CLAUDE.md' 'CLAUDE.md'

    foreach ($doc in $docs) {
        Copy-PortableFile $doc $doc
    }
}

Write-Host "Installation complete. Mode: $Mode"
Write-Host "Destination: $Destination"