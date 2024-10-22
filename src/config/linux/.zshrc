function update {
  sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y
  brew update && brew upgrade
  sudo snap refresh
}

source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"
