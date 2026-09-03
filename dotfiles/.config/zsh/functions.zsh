# Shell functions.

# Force-remove every docker container, then prune unused images, networks and volumes.
function drm {
  if ! command -v docker >/dev/null 2>&1; then
    echo "docker not found — nothing to remove." >&2
    return 1
  fi
  if ! _confirm "Force-remove all Docker containers and prune unused data?"; then
    echo "Cancelled."
    return 0
  fi

  local failed=0
  docker ps -aq | xargs -r docker rm -f || failed=1
  docker system prune --volumes --force || failed=1
  docker volume ls -qf dangling=true | xargs -r docker volume rm || failed=1
  return "$failed"
}

# Ask before an operation that can remove user data.
function _confirm {
  local response
  read -r "response?$1 [y/N] " || { print; return 1; }
  print
  [[ "$response" == [Yy] ]]
}

# Run a command when installed, while allowing optional tools to be absent.
function _run_if_available {
  local command_name="$1"
  shift
  if command -v "$command_name" >/dev/null 2>&1; then
    "$command_name" "$@"
  else
    echo "Skipping $command_name (not installed)."
  fi
}

# Empty local and mounted-volume trash after an explicit confirmation.
function emptytrash {
  if ! _confirm "Permanently delete all trash and quarantine records?"; then
    echo "Cancelled."
    return 0
  fi

  local failed=0 quarantine_db
  local -a volume_trash asl_logs quarantine_dbs
  volume_trash=(/Volumes/*/.Trashes(N))
  asl_logs=(/private/var/log/asl/*.asl(N))
  quarantine_dbs=("$HOME"/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV*(N))

  if (( ${#volume_trash} )); then
    sudo rm -rfv -- "${volume_trash[@]}" || failed=1
  fi
  sudo rm -rfv -- "$HOME/.Trash" || failed=1
  if (( ${#asl_logs} )); then
    sudo rm -rfv -- "${asl_logs[@]}" || failed=1
  fi
  for quarantine_db in "${quarantine_dbs[@]}"; do
    sqlite3 "$quarantine_db" 'delete from LSQuarantineEvent' || failed=1
  done

  return "$failed"
}

# Scaffold a new repo from the template into $REPOS_DIR and open it.
function nr {
  local repo_name="${1:-}"
  local root_directory="${REPOS_DIR:-$HOME/Repos}"
  local destination staging_directory

  if [[ $# -ne 1 || -z "$repo_name" ]]; then
    echo "Usage: nr <name>" >&2
    return 2
  fi
  if [[ "$repo_name" == -* || "$repo_name" == */* || "$repo_name" == "." || "$repo_name" == ".." ]]; then
    echo "Error: repository name must be a single directory name." >&2
    return 2
  fi

  mkdir -p -- "$root_directory" || return 1
  destination="${root_directory}/${repo_name}"
  if [[ -e "$destination" || -L "$destination" ]]; then
    echo "Error: destination already exists: $destination" >&2
    return 1
  fi

  staging_directory=$(mktemp -d "${root_directory}/.nr.XXXXXX") || return 1
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

# Update the OS, apps, SDKs and all local git repos.
function update {
  local failed=0

  sudo softwareupdate -i -a || failed=1
  mise upgrade || failed=1
  brew update || failed=1
  brew upgrade --greedy --yes || failed=1
  ugr || failed=1

  if (( failed )); then
    echo "Update completed with failures." >&2
    return 1
  fi
  echo "Update completed successfully."
}

