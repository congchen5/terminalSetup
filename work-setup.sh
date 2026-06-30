#!/usr/bin/env bash
#
# Sets up a tmux "work" session with paired windows for each persona-web worktree.
# Each pair: one shell window + one Claude Code window, both cd'd into the directory.

SESSION="work"
BASE_DIR="$HOME/persona"

# Check if session already exists
if tmux has-session -t "$SESSION" 2>/dev/null; then
  echo "tmux session '$SESSION' already exists. Attaching..."
  exec tmux attach-session -t "$SESSION"
fi

# Find all persona-web directories, sorted naturally
dirs=()
for d in "$BASE_DIR"/persona-web "$BASE_DIR"/persona-web-[0-9]*; do
  [ -d "$d" ] && dirs+=("$d")
done

if [ ${#dirs[@]} -eq 0 ]; then
  echo "No persona-web directories found in $BASE_DIR"
  exit 1
fi

# Create session with the first directory's shell window
first_dir="${dirs[0]}"
first_name="$(basename "$first_dir")"
tmux new-session -d -s "$SESSION" -n "$first_name" -c "$first_dir"

# Create the Claude Code window for the first directory
tmux new-window -t "$SESSION" -n "${first_name}-cc" -c "$first_dir"
tmux send-keys -t "$SESSION" "c" Enter

# Create paired windows for remaining directories
for ((i = 1; i < ${#dirs[@]}; i++)); do
  dir="${dirs[$i]}"
  name="$(basename "$dir")"

  # Shell window
  tmux new-window -t "$SESSION" -n "$name" -c "$dir"

  # Claude Code window
  tmux new-window -t "$SESSION" -n "${name}-cc" -c "$dir"
  tmux send-keys -t "$SESSION" "c" Enter
done

# Select the first window
tmux select-window -t "$SESSION:1"

# Attach to the session
exec tmux attach-session -t "$SESSION"
