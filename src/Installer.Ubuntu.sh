#!/bin/bash

touch "${HOME}/.hushlogin"

sudo apt-get update \
  && sudo apt-get upgrade -y \
  && sudo apt-get autoremove -y

sudo apt-get install -y \
apt-transport-https \
dnsutils \
gnupg2 \
jq \
net-tools \
unzip \
zsh


function update {
  sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y
}

# Configuration

# ssh: key
# zsh: oh my posh, profile, plugins, auto suggestions, history, syntax highlighting, .net tools path, test cert chain, update, omp theme