# Fetch + pull every git repo (and its worktrees) under $REPOS_DIR.
function ugr {
  local root_directory="${REPOS_DIR:-$HOME/Repos}"
  setopt local_options null_glob

  if [ ! -d "$root_directory" ]; then
    echo "Error: Directory '$root_directory' does not exist."
    return 1
  fi

  echo "Updating Git repositories in: $root_directory"

  local -A seen
  local -a failed_repositories=()
  local dir worktree_path

  for dir in "$root_directory"/*/; do
    dir="${dir%/}"
    # A linked worktree has .git as a file rather than a directory, so ask git
    # instead of testing for a directory.
    git -C "$dir" rev-parse --git-dir >/dev/null 2>&1 || continue

    # Expand each entry to every worktree of its repository, so a repo reached
    # both directly and as another entry's worktree is still updated exactly
    # once — and every path gets the same treatment.
    for worktree_path in "$dir" ${(f)"$(git -C "$dir" worktree list --porcelain | sed -n 's/^worktree //p')"}; do
      [[ -z "$worktree_path" || ! -d "$worktree_path" ]] && continue
      [[ -n "${seen[$worktree_path]:-}" ]] && continue
      seen[$worktree_path]=1

      echo "Updating $(basename "$worktree_path")..."
      if ! git -C "$worktree_path" fetch --prune \
        || ! git -C "$worktree_path" worktree prune \
        || ! git -C "$worktree_path" pull --ff-only; then
        echo "Warning: Git operations failed in $(basename "$worktree_path")"
        failed_repositories+=("$worktree_path")
      fi
    done
  done

  if (( ${#failed_repositories} )); then
    echo "Repositories with update failures:" >&2
    printf '  - %s\n' "${failed_repositories[@]}" >&2
    return 1
  fi
  echo "Finished updating repositories successfully."
}

# Interactive kubectl context picker.
function kc {
  local context
  context="$(kubectl config get-contexts -o name | fzf --height=40% --reverse --prompt='context> ')" \
    && [ -n "$context" ] && kubectl config use-context "$context"
}

# Reclaim disk space. The caches that actually hold gigabytes here are the ones
# no tool cleans for you: npm's _npx directory, the trivy vulnerability DB, and
# the Rider and VS Code caches. Everything below is re-downloaded or rebuilt on
# demand.
function clean {
  if ! _confirm "Delete package-manager, editor, scanner and Docker caches?"; then
    echo "Cancelled."
    return 0
  fi

  local failed=0
  _run_if_available brew cleanup --prune=all || failed=1
  _run_if_available brew autoremove || failed=1

  _run_if_available npm cache clean --force || failed=1
  rm -rf -- "$HOME/.npm/_npx"                 || failed=1 # npm cache clean only clears _cacache
  _run_if_available pnpm store prune || failed=1
  rm -rf -- "$HOME/.bun/install/cache"        || failed=1 # bun pm cache rm needs a package.json in cwd
  _run_if_available pip3 cache purge || failed=1
  _run_if_available gem cleanup || failed=1
  _run_if_available go clean -cache -testcache -modcache -fuzzcache || failed=1
  _run_if_available dotnet nuget locals all --clear || failed=1
  _run_if_available uv cache clean --force || failed=1
  rm -rf -- "$HOME/.cargo/registry/cache" "$HOME/.cargo/git/checkouts" || failed=1

  # Tool versions no longer referenced by any mise config. --tools so that
  # tracked configuration links are left alone.
  _run_if_available mise prune --tools || failed=1

  _run_if_available trivy clean --vuln-db --java-db --scan-cache --checks-bundle || failed=1
  rm -rf -- "$HOME/Library/Caches/ms-playwright" || failed=1

  # Editor caches — reindexed on next launch.
  rm -rf -- "$HOME/Library/Caches/JetBrains" || failed=1
  rm -rf -- "$HOME/Library/Application Support/Code/Cache" \
         "$HOME/Library/Application Support/Code/CachedData" \
         "$HOME/Library/Application Support/Code/CachedExtensionVSIXs" || failed=1

  # Frees space inside the Rancher VM. The VM's own disk image does not shrink;
  # that needs a factory reset from Rancher Desktop.
  _run_if_available docker system prune --all --volumes --force || failed=1

  # Each rust toolchain is ~1.3G and rustup never removes the old ones a mise
  # upgrade leaves behind. Keep the active toolchain and repoint rustup's default
  # at it first, so shells without mise activation still have a usable default,
  # then drop the rest. Skipped entirely if the active toolchain can't be read,
  # rather than risk uninstalling everything.
  if command -v rustup >/dev/null 2>&1; then
    local active_toolchain stale_toolchain
    active_toolchain="$(rustup show active-toolchain 2>/dev/null | cut -d' ' -f1)"
    if [ -n "$active_toolchain" ]; then
      rustup default "$active_toolchain" || failed=1
      for stale_toolchain in ${(f)"$(rustup toolchain list | cut -d' ' -f1)"}; do
        if [ -n "$stale_toolchain" ] && [ "$stale_toolchain" != "$active_toolchain" ]; then
          rustup toolchain uninstall "$stale_toolchain" || failed=1
        fi
      done
    fi
  fi

  if (( failed )); then
    echo "Cleanup completed with failures." >&2
    return 1
  fi
  echo "Cleanup completed successfully."
}
