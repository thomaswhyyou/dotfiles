#!/bin/bash

ORIGINDIR="$HOME/dotfiles"
if [ ! -d "$ORIGINDIR" ]; then
    echo "~/dotfiles doesn't exist.. :("
    return 1
fi

DOTFILES=$(find ~/dotfiles -type f -maxdepth 1 -not \( -name ".gitmodules" \) -name ".*")

echo ""
for file in $DOTFILES; do
    echo "Creating symlink to '$file' in home directory."
    ln -sfn $file ~/$(basename $file)
done

VAGRANTFILE="$ORIGINDIR/Vagrantfile"
if [[ (-f $VAGRANTFILE) && (-d "$HOME/.vagrant.d") ]]; then
    echo "Creating symlink to '$VAGRANTFILE' in ~/.vagrant.d directory."
    ln -sfn "$ORIGINDIR/Vagrantfile" ~/.vagrant.d
fi

if [ -f ~/.bash_profile ]; then
   source ~/.bash_profile
fi

echo ""; echo "All done. Yay :)"
