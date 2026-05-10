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

Install SDKs:

```shell
mise install
```

Install .NET Aspire workload:

```shell
dotnet workload install aspire
```

Install C# Language Server:

```shell
dotnet tool install --global csharp-ls
```

Block bad things with StevenBlack's hosts file:

```shell
curl -fsSL https://raw.githubusercontent.com/StevenBlack/hosts/refs/heads/master/hosts -o /tmp/hosts_new
sudo cp /tmp/hosts_new /etc/hosts
rm /tmp/hosts_new
```

Configure macOS for privacy and security:

[Privacy Guides macOS Overview](https://www.privacyguides.org/en/os/macos-overview/)
