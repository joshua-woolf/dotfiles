export PATH="$HOME/.dotnet/tools:$PATH"

function update {
  sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y
  brew update && brew upgrade
  sudo snap refresh
}

eval "$(starship init bash)"
