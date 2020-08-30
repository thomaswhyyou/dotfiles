#!/bin/bash

# Symlink various config files

DOTFILES="
.commonrc
.tmux.conf
.gitconfig
.psqlrc
"

for file in $DOTFILES; do
  echo "Creating a symlink to $file in home directory."
  ln -sfn "./dotfiles/$file" ~/$(basename $file)
done

echo "Creating a symlink to nvim/init.vim in .config directory."
mkdir -p ~/.config/nvim/
ln -sfn ~/dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim

echo ""; echo "All done!"
