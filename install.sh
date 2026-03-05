#!/bin/sh

# Get the directory where this script lives
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Helper: backs up a file if it exists and is not already a symlink to our file
backup_and_link() {
    src="$1"
    dest="$2"

    # If dest is already a symlink pointing to src, skip
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        echo "  [skip] $dest already linked"
        return
    fi

    # Back up existing file
    if [ -e "$dest" ]; then
        echo "  [backup] $dest -> $dest.bak"
        mv "$dest" "$dest.bak"
    fi

    ln -sf "$src" "$dest"
    echo "  [link] $src -> $dest"
}

echo ""
echo "==> Linking config files..."
backup_and_link "$DOTFILES_DIR/vimrc"       "$HOME/.vimrc"
backup_and_link "$DOTFILES_DIR/tmux.conf"   "$HOME/.tmux.conf"
backup_and_link "$DOTFILES_DIR/zshrc"       "$HOME/.zshrc"

# vimrc sources ~/.vim/vimrc.bundles, so place it there
mkdir -p "$HOME/.vim"
backup_and_link "$DOTFILES_DIR/vimrc.bundles" "$HOME/.vim/vimrc.bundles"

echo ""
echo "==> Installing Vundle..."
VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"
if [ ! -d "$VUNDLE_DIR" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_DIR"
else
    echo "  [skip] Vundle already installed at $VUNDLE_DIR"
fi

echo ""
echo "==> Installing Vim plugins via Vundle..."
system_shell="$SHELL"
export SHELL="/bin/sh"
vim +PluginInstall +PluginClean! +qall
export SHELL="$system_shell"

echo ""
echo "==> Done!"
echo ""
echo "NOTE: iTerm2 preferences must be set up manually."
echo "  Open iTerm2 > Preferences > General > Preferences"
echo "  Check 'Load preferences from a custom folder or URL'"
echo "  Copy com.googlecode.iterm2.plist to that folder and restart iTerm2."
