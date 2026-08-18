# Shell functions.

# Force-remove every docker container, then prune unused images, networks and volumes.
function drm {
  docker ps -aq | xargs -r docker rm -f
  docker system prune --volumes --force
  docker volume ls -qf dangling=true | xargs -r docker volume rm
}

# Scaffold a new repo from the template into $REPOS_DIR and open it.
function nr {
  cd "${REPOS_DIR}"
  mkdir -p "$1"
  git clone https://github.com/joshua-woolf/starter-template.git "$1"
  cd "$1"
  rm -rf .git
  git init
  git add .
  git commit -m "Initial commit from template"
  code .
}

# Update the OS, apps, SDKs, global npm tooling and all local git repos.
function update {
  sudo softwareupdate -i -a
  mas update
  mise upgrade
  brew update
  brew upgrade --greedy --yes
  ugr
}

# Fetch + pull every git repo (and its worktrees) under $REPOS_DIR.
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

        git worktree list --porcelain | grep -E "^worktree" | cut -d' ' -f2 | while read -r worktree_path; do
          if [ "$worktree_path" != "$dir" ] && [ -d "$worktree_path" ]; then
            echo "  Updating worktree: $(basename "$worktree_path")..."
            if cd "$worktree_path"; then
              git pull
              if [ $? -ne 0 ]; then
                echo "  Warning: Git pull failed in worktree $(basename "$worktree_path")"
              fi
            fi
          fi
        done
      else
        echo "Error: Failed to change to directory: $dir"
      fi
      echo ""
    fi
  done

  cd "$original_dir"
  echo "Finished updating repositories."
}

# Interactive kubectl context picker (arrow keys to select, enter to switch).
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

# Reclaim disk space across brew, npm, pnpm, pip, gem, go, dotnet and docker caches.
function clean {
  brew cleanup --prune=all
  brew autoremove
  npm cache clean --force
  pnpm store prune
  pip3 cache purge
  gem cleanup
  go clean -cache -testcache -modcache -fuzzcache
  dotnet nuget locals all --clear
  docker system prune --all --volumes --force
  uv cache clean --force
}
