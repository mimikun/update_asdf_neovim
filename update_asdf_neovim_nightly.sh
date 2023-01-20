#!/bin/bash

OLD_VERSION=$(nvim --version | head -n 1 | tr " " "\n" | sed -n '2p')
VERSION=$(curl --silent https://api.github.com/repos/neovim/neovim/releases/tags/nightly | jq .body | tr " " "\n" | sed -n 2p | sed -e "s/\\\nBuild//g")

if [ "$OLD_VERSION" != "$VERSION" ]; then
  asdf uninstall neovim nightly
  asdf install neovim nightly
else
  echo "neovim (latest)nightly is already installed"
  echo "version: $VERSION"
fi
