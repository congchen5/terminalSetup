# Cong's Terminal Setup

This is the collection of necessary files to set up Cong's working environment from scratch.

## Installation

```sh
git clone git@github.com:congchen5/terminalSetup.git
cd terminalSetup
./install.sh
```

The install script copies all config files into `~/` as dotfiles (e.g. `zshrc` → `~/.zshrc`), backing up any existing files to `*.bak`. It also installs Vim plugins via Vundle.

## Files

| File | Destination | Description |
|------|-------------|-------------|
| `bash_profile` | `~/.bash_profile` | Bash prompt with git branch, ls coloring |
| `gitconfig` | `~/.gitconfig` | Git LFS filter configuration |
| `tmux.conf` | `~/.tmux.conf` | Tmux config (C-a prefix, vim-style pane navigation, solarized status bar) |
| `vimrc` | `~/.vimrc` | Vim config (solarized theme, NERDTree, split navigation) |
| `vimrc.bundles` | `~/.vim/vimrc.bundles` | Vundle plugin list |
| `zprofile` | `~/.zprofile` | Homebrew and OrbStack shell init |
| `zshrc` | `~/.zshrc` | Zsh config (asdf, git branch prompt, custom aliases) |

## iTerm2

The `com.googlecode.iterm2.plist` file contains the iTerm2 profile (Solarized theme). This must be set up manually:

1. Open iTerm2 > Preferences > General > Preferences
2. Check "Load preferences from a custom folder or URL"
3. Copy `com.googlecode.iterm2.plist` to that folder and restart iTerm2
