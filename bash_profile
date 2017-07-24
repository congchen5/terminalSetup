# Enable coloring in ls
alias ls="ls -G"

# Show git branch in the command line
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Show the git branch when inside a git repository
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# Source the bash alias files if it exists
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi
