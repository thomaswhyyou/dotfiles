#!/bin/bash

echo ""

ORIGINDIR="$HOME/dotfiles"
if [ ! -d "$ORIGINDIR" ]; then
    echo "~/dotfiles doesn't exist.. :("
    return 1
fi

# Ensure .bashrc exists even if blank
BASHRC_FILE="$HOME/.bashrc"
if [[ ! -f "$BASHRC_FILE" ]]; then
    touch "$BASHRC_FILE"
fi

# Ensure .zshrc exists even if blank
ZSHRC_FILE="$HOME/.zshrc"
if [[ ! -f "$ZSHRC_FILE" ]]; then
    touch "$ZSHRC_FILE"
fi

# vim install
VIM_INSTALL_SCRIPT="$HOME/dotfiles/scripts/build-vim-from-source.sh"
if [[ -f "$VIM_INSTALL_SCRIPT" ]] && [[ "$OSTYPE" == "linux-gnu" ]]; then
    . "$VIM_INSTALL_SCRIPT"
fi

# zshell zprezto install (assumes zsh is already installed)
if [ ! -d "$HOME/.zprezto" ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

# Symlink relevant dotfiles
. ~/dotfiles/scripts/symlink-dotfiles-to-home.sh

echo ""; echo "All done. Yay :)"
