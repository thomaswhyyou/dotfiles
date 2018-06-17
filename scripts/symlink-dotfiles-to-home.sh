#!/bin/bash

DOTFILES="
.agignore
.commonrc
.gitconfig
.psqlrc
.tmux.conf
.zshrc
"

for file in $DOTFILES; do
	echo "Creating a symlink to '$file' in home directory."
	ln -sfn "./dotfiles/$file" ~/$(basename $file)
done

echo "Creating a symlink to nvim/init.vim in .config directory."
mkdir -p ~/.config/nvim/
ln -sfn ~/dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim

# DOTFILES=$(find ~/dotfiles -maxdepth 1 -type f -not \( -name ".gitmodules" -o -name ".gitignore" \) -name ".*")
# for file in $DOTFILES; do
#     echo "Creating symlink to '$file' in home directory."
#     ln -sfn $file ~/$(basename $file)
# done

# Vagrantfile
# VAGRANTFILE="$ORIGINDIR/Vagrantfile"
# if [[ (-f $VAGRANTFILE) && (-d "$HOME/.vagrant.d") ]]; then
#     echo "Creating symlink to '$VAGRANTFILE' in ~/.vagrant.d directory."
#     ln -sfn "$VAGRANTFILE" ~/.vagrant.d/$(basename $VAGRANTFILE)
# fi
