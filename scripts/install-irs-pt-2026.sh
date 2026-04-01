#!/usr/bin/env sh
set -eu

if [ "$#" -lt 1 ]; then
  echo "Usage: ./scripts/install-irs-pt-2026.sh <destination> [copilot|claude|both]" >&2
  exit 1
fi

DESTINATION="$1"
MODE="${2:-both}"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SOURCE_ROOT=$(dirname "$SCRIPT_DIR")

copy_portable_file() {
  src_rel="$1"
  dst_rel="$2"
  src="$SOURCE_ROOT/$src_rel"
  dst="$DESTINATION/$dst_rel"
  dst_dir=$(dirname "$dst")

  if [ ! -f "$src" ]; then
    echo "Source file not found: $src" >&2
    exit 1
  fi

  mkdir -p "$dst_dir"
  cp "$src" "$dst"
  echo "Copied $src_rel -> $dst_rel"
}

mkdir -p "$DESTINATION"

DOCS="docs/irs-2026.md docs/mcp-devtools-irs-2026.md docs/irs-2026-interview-flow.md docs/install-portability.md docs/release-versioning.md"

case "$MODE" in
  copilot|both)
    copy_portable_file ".github/skills/irs-portugal-2026/SKILL.md" ".github/skills/irs-portugal-2026/SKILL.md"
    copy_portable_file ".github/agents/preencher-irs-pt-2026.agent.md" ".github/agents/preencher-irs-pt-2026.agent.md"
    copy_portable_file ".github/prompts/preencher-irs-pt-2026.prompt.md" ".github/prompts/preencher-irs-pt-2026.prompt.md"
    for doc in $DOCS; do
      copy_portable_file "$doc" "$doc"
    done
    ;;
esac

case "$MODE" in
  claude|both)
    copy_portable_file ".claude/skills/irs-portugal-2026/SKILL.md" ".claude/skills/irs-portugal-2026/SKILL.md"
    copy_portable_file "CLAUDE.md" "CLAUDE.md"
    for doc in $DOCS; do
      copy_portable_file "$doc" "$doc"
    done
    ;;
esac

echo "Installation complete. Mode: $MODE"
echo "Destination: $DESTINATION"