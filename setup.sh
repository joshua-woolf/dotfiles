#!/usr/bin/env bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle --file ./Brewfile

npm install -g @anthropic-ai/claude-code ccusage npm
