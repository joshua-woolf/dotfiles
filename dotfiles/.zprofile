eval "$(/opt/homebrew/bin/brew shellenv)"

export CARAPACE_BRIDGES='zsh'
export DOTNET_ROOT="$HOME/.dotnet"
export HOMEBREW_NO_ANALYTICS=1
export PATH="$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools:$PATH:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.rd/bin:$HOME/go/bin:$HOME/.aspire/bin"
export REPOS_DIR="$HOME/Repos"
export SCRIPTS_DIR="$HOME/Scripts"
