#!/usr/bin/env bash

## Install Homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## Install Apps

brew bundle --file ./Brewfile

## Install Claude Code

npm install -g @anthropic-ai/claude-code ccusage npm

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
dockutil --no-restart --add "/Applications/Docker.app/Contents/MacOS/Docker Desktop.app"
dockutil --no-restart --add "/Applications/WezTerm.app"
dockutil --no-restart --add "/Applications/Discord.app"
dockutil --no-restart --add "/Applications/WhatsApp.app"
dockutil --no-restart --add "/Users/joshuaw/GitHub/" --section others
dockutil --no-restart --add "/Users/joshuaw/Downloads/" --section others

killall Dock

## Update Hosts File

REPOS_DIR="$HOME/GitHub"

mkdir -p "$REPOS_DIR"

cd "$REPOS_DIR" || exit 1

git clone https://github.com/StevenBlack/hosts.git "$REPOS_DIR/hosts" --depth 1

cd hosts

pip3 install --user -r requirements.txt # errors currently

python3 testUpdateHostsFile.py
