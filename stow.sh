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

migrate_vscode_files() {
  local package_dir="${SCRIPT_DIR}/dotfiles/Library/Application Support/Code/User"
  local target_dir="$HOME/Library/Application Support/Code/User"
  local filename source target

  [[ -d "$target_dir" ]] || return 0

  # Move only exact copies of the files now managed by this checkout. A
  # differing file is left untouched and reported as a Stow conflict below.
  for filename in settings.json keybindings.json; do
    source="${package_dir}/${filename}"
    target="${target_dir}/${filename}"
    if [[ -f "$target" && ! -L "$target" ]]; then
      if cmp -s "$source" "$target"; then
        printf '%s\n' "Migrating VS Code ${filename} to the dotfiles checkout"
        rm -- "$target"
      else
        echo "Cannot stow VS Code ${filename}: existing file differs from the managed copy." >&2
        echo "Back it up or merge it manually, then run ./stow.sh again." >&2
        return 1
      fi
    fi
  done
}

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

stow_args=(--restow --no-folding --ignore='\.DS_Store')

migrate_folded_config
migrate_vscode_files
if [[ -f "$HOME/.config/atuin/config.toml" && ! -L "$HOME/.config/atuin/config.toml" ]] &&
  ! cmp -s \
    "${SCRIPT_DIR}/dotfiles/.config/atuin/config.toml" \
    "$HOME/.config/atuin/config.toml"; then
  printf '%s\n' "Leaving divergent Atuin config user-managed: $HOME/.config/atuin/config.toml"
  stow_args+=(--ignore='^\.config/atuin/config\.toml$')
fi
printf '\033[1;34m==>\033[0m %s\n' "Applying dotfiles with GNU Stow"
cd "${SCRIPT_DIR}" && stow "${stow_args[@]}" -d dotfiles -t "$HOME" .
