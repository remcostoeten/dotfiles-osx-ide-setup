#!/bin/zsh

# Define base directory
DOTFILES_DIR="$(pwd)"

# Increment version
version_file="$DOTFILES_DIR/current-version.txt"
last_updated_file="$DOTFILES_DIR/last-updated.txt"

if [[ -f "$version_file" ]]; then
    version=$(cat "$version_file")
    new_version=$(echo "$version + 0.1" | bc)
    echo "$new_version" > "$version_file"
else
    echo "0.1" > "$version_file"
fi

# Update last updated date
date +"%Y-%m-%d %H:%M:%S" > "$last_updated_file"
