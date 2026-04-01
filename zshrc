# Last updated: 2026-04-01

# This points to the Homebrew installation of asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Enable coloring in ls
alias ls="ls -G"

# Use Python3
# echo 'alias python=python3'

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

# Configures auto-complete for persona CLI tools.
#complete -F get_p_targets p
#function get_p_targets()
#{
#    COMPREPLY=(`p help -c "${COMP_WORDS[@]:1}"`)
#}
#

# Cong Custom Alias
alias c="claude --dangerously-skip-permissions --effort=high --model claude-opus-4-6"

# Custom Alias for Persona
alias start-rails="docker compose up -d"
alias stop-rails="docker compose stop"
alias ds="docker compose ps --format \"table {{.Name}}\t{{.Status}}\""
alias update-deps="docker compose run --no-deps --rm web /bin/bash -c 'bundle install && yarn'"
alias db-migrate="docker compose exec -- web rails db:migrate"
alias test-db-migrate="docker compose exec -- web rails db:migrate RAILS_ENV=test"
alias console-web="docker compose exec -- web /bin/bash"
alias console-rails="docker compose exec -- web rails console"

# Custom Alias for Git
alias gsync="git fetch origin master && git rebase origin/master && git push --force-with-lease"

export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
