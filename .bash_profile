# Reference:
# http://natelandau.com/my-mac-osx-bash_profile/ (mostly copied from here)
# https://gist.github.com/phlco/6670713          (..and here)
# http://www.linuxquestions.org/questions/linux-general-1/ultimate-prompt-and-bashrc-file-4175518169/
# https://gist.github.com/thomaswhyyou/8907953
# http://www.ibm.com/developerworks/linux/library/l-tip-prompt/
# http://cli.learncodethehardway.org/bash_cheat_sheet.pdf
# http://ss64.com/bash/syntax-prompt.html
# https://dougbarton.us/Bash/Bash-prompts.html
# http://jilles.me/badassify-your-terminal-and-shell/   (zsh)

#   -------------------------------
#   0.  BASH IMPORTS
#   -------------------------------
# if running bash
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    # include .bashrc if it exists
    # http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
    . "$HOME/.bashrc"
  fi

  if [ -f "$HOME/.bash_include" ]; then
    # include .bash_include if it exists
    . "$HOME/.bash_include"
  fi
fi


#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION (FOR BASH)
#   -------------------------------

# Prefer US English
export LC_ALL="en_US.UTF-8"
# use UTF-8
export LANG="en_US"
# Add colors to LS (http://geoff.greer.fm/lscolors/)
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad # BSD
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:' # Linux (color '40' dropped to use solarized iterm theme)
export GREP_OPTIONS='--color=auto'
# Set Default Editor (change 'Nano' to the editor of your choice)
export EDITOR=vim
export VISUAL=vim
# Set default blocksize for ls, df, du
# from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
export BLOCKSIZE=1k
# turn off flow control characters, that way we can use ctrl+q & ctrl+s bindings
stty -ixon -ixoff

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

## History
# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
# Causes bash to append to history instead of overwriting it so if you start a
# new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

## Tab improvements
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
# bind 'TAB: menu-complete'

## Colors for the prompt
# Set the TERM var to xterm-256color
# if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
#   export TERM=gnome-256color
# elif infocmp xterm-256color >/dev/null 2>&1; then
#   export TERM=xterm-256color
# fi

if tput setaf 1 &> /dev/null; then
  tput sgr0
  if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
    # this is for xterm-256color
    BLACK=$(tput setaf 0)
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 226)
    BLUE=$(tput setaf 4)
    MAGENTA=$(tput setaf 5)
    CYAN=$(tput setaf 6)
    WHITE=$(tput setaf 7)
    ORANGE=$(tput setaf 172)
    GREEN=$(tput setaf 190)
    PURPLE=$(tput setaf 141)
    BG_BLACK=$(tput setab 0)
    BG_RED=$(tput setab 1)
    BG_GREEN=$(tput setab 2)
    BG_BLUE=$(tput setab 4)
    BG_MAGENTA=$(tput setab 5)
    BG_CYAN=$(tput setab 6)
    BG_YELLOW=$(tput setab 226)
    BG_ORANGE=$(tput setab 172)
    BG_WHITE=$(tput setab 7)
  else
    MAGENTA=$(tput setaf 5)
    ORANGE=$(tput setaf 4)
    GREEN=$(tput setaf 2)
    PURPLE=$(tput setaf 1)
    WHITE=$(tput setaf 7)
  fi
  BOLD=$(tput bold)
  RESET=$(tput sgr0)
  UNDERLINE=$(tput sgr 0 1)
else
  BLACK="\[\e[0;30m\]"
  RED="\033[1;31m"
  ORANGE="\033[1;33m"
  GREEN="\033[1;32m"
  PURPLE="\033[1;35m"
  WHITE="\033[1;37m"
  YELLOW="\[\e[0;33m\]"
  CYAN="\[\e[0;36m\]"
  BLUE="\[\e[0;34m\]"
  BOLD=""
  RESET="\033[m"
fi

## Long git to show + ? !
is_git_repo() {
    $(git rev-parse --is-inside-work-tree &> /dev/null)
}
is_git_dir() {
    $(git rev-parse --is-inside-git-dir 2> /dev/null)
}
get_git_branch() {
    local branch_name
    # Get the short symbolic ref
    branch_name=$(git symbolic-ref --quiet --short HEAD 2> /dev/null) ||
    # If HEAD isn't a symbolic ref, get the short SHA
    branch_name=$(git rev-parse --short HEAD 2> /dev/null) ||
    # Otherwise, just give up
    branch_name="(unknown)"
    printf $branch_name
}
# Git status information
prompt_git() {
    local git_info git_state uc us ut st
    if ! is_git_repo || is_git_dir; then
        return 1
    fi
    git_info=$(get_git_branch)
    # Check for uncommitted changes in the index
    if ! $(git diff --quiet --ignore-submodules --cached); then
        uc="+"
    fi
    # Check for unstaged changes
    if ! $(git diff-files --quiet --ignore-submodules --); then
        us="!"
    fi
    # Check for untracked files
    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        ut="?"
    fi
    # Check for stashed files
    if $(git rev-parse --verify refs/stash &>/dev/null); then
        st="$"
    fi
    git_state=$uc$us$ut$st
    # Combine the branch name and state information
    if [[ $git_state ]]; then
        git_info="$git_info${RESET}($git_state${RESET})"
    fi
    printf "${WHITE} on ${style_branch}${git_info}"
}

