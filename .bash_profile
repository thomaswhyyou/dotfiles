#   -------------------------------
#   0.  BASH IMPORTS
#   -------------------------------
# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  # http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi

  # include .bash_include if it exists
  if [ -f "$HOME/.bash_include" ]; then
    . "$HOME/.bash_include"
  fi
fi

# include .commonrc if it exists
if [ -f "$HOME/.commonrc" ]; then
  . "$HOME/.commonrc"
fi

#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION (BASH ONLY)
#   -------------------------------

## Tab improvements
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'

# Causes bash to append to history instead of overwriting it so if you start a
# new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

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
