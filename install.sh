#!/usr/bin/env sh

set -eu

backup_and_link() {
    src="$1"
    dest="$2"

    if [ -L "$dest" ]; then
        echo "Removing symlink $dest"
        rm "$dest"
    elif [ -e "$dest" ]; then
        echo "File $dest already exists and will be backed up to $dest.bak"
        mv "$dest" "$dest.bak"
    fi

    echo "Creating symlink $dest → $src"
    ln -s "$src" "$dest"
    echo
}

backup_and_link "$(pwd)/.gitconfig" "$HOME/.gitconfig"
backup_and_link "$(pwd)/.gitignore" "$HOME/.gitignore"
backup_and_link "$(pwd)/.gitconfig.user" "$HOME/.gitconfig.user"

backup_and_link "$(pwd)/.editorconfig" "$HOME/.editorconfig"

backup_and_link "$(pwd)/.npmrc" "$HOME/.npmrc"
backup_and_link "$(pwd)/.yarnrc.yml" "$HOME/.yarnrc.yml"
backup_and_link "$(pwd)/bunfig.toml" "$HOME/.bunfig.toml"

config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
mkdir -p "$config_home/uv" "$config_home/pip"

backup_and_link "$(pwd)/.config/uv/uv.toml" "$config_home/uv/uv.toml"
backup_and_link "$(pwd)/.config/pip/pip.conf" "$config_home/pip/pip.conf"
