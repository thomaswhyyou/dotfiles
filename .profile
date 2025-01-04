# vim: filetype=sh
# Source this file in .zshrc after installing zsh + prezto.

# Aliases (https://natelandau.com/my-mac-osx-bash_profile)
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias which='type -a'                       # which: Find executables
alias path='echo -e ${PATH//:/\\n}'         # path: Echo all executable Paths
alias ..2='cd ../../'                       # Go back 2 directory levels
alias ..3='cd ../../../'                    # Go back 3 directory levels
alias ..4='cd ../../../../'                 # Go back 4 directory levels
alias ..5='cd ../../../../../'              # Go back 5 directory levels
alias ..6='cd ../../../../../../'           # Go back 6 directory levels

# Set default editor
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

# neovim
if hash nvim 2>/dev/null; then
  alias vim='nvim'
  alias vi='nvim'
  export EDITOR=nvim
  export VISUAL=nvim
fi

# tmux
if hash tmux 2>/dev/null; then
  alias tls='tmux ls'
  alias tat='tmux attach -d -t'
  alias tns='tmux new-session -s'
  alias tks='tmux kill-session -t'

  # Make sure we detach first if we are already inside tmux.
  if [[ "$TERM" == "tmux-255color" ]]; then
    tmux detach
  fi

  # Set up a default session called 'one' if not exist
  if ! tmux has-session -t one > /dev/null 2>&1; then
    tmux new -s one -n one -d
  fi
fi

# fzf
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

# homebrew
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# asdf
if [[ -f /opt/homebrew/bin/asdf ]]; then
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

# elixir & erlang
export ERL_AFLAGS="-kernel shell_history enabled"
