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
ln -sfn ~/dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim

echo "Creating a symlink to wezterm/wezterm.lua in .config directory."
mkdir -p ~/.config/wezterm/
ln -sfn ~/dotfiles/.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua

echo "Creating a symlink to alacritty/alacritty.yml in .config directory."
mkdir -p ~/.config/alacritty/
ln -sfn ~/dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

echo ""; echo "All done!"
