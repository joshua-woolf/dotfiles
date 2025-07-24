HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000

setopt APPEND_HISTORY
setopt AUTO_CD
setopt CORRECT
setopt CORRECT_ALL
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt NO_CASE_GLOB

zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix

fpath=(/Users/joshuaw/.docker/completions $fpath)

autoload -Uz compinit
compinit

alias ll='ls -al'

function home {
  code "$HOME"
}

function hosts {
  code /etc/hosts
}

function kubeconfig {
  code "$HOME/.kube/config"
}

function repos {
  cd ~/GitHub/
}

function update {
  brew update && brew upgrade --greedy
}

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
