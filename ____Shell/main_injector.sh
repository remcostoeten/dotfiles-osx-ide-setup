#!/bin/zsh

# -----------------------------------------------------------------------------
# File: Main Injector Script
# Author: Remco Stoeten
# Description: Main injector script for sourcing all other configuration scripts.
# -----------------------------------------------------------------------------
# Version: $(cat "$(pwd)/current-version.txt")
# Last Updated: $(cat "$(pwd)/last-updated.txt")
# -----------------------------------------------------------------------------
# Architecture:
# 1. Welcome Message: Displays a welcome message with the last update and version.
# 2. Helper Menu: Sources the helper_menu.sh script.
# 3. Injectors: Sources all injector scripts from the injectors directory.
# -----------------------------------------------------------------------------

# Source paths
source "$(pwd)/paths.sh"

# Source initialize injector
if [[ -f "$INJECTORS_DIR/initialize_injector.sh" ]]; then
    source "$INJECTORS_DIR/initialize_injector.sh"
fi

# Source welcome injector
if [[ -f "$INJECTORS_DIR/welcome_injector.sh" ]]; then
    source "$INJECTORS_DIR/welcome_injector.sh"
fi

# Source all other injectors
for injector in "$INJECTORS_DIR"/*.sh; do
    [[ "$injector" == *"initialize_injector.sh" ]] && continue
    [[ "$injector" == *"welcome_injector.sh" ]] && continue
    source "$injector"
done

# Source helper menu (but don't run it automatically)
if [[ -f "$DOTFILES_DIR/helper_menu.sh" ]]; then
    source "$DOTFILES_DIR/helper_menu.sh" >/dev/null 2>&1
fi

# Source Powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
