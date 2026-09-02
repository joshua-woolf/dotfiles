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

# Update the OS, apps, SDKs and all local git repos.
function update {
  sudo softwareupdate -i -a
  mise upgrade
  brew update
  brew upgrade --greedy --yes
  ugr
}

# Fetch + pull every git repo (and its worktrees) under $REPOS_DIR.
function ugr {
  local root_directory="${REPOS_DIR}"

  if [ ! -d "$root_directory" ]; then
    echo "Error: Directory '$root_directory' does not exist."
    return 1
  fi

  echo "Updating Git repositories in: $root_directory"

  local -A seen
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
      [[ -n "${seen[$worktree_path]}" ]] && continue
      seen[$worktree_path]=1

      echo "Updating $(basename "$worktree_path")..."
      if ! git -C "$worktree_path" fetch --prune \
        || ! git -C "$worktree_path" worktree prune \
        || ! git -C "$worktree_path" pull; then
        echo "Warning: Git operations failed in $(basename "$worktree_path")"
      fi
    done
  done

  echo "Finished updating repositories."
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
  brew cleanup --prune=all
  brew autoremove

  npm cache clean --force
  rm -rf "$HOME/.npm/_npx"                 # npm cache clean only clears _cacache
  pnpm store prune
  rm -rf "$HOME/.bun/install/cache"        # bun pm cache rm needs a package.json in cwd
  pip3 cache purge
  gem cleanup
  go clean -cache -testcache -modcache -fuzzcache
  dotnet nuget locals all --clear
  uv cache clean --force
  rm -rf "$HOME/.cargo/registry/cache" "$HOME/.cargo/git/checkouts"

  # Tool versions no longer referenced by any mise config. --tools so that
  # tracked configuration links are left alone.
  command -v mise >/dev/null 2>&1 && mise prune --tools

  command -v trivy >/dev/null 2>&1 \
    && trivy clean --vuln-db --java-db --scan-cache --checks-bundle
  rm -rf "$HOME/Library/Caches/ms-playwright"

  # Editor caches — reindexed on next launch.
  rm -rf "$HOME/Library/Caches/JetBrains"
  rm -rf "$HOME/Library/Application Support/Code/Cache" \
         "$HOME/Library/Application Support/Code/CachedData" \
         "$HOME/Library/Application Support/Code/CachedExtensionVSIXs"

  # Frees space inside the Rancher VM. The VM's own disk image does not shrink;
  # that needs a factory reset from Rancher Desktop.
  docker system prune --all --volumes --force

  # Each rust toolchain is ~1.3G and rustup never removes the old ones a mise
  # upgrade leaves behind. Keep the active toolchain and repoint rustup's default
  # at it first, so shells without mise activation still have a usable default,
  # then drop the rest. Skipped entirely if the active toolchain can't be read,
  # rather than risk uninstalling everything.
  if command -v rustup >/dev/null 2>&1; then
    local active_toolchain stale_toolchain
    active_toolchain="$(rustup show active-toolchain 2>/dev/null | cut -d' ' -f1)"
    if [ -n "$active_toolchain" ]; then
      rustup default "$active_toolchain"
      for stale_toolchain in ${(f)"$(rustup toolchain list | cut -d' ' -f1)"}; do
        if [ -n "$stale_toolchain" ] && [ "$stale_toolchain" != "$active_toolchain" ]; then
          rustup toolchain uninstall "$stale_toolchain"
        fi
      done
    fi
  fi
}
