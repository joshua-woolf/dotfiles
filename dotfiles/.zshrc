export HOMEBREW_NO_ANALYTICS=1

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=8192
HISTSIZE=8192

setopt APPEND_HISTORY
setopt AUTO_CD
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

alias ..="cd .."
alias c="clear"
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias d="docker"
alias dc="docker-compose"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
alias g="git"
alias grep='grep --color=auto'
alias home='code "$HOME"'
alias hosts='code /etc/hosts'
alias kubeconfig= 'code "$HOME/.kube/config"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ipl="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias k="kubectl"
alias ls="command ls -F -G"
alias ll="ls -alF -G"
alias repos='cd ~/GitHub'
alias path='echo -e ${PATH//:/\\n}'
alias sudo='sudo '
alias update='sudo softwareupdate -i -a; brew update && brew upgrade --greedy && brew cleanup; npm install npm -g; npm update -g'

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
