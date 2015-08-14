#!/bin/bash

ORIGINDIR="$HOME/dotfiles"
if [ ! -d "$ORIGINDIR" ]; then
    echo "~/dotfiles doesn't exist.. :("
    return 1
fi

DOTFILES=$(find ~/dotfiles -maxdepth 1 -type f -not \( -name ".gitmodules" \) -name ".*")

# Relevant dotfiles
echo ""
for file in $DOTFILES; do
    echo "Creating symlink to '$file' in home directory."
    ln -sfn $file ~/$(basename $file)
done

# Vagrantfile
VAGRANTFILE="$ORIGINDIR/Vagrantfile"
if [[ (-f $VAGRANTFILE) && (-d "$HOME/.vagrant.d") ]]; then
    echo "Creating symlink to '$VAGRANTFILE' in ~/.vagrant.d directory."
    ln -sfn "$VAGRANTFILE" ~/.vagrant.d/$(basename $VAGRANTFILE)
fi

echo ""; echo "All done. Yay :)"