## style the prompt
style_local="\[${RESET}${WHITE}\]"
style_remote="\[${RESET}${YELLOW}\]"
style_path="\[${RESET}${CYAN}\]"
style_branch="${RED}"
style_chars="\[${RESET}${WHITE}\]"
style_prompt="\[${RESET}${BLUE}\]"

## Build the prompt
PS1="\n"
if [ -n "$SSH_CLIENT" ]; then
    PS1+="${style_remote}\u "
    PS1+="${style_chars}at ${style_remote}\h ${style_chars}in "
# else
#     PS1+="${style_local}\u "${style_chars}in "
fi

PS1+="${style_path}\w"

if command -v git >/dev/null 2>&1; then
    PS1+="\$(prompt_git)"
fi

# https://mkaz.github.io/2014/04/17/the-bash-prompt/
# http://unicode-table.com/
PS1+="\n"
if [ -n "$SSH_CLIENT" ]; then
    PS1+="${style_prompt}> \[${RESET}\]"
else
    PS1+="${style_prompt}❂ \[${RESET}\]"
fi


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi


#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
#   lr:  Full Recursive Directory Listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias 1='cd ../'                           # Go back 1 directory level
alias 2='cd ../../'                        # Go back 2 directory levels
alias 3='cd ../../../'                     # Go back 3 directory levels
alias 4='cd ../../../../'                  # Go back 4 directory levels
alias 5='cd ../../../../../'               # Go back 5 directory levels
alias 6='cd ../../../../../../'            # Go back 6 directory levels
alias edit='vim'                            # edit:         Opens any file in vim
alias vi='vim'                              # edit:         map vi -> vim
alias em='emacs'
alias ~="cd ~"                              # ~:            Go Home
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
# alias show_options='shopt'                  # Show_options: display bash options settings
# alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
# mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
# trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
# ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
# alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
mans () {
    man $1 | grep -iC2 --color=always $2 | less
}


#   -------------------------------
#   3.  FILE AND FOLDER MANAGEMENT
#   -------------------------------

zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)

# extract:  Extract most known archives with one command
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string


# Searches for text in all files in the current folder
ftext ()
{
    # -i case-insensitive
    # -I ignore binary files
    # -H causes filename to be printed
    # -r recursive search
    # -n causes line number to be printed
    # optional: -F treat search term as a literal, not a regular expression
    # optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
    grep -iIHrn --color=always "$1" . | less -r
}

#   ---------------------------
#   5.  PROCESS MANAGEMENT
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
alias memhogstop='top -l 1 -o rsize | head -20'
alias memhogsps='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
alias cpuhogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
alias topforever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
myps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }


#   ---------------------------
#   6.  NETWORKING
#   ---------------------------

alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netcons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushdns='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipinfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipinfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openports='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showblocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
ii() {
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Current network location :$NC " ; scselect
    echo -e "\n${RED}Public facing IP Address :$NC " ;myip
    aecho -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
    echo
}


#   ---------------------------------------
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

alias mountreadwrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

#   cleanupDS:  Recursively delete .DS_Store files
alias cleanupds="find . -type f -name '*.DS_Store' -ls -delete"


#   ---------------------------------------
#   10.  APPLICATION SPECIFIC
#   ---------------------------------------

## Shortcuts
if [ -d ~/Dropbox/Code ]; then
    alias code='cd ~/Dropbox/Code'
fi
if [ -d ~/work ]; then
    alias work='cd ~/work'
fi

## autoenv
if hash activate.sh 2>/dev/null; then
    . activate.sh
fi

## tmux
if hash tmux 2>/dev/null; then
    alias tls='tmux ls'
    alias tat='tmux attach -t'
    alias tns='tmux new-session -s'
    alias tks='tmux kill-session -t'
fi

## Spring related -> core product.
if [ -f "$HOME/.secret" ]; then
    . "$HOME/.secret"

    export OPSWORKS_NAME="tyu"

    export GOPATH="$HOME/code/go:$(brew --prefix go)/libexec"
    export PATH=${GOPATH[@]//:/\/bin:}/bin:$PATH

    export RBENV_ROOT="$HOME/.rbenv"
    export PATH="$RBENV_ROOT/bin:$PATH"
    if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

    export GOPATH="$GOPATH:$HOME/code/branded/go"
    export PATH="$HOME/code/branded/go/bin:$PATH"

    export PATH="$HOME/code/arcanist/bin:$PATH"
fi

## Spring related -> atlas
if [ -f "$HOME/.atlas-secrets" ]; then
    . "$HOME/.atlas-secrets"
fi
