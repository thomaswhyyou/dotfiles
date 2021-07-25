#!/bin/bash

# Symlink various config files.

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
ln -sfn ~/dotfiles/.config/nvim/* ~/.config/nvim/

echo "Creating a symlink to alacritty/alacritty.yml in .config directory."
mkdir -p ~/.config/alacritty/
ln -sfn ~/dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

echo ""; echo "All done!"
