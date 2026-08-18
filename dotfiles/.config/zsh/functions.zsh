# Shell functions.

# Force-remove every docker container, then prune unused images, networks and volumes.
function drm {
  docker ps -aq | xargs -r docker rm -f
  docker system prune --volumes --force
  docker volume ls -qf dangling=true | xargs -r docker volume rm
}

# Scaffold a new repo from the template into $REPOS_DIR and open it.
function nr {
  local repo_name="${1:-}"
  local destination staging_directory

  if [[ $# -ne 1 || -z "$repo_name" ]]; then
    echo "Usage: nr <name>" >&2
    return 2
  fi
  if [[ "$repo_name" == -* || "$repo_name" == */* || "$repo_name" == "." || "$repo_name" == ".." ]]; then
    echo "Error: repository name must be a single directory name." >&2
    return 2
  fi

  mkdir -p -- "$REPOS_DIR" || return 1
  destination="${REPOS_DIR}/${repo_name}"
  if [[ -e "$destination" || -L "$destination" ]]; then
    echo "Error: destination already exists: $destination" >&2
    return 1
  fi

  staging_directory=$(mktemp -d "${REPOS_DIR}/.nr.XXXXXX") || return 1
  if ! git clone https://github.com/joshua-woolf/starter-template.git "$staging_directory"; then
    echo "Error: template clone failed; no repository was created." >&2
    rm -rf -- "$staging_directory"
    return 1
  fi
  if ! rm -rf -- "$staging_directory/.git"; then
    echo "Error: could not remove template Git history; leaving staging directory:" >&2
    echo "       $staging_directory" >&2
    return 1
  fi
  if ! git -C "$staging_directory" init; then
    echo "Error: could not initialise the new repository; leaving staging directory:" >&2
    echo "       $staging_directory" >&2
    return 1
  fi
  if ! git -C "$staging_directory" add --all \
    || ! git -C "$staging_directory" commit -m "Initial commit from template"; then
    echo "Error: could not create the initial commit; leaving staging directory:" >&2
    echo "       $staging_directory" >&2
    return 1
  fi
  if ! mv -- "$staging_directory" "$destination"; then
    echo "Error: could not publish the new repository; leaving staging directory:" >&2
    echo "       $staging_directory" >&2
    return 1
  fi
  code "$destination"
}

# Update the OS, apps, SDKs, global npm tooling and all local git repos.
function update {
  local failed=0

  sudo softwareupdate -i -a || failed=1
  mas update || failed=1
  mise upgrade || failed=1
  brew update || failed=1
  brew upgrade --greedy --yes || failed=1
  if command -v npm >/dev/null 2>&1; then
    npm update --global || failed=1
  fi
  ugr || failed=1

  if (( failed )); then
    echo "Update completed with failures." >&2
    return 1
  fi
  echo "Update completed successfully."
}

# Fetch + pull every git repo (and its worktrees) under $REPOS_DIR.
function ugr {
  setopt local_options null_glob
  local root_directory="${REPOS_DIR}"
  local repo_path repo_name worktree_path worktree_name
  local -a failed_repositories=()

  if [ ! -d "$root_directory" ]; then
    echo "Error: Directory '$root_directory' does not exist."
    return 1
  fi

  echo "Updating Git repositories in: $root_directory"

  for dir in "$root_directory"/*/; do
    [ ! -d "$dir" ] && continue
    repo_path="${dir%/}"
    [ ! -e "$repo_path/.git" ] && continue
    repo_name="${repo_path:t}"
    echo "Updating $repo_name..."

    if ! git -C "$repo_path" fetch --prune \
      || ! git -C "$repo_path" worktree prune \
      || ! git -C "$repo_path" pull --ff-only; then
      failed_repositories+=("$repo_name")
      echo "  Warning: base repository update failed; worktrees skipped."
      echo ""
      continue
    fi

    while IFS= read -r worktree_path; do
      [ "$worktree_path" = "$repo_path" ] && continue
      [ ! -d "$worktree_path" ] && continue
      worktree_name="${worktree_path:t}"
      echo "  Updating worktree $worktree_name..."
      if ! git -C "$worktree_path" pull --ff-only; then
        failed_repositories+=("$repo_name/$worktree_name")
      fi
    done < <(git -C "$repo_path" worktree list --porcelain | sed -n 's/^worktree //p')
    echo ""
  done

  if (( ${#failed_repositories} )); then
    echo "Repositories with update failures:" >&2
    printf '  - %s\n' "${failed_repositories[@]}" >&2
    return 1
  fi
  echo "Finished updating repositories successfully."
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
