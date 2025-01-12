#!/bin/zsh

# Get the directory where this script is located
CURRENT_DIR="${0:A:h}"

# Enable Powerlevel10k instant prompt if it exists
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source all initialization files in numerical order
for init_file in "$CURRENT_DIR"/[0-9][0-9]-*.zsh(n); do
    if [ -f "$init_file" ]; then
        source "$init_file"
    fi
done 