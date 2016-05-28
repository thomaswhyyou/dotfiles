#!/bin/bash

DOTFILES=$(find ~/dotfiles -maxdepth 1 -type f -not \( -name ".gitmodules" -o -name ".gitignore" \) -name ".*")
for file in $DOTFILES; do
    echo "Creating symlink to '$file' in home directory."
    ln -sfn $file ~/$(basename $file)
done

# Vagrantfile
# VAGRANTFILE="$ORIGINDIR/Vagrantfile"
# if [[ (-f $VAGRANTFILE) && (-d "$HOME/.vagrant.d") ]]; then
#     echo "Creating symlink to '$VAGRANTFILE' in ~/.vagrant.d directory."
#     ln -sfn "$VAGRANTFILE" ~/.vagrant.d/$(basename $VAGRANTFILE)
# fi
