#!/bin/bash

set -e

DOTFILES=~/dotfiles

link() {
    local src="$1"
    local dest="$2"

    # Ensure parent directory exists
    mkdir -p "$(dirname "$dest")"

    # Already correctly symlinked
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        echo "  ✓ $dest (already linked)"
        return
    fi

    # Something exists at the destination
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "  ! $dest already exists"
        if [ -L "$dest" ]; then
            echo "    (symlink -> $(readlink "$dest"))"
        elif [ -f "$dest" ]; then
            echo "    (regular file)"
        elif [ -d "$dest" ]; then
            echo "    (directory)"
        fi

        read -p "    Overwrite? Existing file will be backed up to ${dest}_backup [y/N] " answer
        if [[ ! "$answer" =~ ^[Yy]$ ]]; then
            echo "    Skipped."
            return
        fi

        # Remove old backup if it exists, then backup current
        rm -rf "${dest}_backup"
        mv "$dest" "${dest}_backup"
        echo "    Backed up to ${dest}_backup"
    fi

    ln -s "$src" "$dest"
    echo "  ✓ $dest -> $src"
}

echo "Setting up dotfiles symlinks..."
echo ""

echo "i3:"
link "$DOTFILES/i3_config"            ~/.config/i3/config
link "$DOTFILES/i3blocks.conf"        ~/.config/i3/i3blocks.conf

echo ""
echo "Neovim:"
link "$DOTFILES/init.lua"             ~/.config/nvim/init.lua

echo ""
echo "Fish:"
link "$DOTFILES/config.fish"          ~/.config/fish/config.fish

echo ""
echo "Ghostty:"
link "$DOTFILES/ghostty_config"       ~/.config/ghostty/config
link "$DOTFILES/ghostty_tab-style.css" ~/.config/ghostty/tab-style.css

echo ""
echo "Tmux:"
link "$DOTFILES/tmux.conf"            ~/.tmux.conf

echo ""
echo "Done!"
