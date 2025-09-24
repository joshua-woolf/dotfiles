# Configuration

This is my personal configuration for macOS.

## Update the Brewfile

```bash
brew bundle dump --file=Brewfile --force
```

## Machine Setup

Install Rosetta:

```shell
sudo softwareupdate --install-rosetta
```

Show hidden files in Finder:

```shell
defaults write com.apple.finder AppleShowAllFiles -bool true
```

Install Homebrew:

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Install apps with Homebrew:

```shell
brew bundle --file ./Brewfile
```

Authenticate with GitHub:

```shell
gh auth login
```

Clone dotfiles and apply with GNU Stow:

```shell
REPOS_DIR="$HOME/Repos"
mkdir -p "$REPOS_DIR"
cd "$REPOS_DIR" || exit
git clone https://github.com/joshua-woolf/dotfiles.git dotfiles
cd dotfiles || exit
stow -d dotfiles -t "$HOME" .
```

Install Node:

```shell
nvm install node
nvm alias default node
```

Install apps with NPM:

```shell
npm install -g @anthropic-ai/claude-code ccusage npm pnpm
```

Install .NET SDK and Aspire workload:

```shell
SCRIPTS_DIR="$HOME/Scripts"
mkdir -p "$SCRIPTS_DIR"
cd "$SCRIPTS_DIR" || exit
wget https://dot.net/v1/dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --channel STS
dotnet workload install aspire
```

Block bad things with StevenBlack's hosts file:

```shell
curl -fsSL https://raw.githubusercontent.com/StevenBlack/hosts/refs/heads/master/hosts -o /tmp/hosts_new
sudo cp /tmp/hosts_new /etc/hosts
rm /tmp/hosts_new
```

Configure macOS for privacy and security:

[Privacy Guides macOS Overview](https://www.privacyguides.org/en/os/macos-overview/)
