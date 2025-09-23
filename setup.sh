#!/usr/bin/env bash

## Install Rosetta

sudo softwareupdate --install-rosetta

## Setup OS Configuration

defaults write com.apple.finder AppleShowAllFiles -bool true

## Install Homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

## Install Apps

brew bundle --file ./Brewfile

## GitHub Login

gh auth login

## Setup GitHub Directory

REPOS_DIR="$HOME/Repos"

mkdir -p "$REPOS_DIR"

cd "$REPOS_DIR" || exit

git clone https://github.com/joshua-woolf/dotfiles.git

cd dotfiles || exit

stow -d dotfiles -t "$HOME" .

## Setup Node

nvm install node
nvm alias default node

## Install Claude Code

npm install -g @anthropic-ai/claude-code@latest ccusage@latest npm@latest pnpm@latest

## Update Hosts File

curl -fsSL https://raw.githubusercontent.com/StevenBlack/hosts/refs/heads/master/hosts -o /tmp/hosts_new

sudo cp /tmp/hosts_new /etc/hosts

rm /tmp/hosts_new
