#!/usr/bin/env sh
set -eu

DESTINATION="${1:-${IRS_PT_2026_DESTINATION:-$(pwd)}}"
MODE="${2:-${IRS_PT_2026_MODE:-both}}"
REPO="${3:-${IRS_PT_2026_REPO:-PaivaTypeble/irs-pt-2026-agent-pack}}"
ASSET_NAME="${4:-${IRS_PT_2026_ASSET:-irs-pt-2026-template.zip}}"

case "$MODE" in
  copilot|claude|both)
    ;;
  *)
    echo "Invalid mode: $MODE. Use copilot, claude or both." >&2
    exit 1
    ;;
esac

DOWNLOAD_URL="https://github.com/$REPO/releases/latest/download/$ASSET_NAME"
TEMP_ROOT="${TMPDIR:-/tmp}/irs-pt-2026-$(date +%s)-$$"
ZIP_PATH="$TEMP_ROOT/$ASSET_NAME"
EXTRACT_PATH="$TEMP_ROOT/extract"

mkdir -p "$EXTRACT_PATH"

cleanup() {
  rm -rf "$TEMP_ROOT"
}

trap cleanup EXIT

if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$DOWNLOAD_URL" -o "$ZIP_PATH"
elif command -v wget >/dev/null 2>&1; then
  wget -q "$DOWNLOAD_URL" -O "$ZIP_PATH"
else
  echo "curl or wget is required" >&2
  exit 1
fi

if command -v unzip >/dev/null 2>&1; then
  unzip -q "$ZIP_PATH" -d "$EXTRACT_PATH"
else
  echo "unzip is required" >&2
  exit 1
fi

PACKAGE_ROOT="$EXTRACT_PATH/irs-pt-2026-template"
INSTALLER="$PACKAGE_ROOT/scripts/install-irs-pt-2026.sh"

if [ ! -f "$INSTALLER" ]; then
  echo "Installer not found inside downloaded package: $INSTALLER" >&2
  exit 1
fi

sh "$INSTALLER" "$DESTINATION" "$MODE"

echo "Installed IRS PT 2026 pack from $DOWNLOAD_URL"
echo "Mode: $MODE"
echo "Destination: $DESTINATION"