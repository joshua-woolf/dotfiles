function hosts {
  code /etc/hosts
}

function kubeconfig {
  code "$HOME/.kube/config"
}

function update {
  brew update && brew upgrade --greedy
}

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
