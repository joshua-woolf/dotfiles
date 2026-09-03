# Configuration

My personal configuration for macOS at home. Managed with **GNU Stow** (symlinks),
**Homebrew** (apps and system utilities) and **mise** (SDKs, runtimes and versioned
developer CLIs).

## Setup

Clone the repo and run the bootstrap script. It is idempotent — safe to re-run at
any time.

```shell
REPOS_DIR="$HOME/Repos"
mkdir -p "$REPOS_DIR"
git clone https://github.com/joshua-woolf/dotfiles.git "$REPOS_DIR/dotfiles"
cd "$REPOS_DIR/dotfiles"
./install.sh
```

`install.sh` installs Rosetta and Homebrew, runs `brew bundle`, applies the dotfiles with Stow, runs `mise install`, and shows hidden files in Finder. Interactive/one-off steps (Aspire, etc.) are printed at the end for you to run by hand.

## Maintenance

Update the Brewfile after installing/removing apps:

```shell
brew bundle dump --file=Brewfile --force --formula --cask --tap --mas --no-describe
```

Run `update` (see below) to keep the OS, apps, SDKs and local repos current.

Re-apply the Stow symlinks after adding, moving or removing anything under
[`dotfiles/`](dotfiles):

```shell
./stow.sh
```

Run the local repository checks before committing changes:

```shell
./scripts/doctor
```

## Aliases & functions

Defined in [`dotfiles/.config/zsh/`](dotfiles/.config/zsh) and
[`dotfiles/.gitconfig`](dotfiles/.gitconfig).

### Shell functions

| Command | Description |
| --- | --- |
| `nr <name>` | Scaffold a new repo from the template into `$REPOS_DIR` and open it. |
| `update` | Update macOS, `mise`, Homebrew, and all local repos. |
| `ugr` | Fetch + fast-forward every git repo (and its worktrees) under `$REPOS_DIR`, reporting failures. |
| `drm` | Force-remove every docker container, then prune images, networks and volumes. |
| `kc` | Interactive `kubectl` context picker (`fzf`). |
| `clean` | Reclaim disk space: package-manager, editor, scanner and docker caches, plus tool versions and rust toolchains nothing references any more. |

Common aliases include `g` (git), `k` (kubectl), `d`/`dc`/`dcu`/`dcd` (Docker Compose),
`v`/`home` (open in VS Code), and `repos` (cd to `$REPOS_DIR`).

### Git aliases

| Alias | Description |
| --- | --- |
| `git gtm` | Go to `main`, prune, fast-forward, and safely delete merged branches whose upstream is gone. |
| `git l` | Compact one-line graph log. |
| `git ld [n]` | Your commits from the last `n` days (default 1). |
| `git u` | Fetch (prune) + prune worktrees + fast-forward pull. |
| `git s` | Short status with branch info. |
