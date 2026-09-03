#!/usr/bin/env bash
#
# Idempotent bootstrap for this macOS home-machine dotfiles repo.
# Safe to re-run: every step checks its own state and no-ops if already done.
#
# Usage: ./install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() { printf '\033[1;34m==>\033[0m %s\n' "$1"; }
skip() { printf '\033[2;37m  - %s\033[0m\n' "$1"; }

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This bootstrap targets macOS only." >&2
  exit 1
fi

install_rosetta() {
  log "Rosetta"
  if [[ "$(uname -m)" != "arm64" ]] || /usr/bin/pgrep -q oahd; then
    skip "already installed (or not needed)"
    return
  fi
  sudo softwareupdate --install-rosetta --agree-to-license
}

install_homebrew() {
  local brew_bin

  log "Homebrew"
  if command -v brew >/dev/null 2>&1; then
    skip "already installed"
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  if command -v brew >/dev/null 2>&1; then
    brew_bin="$(command -v brew)"
  elif [[ -x /opt/homebrew/bin/brew ]]; then
    brew_bin=/opt/homebrew/bin/brew
  elif [[ -x /usr/local/bin/brew ]]; then
    brew_bin=/usr/local/bin/brew
  else
    echo "Homebrew was installed but its executable could not be found." >&2
    return 1
  fi
  eval "$("$brew_bin" shellenv)"
}

install_brew_bundle() {
  log "Homebrew bundle"
  brew bundle --file "${SCRIPT_DIR}/Brewfile"
}

apply_dotfiles() {
  "${SCRIPT_DIR}/stow.sh"
}

install_mise_tools() {
  log "mise tools"
  if ! command -v mise >/dev/null 2>&1; then
    skip "mise not found — skipping"
    return
  fi
  mise install
}

configure_macos() {
  log "macOS defaults"
  defaults write com.apple.finder AppleShowAllFiles -bool true
  killall Finder 2>/dev/null || true
}

print_extras() {
  cat <<'EOF'

==> Done. The following one-off / interactive steps are NOT automated —
    run them by hand as needed:

  # Authenticate with GitHub
  gh auth login

  # .NET Aspire workload + CLI + C# language server
  dotnet workload install aspire
  dotnet tool install --global aspire.cli
  dotnet tool install --global csharp-ls

  # Azure Bastion extension
  az extension add --name bastion
EOF
}

main() {
  install_rosetta
  install_homebrew
  install_brew_bundle
  apply_dotfiles
  install_mise_tools
  configure_macos
  print_extras
}

main "$@"
