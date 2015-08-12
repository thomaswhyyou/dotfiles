#!/bin/bash

ORIGINDIR="$HOME/dotfiles"
if [ ! -d "$ORIGINDIR" ]; then
    echo "~/dotfiles doesn't exist.. :("
    return 1
fi

DOTFILES=$(find ~/dotfiles -type f -maxdepth 1 -not \( -name ".gitmodules" \) -name ".*")

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

# dircolors-solarized for .dircolors
DIRCOLORS="$ORIGINDIR/vendor/dircolors-solarized/dircolors.ansi-universal"
if [[ (-f $DIRCOLORS) ]]; then
    mkdir -p ~/.dircolors
    echo "Creating symlink to '$DIRCOLORS' in ~/.dircolors directory."
    ln -sfn "$DIRCOLORS" ~/.dircolors/$(basename $DIRCOLORS)
fi

if [ -f ~/.bash_profile ]; then
   source ~/.bash_profile
fi

echo ""; echo "All done. Yay :)"
