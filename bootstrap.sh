#!/bin/bash

echo ""

ORIGINDIR="$HOME/dotfiles"
if [ ! -d "$ORIGINDIR" ]; then
    echo "~/dotfiles doesn't exist.. :("
    return 1
fi

# Make sure we have git submodules cloned too.
if hash git 2>/dev/null; then
    git -C $ORIGINDIR submodule update --init --recursive
else
    echo "You need to install git first. :("
    return 1
fi

# tmux plugin manager.
VENDORDIR="$ORIGINDIR/vendor"
if hash tmux 2>/dev/null; then
    if [[ -d "$VENDORDIR/tpm" ]]; then
        mkdir ~/.tmux/plugins
        echo "Creating symlink to '$VENDORDIR/tpm' *directory* in ~/.tmux/plugins directory."
        rm -rf ~/.tmux/plugins/tpm/
        ln -sfn $VENDORDIR/tpm ~/.tmux/plugins/tpm
    fi
fi

# Relevant dotfiles
DOTFILES=$(find ~/dotfiles -maxdepth 1 -type f -not \( -name ".gitmodules" \) -name ".*")
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
