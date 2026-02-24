export CARAPACE_BRIDGES='zsh'
export DOTNET_ROOT="$HOME/.dotnet"
export HOMEBREW_NO_ANALYTICS=1
export NVM_DIR="$HOME/.nvm"
export PATH="$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools:$HOME/.rd/bin"
export REPOS_DIR="$HOME/Repos"
export SCRIPTS_DIR="$HOME/Scripts"

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

autoload -Uz compinit

compinit

zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

alias ..="cd .."
alias c="clear"
alias d="docker"
alias dc="docker-compose"
alias docker="podman"
alias docker-compose="podman-compose"
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
alias repos='cd "$REPOS_DIR"'
alias path='echo -e ${PATH//:/\\n}'
alias sudo='sudo '
alias update='sudo softwareupdate -i -a; brew update && brew upgrade --greedy; npm install -g --no-fund @anthropic-ai/claude-code@latest ccusage@latest npm@latest pnpm@latest'

function nr {
  cd "$REPOS_DIR"
  mkdir -p "$1"
  git clone https://github.com/joshua-woolf/starter-template.git "$1"
  cd "$1"
  rm -rf .git
  git init
  git add .
  git commit -m "Initial commit from template"
  code .
}

function ugr {
  local root_directory="${REPOS_DIR}"
  local original_dir=$(pwd)

  if [ ! -d "$root_directory" ]; then
    echo "Error: Directory '$root_directory' does not exist."
    return 1
  fi

  echo "Updating Git repositories in: $root_directory"

  for dir in "$root_directory"/*/; do
    [ ! -d "$dir" ] && continue
    if [ -d "$dir/.git" ]; then
      echo "Updating $(basename "$dir")..."

      if cd "$dir"; then
        git fetch --prune && git worktree prune && git pull
        if [ $? -ne 0 ]; then
          echo "Warning: Git operations failed in $(basename "$dir")"
        fi
      else
        echo "Error: Failed to change to directory: $dir"
      fi
      echo ""
    fi
  done

  cd "$original_dir"
  echo "Finished updating repositories."
}

function kc {
  local -a items
  local current idx=0 key

  items=("${(@f)$(kubectl config get-contexts -o name 2>/dev/null)}")
  [ ${#items} -eq 0 ] && echo "No contexts found." && return 1
  current=$(kubectl config current-context 2>/dev/null)

  for i in {1..${#items}}; do
    [ "${items[$i]}" = "$current" ] && idx=$((i-1)) && break
  done

  _kc_draw() {
    printf "\e[%dA" ${#items} 2>/dev/null
    for i in {1..${#items}}; do
      local label="${items[$i]}"
      [ "$label" = "$current" ] && label="$label (current)"
      if [ $((i-1)) -eq $idx ]; then
        printf "\e[2K  \e[32m> %s\e[0m\n" "$label"
      else
        printf "\e[2K    %s\n" "$label"
      fi
    done
  }

  printf '\n%.0s' {1..${#items}}
  _kc_draw

  while true; do
    read -rsk1 key
    if [ "$key" = $'\e' ]; then
      read -rsk1 -t 0.01 key
      if [ "$key" = "[" ]; then
        read -rsk1 -t 0.01 key
        case "$key" in
          A) ((idx > 0)) && ((idx--)) ;;
          B) ((idx < ${#items} - 1)) && ((idx++)) ;;
        esac
      else
        echo; return 0
      fi
    elif [ "$key" = $'\n' ]; then
      break
    elif [ "$key" = "q" ]; then
      echo; return 0
    fi
    _kc_draw
  done

  kubectl config use-context "${items[$((idx+1))]}"
  unfunction _kc_draw 2>/dev/null
}

function clean {
  brew cleanup -s
  brew autoremove
  npm cache clean --force
  pnpm store prune
  pip3 cache purge
  gem cleanup
  go clean -cache -testcache -modcache -fuzzcache
  dotnet nuget locals all --clear
  docker system prune --all --volumes --force
}

source /opt/homebrew/opt/nvm/nvm.sh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(atuin init zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
