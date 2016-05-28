#!/bin/bash

echo ""

ORIGINDIR="$HOME/dotfiles"
if [ ! -d "$ORIGINDIR" ]; then
    echo "~/dotfiles doesn't exist.. :("
    return 1
fi

# # Make sure we have git submodules cloned too.
# if hash git 2>/dev/null; then
#     git -C $ORIGINDIR submodule update --init --recursive
#     echo ""
# else
#     echo "You need to install git first. :("
#     return 1
# fi

# Ensure .bashrc exists even if blank
BASHRC_FILE="$HOME/.bashrc"
if [[ ! -f "$BASHRC_FILE" ]]; then
    touch "$BASHRC_FILE"
fi

# Relevant dotfiles
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

# vim install
VIM_INSTALL_SCRIPT="$HOME/dotfiles/scripts/build-vim-from-source.sh"
if [[ -f "$VIM_INSTALL_SCRIPT" ]] && [[ "$OSTYPE" == "linux-gnu" ]]; then
    . "$VIM_INSTALL_SCRIPT"
fi

# zshell install
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    chsh -s /bin/zsh
fi

. ~/dotfiles/scripts/tmux-setup-session-default.sh

echo ""; echo "All done. Yay :)"
