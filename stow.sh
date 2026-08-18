#!/usr/bin/env bash
#
# Re-apply the dotfiles symlinks with GNU Stow. Idempotent: --restow removes
# stale links and recreates the current set. Conflicts (pre-existing
# non-symlink files) are surfaced rather than clobbered.
#
# Usage: ./stow.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v stow >/dev/null 2>&1; then
  echo "stow not found — install it with 'brew install stow'." >&2
  exit 1
fi

printf '\033[1;34m==>\033[0m %s\n' "Applying dotfiles with GNU Stow"
cd "${SCRIPT_DIR}" && stow --restow --ignore='\.DS_Store' -d dotfiles -t "$HOME" .
