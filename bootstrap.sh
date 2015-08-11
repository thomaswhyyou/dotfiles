#!/bin/bash

ORIGINDIR=~/dotfiles
if [ ! -d "$ORIGINDIR" ]; then
    echo "~/dotfiles doesn't exist.. :("
    return 1
fi
DOTFILES=$(find $ORIGINDIR -type f -name ".*")

echo ""
for file in $DOTFILES; do
    echo "Creating symlink to '$file' in home directory."
    ln -s -f -n $file ~/$(basename $file)
done

if [ -f ~/.bash_profile ]; then
   source ~/.bash_profile
fi

echo ""; echo "All done. Yay :)"
