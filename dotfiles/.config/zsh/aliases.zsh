# Shell aliases.

alias ..="cd .."
alias c="clear"
alias cc="clear && claude --permission-mode auto"
alias ccw="clear && claude --permission-mode auto --worktree"
alias d="docker"
alias dc="docker-compose"
alias dcu="docker-compose up --build"
alias dcd="docker-compose down -v"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"
alias g="git"
alias grep='grep --color=auto'
alias home='code "$HOME"'
alias hosts='code /etc/hosts'
alias kubeconfig='code "$HOME/.kube/config"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ipl="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias k="kubectl"
alias ls="command ls -F -G"
alias ll="ls -alF -G"
alias o='open .'
alias repos="cd ${REPOS_DIR}"
alias path='echo -e ${PATH//:/\\n}'
alias sudo='sudo '
alias v='code .'
