#!/bin/zsh

# Get the directory where this script is located
CURRENT_DIR="${0:A:h}"

# Source all alias files
for alias_file in "$CURRENT_DIR"/*.{zsh,sh}; do
    if [[ "$alias_file" != "$0" && -f "$alias_file" ]]; then  # Skip the injector itself
        source "$alias_file"
    fi
done 