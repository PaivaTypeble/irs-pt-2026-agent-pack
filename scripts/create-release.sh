#!/usr/bin/env sh
set -eu

if [ "$#" -lt 1 ]; then
  echo "Usage: ./scripts/create-release.sh <owner/repo> [tag]" >&2
  exit 1
fi

GITHUB_REPO="$1"
TAG="${2:-v$(date +%Y.%m.%d)}"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SOURCE_ROOT=$(dirname "$SCRIPT_DIR")
ZIP_PATH="$SOURCE_ROOT/dist/irs-pt-2026-template.zip"
BOOTSTRAP_PS1="$SCRIPT_DIR/bootstrap-install.ps1"
BOOTSTRAP_SH="$SCRIPT_DIR/bootstrap-install.sh"

if ! command -v gh >/dev/null 2>&1; then
  echo "gh CLI is required to create a GitHub release." >&2
  exit 1
fi

"$SCRIPT_DIR/build-template.sh"

if gh release view "$TAG" --repo "$GITHUB_REPO" >/dev/null 2>&1; then
  gh release upload "$TAG" "$ZIP_PATH" "$BOOTSTRAP_PS1" "$BOOTSTRAP_SH" --repo "$GITHUB_REPO" --clobber >/dev/null
  echo "Updated release $TAG on $GITHUB_REPO"
else
  gh release create "$TAG" "$ZIP_PATH" "$BOOTSTRAP_PS1" "$BOOTSTRAP_SH" --repo "$GITHUB_REPO" --title "IRS PT 2026 Agent Pack" --notes "Public release of the IRS PT 2026 agent pack with template zip and bootstrap installers." >/dev/null
  echo "Created release $TAG on $GITHUB_REPO"
fi