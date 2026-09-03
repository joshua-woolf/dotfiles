if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

export CARAPACE_BRIDGES="zsh"
export DOTNET_ROOT="$HOME/.dotnet"
export HOMEBREW_NO_ANALYTICS="1"
export PATH="$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.rd/bin:$HOME/go/bin"
export REPOS_DIR="$HOME/Repos"
export SCRIPTS_DIR="$HOME/Scripts"
