echo 'alias python=python3'

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Enable coloring in ls
alias ls="ls -G"

# Show git branch in the command line
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Set the Zsh prompt (optimized for Zsh)
# %n = user, %m = host, %1~ = current folder
setopt PROMPT_SUBST  # This line is required to make the function run in the prompt
PROMPT='%n@%m %1~%F{green}$(parse_git_branch)%f $ '

# Source the bash alias files if it exists
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi
