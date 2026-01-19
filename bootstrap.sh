#!/bin/bash
# Symlink various config files.

DOTFILES="
.profile
.tmux.conf
.gitconfig
.psqlrc
.tool-versions
"
for file in $DOTFILES; do
  echo "Creating a symlink to $file in home directory"
  ln -sfn "./dotfiles/$file" ~/$(basename $file)
done

echo "Creating a symlink at ~/.config/ghostty"
ln -sfn ~/dotfiles/.config/ghostty ~/.config/ghostty

echo "Creating a symlink at ~/.config/nvim"
ln -sfn ~/dotfiles/.config/nvim ~/.config/nvim

ZSHRC="$HOME/.zshrc"
echo "Setting up $ZSHRC"

if touch $ZSHRC && ! grep -Fxq "source ~/.profile" "$ZSHRC"; then
  echo "" >> "$ZSHRC"
  echo "# Set by $(readlink -f "$0") on $(date +%F)." >> "$ZSHRC"
  echo "source ~/.profile" >> "$ZSHRC"
fi

echo ""; echo "All done!"
