#!/bin/zsh

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source all configuration files
for file in "$HOME/development/dotfiles/init"/*.zsh; do
    if [[ -f "$file" ]]; then
        source "$file"
    fi
done

# Source all plugin configurations
if [[ -f "$HOME/development/dotfiles/plugins/plugins_injector.sh" ]]; then
    source "$HOME/development/dotfiles/plugins/plugins_injector.sh"
fi

# Source all aliases
if [[ -f "$HOME/development/dotfiles/aliases/aliases_injector.sh" ]]; then
    source "$HOME/development/dotfiles/aliases/aliases_injector.sh"
fi

# Source all functions
if [[ -f "$HOME/development/dotfiles/functions/functions_injector.sh" ]]; then
    source "$HOME/development/dotfiles/functions/functions_injector.sh"
fi

# Source helper menu (but don't run it automatically)
if [[ -f "$HOME/development/dotfiles/helper_menu.sh" ]]; then
    source "$HOME/development/dotfiles/helper_menu.sh" >/dev/null 2>&1
fi

# Source Powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
