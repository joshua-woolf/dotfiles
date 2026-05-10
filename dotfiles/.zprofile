eval "$(/opt/homebrew/bin/brew shellenv)"

export CARAPACE_BRIDGES='zsh'
export DOTNET_ROOT="$HOME/.dotnet"
export HOMEBREW_NO_ANALYTICS=1
export PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$DOTNET_ROOT:$DOTNET_ROOT/tools"
export REPOS_DIR="$HOME/Repos"
export SCRIPTS_DIR="$HOME/Scripts"
