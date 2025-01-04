#!/bin/bash
# Symlink various config files.

DOTFILES="
.profile
.tmux.conf
.gitconfig
.psqlrc
"
for file in $DOTFILES; do
  echo "Creating a symlink to $file in home directory."
  ln -sfn "./dotfiles/$file" ~/$(basename $file)
done

echo "Creating a symlink to nvim/init.vim in ~/.config"
mkdir -p ~/.config/nvim/
ln -sfn ~/dotfiles/.config/nvim/* ~/.config/nvim/

echo "Creating a symlink to alacritty/alacritty.yml in ~/.config"
mkdir -p ~/.config/alacritty/
ln -sfn ~/dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

echo "Creating a symlink to ghostty/config in ~/.config"
mkdir -p ~/.config/ghostty/
ln -sfn ~/dotfiles/.config/ghostty/config ~/.config/ghostty/config

echo ""; echo "All done!"
