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

migrate_folded_config() {
  local current_target package_target

  # Older versions of this script could fold the package's .config directory
  # into one symlink. Remove only that exact managed symlink before switching to
  # per-file links; unrelated user-managed .config symlinks remain protected.
  if [[ -L "$HOME/.config" && -d "$HOME/.config" ]]; then
    current_target="$(cd "$HOME/.config" && pwd -P)"
    package_target="$(cd "${SCRIPT_DIR}/dotfiles/.config" && pwd -P)"
    if [[ "$current_target" == "$package_target" ]]; then
      printf '%s\n' "Migrating folded .config symlink to individual links"
      rm "$HOME/.config"
    fi
  fi
}

migrate_folded_config
printf '\033[1;34m==>\033[0m %s\n' "Applying dotfiles with GNU Stow"
cd "${SCRIPT_DIR}" && stow --restow --no-folding --ignore='\.DS_Store' -d dotfiles -t "$HOME" .
