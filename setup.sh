#!/usr/bin/env bash

## Setup GitHub Directory

REPOS_DIR="$HOME/GitHub"

mkdir -p "$REPOS_DIR"

cd "$REPOS_DIR" || exit

git clone https://github.com/joshua-woolf/dotfiles.git

cd dotfiles || exit

stow -d dotfiles -t "$HOME" .

## Install Rosetta

sudo softwareupdate --install-rosetta

## Install Homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/joshuaw/.zprofile

eval "$(/opt/homebrew/bin/brew shellenv)"

## Install Apps

brew bundle --file ./Brewfile

## Setup Dock

dockutil --no-restart --remove all
dockutil --no-restart --add "/System/Applications/System Settings.app"
dockutil --no-restart --add "/System/Applications/Reminders.app"
dockutil --no-restart --add "/System/Applications/Notes.app"
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/Claude.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/Rider.app"
dockutil --no-restart --add "/Applications/GitHub Desktop.app"
dockutil --no-restart --add "/Applications/Rancher Desktop.app"
dockutil --no-restart --add "/Applications/WezTerm.app"
dockutil --no-restart --add "/Applications/Discord.app"
dockutil --no-restart --add "/Applications/WhatsApp.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Users/joshuaw/GitHub/" --section others
dockutil --no-restart --add "/Users/joshuaw/Downloads/" --section others

killall Dock

## Setup OS Configuration

defaults write com.apple.finder AppleShowAllFiles -bool true

killall Finder

## Update Hosts File

curl -fsSL https://raw.githubusercontent.com/StevenBlack/hosts/refs/heads/master/hosts -o /tmp/hosts_new

sudo cp /tmp/hosts_new /etc/hosts

rm /tmp/hosts_new

## Install Claude Code

npm install -g @anthropic-ai/claude-code ccusage npm pnpm
