#!/bin/sh
# https://github.com/creationix/nvm

# Install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash

# Source nvm.sh
[ -s "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh"

# Install latest node
nvm install node
