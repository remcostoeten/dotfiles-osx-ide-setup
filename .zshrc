# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme to powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Disable auto-update behavior
DISABLE_AUTO_UPDATE=true
DISABLE_UPDATE_PROMPT=true
DISABLE_COMPLETION_WAITING_DOTS=true

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Source the main injector from dotfiles
source "$HOME/development/dotfiles/main_injector.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Ensure p10k is loaded
if [[ -f ~/.p10k.zsh ]]; then
    source ~/.p10k.zsh
else
    echo "Warning: ~/.p10k.zsh not found. Run 'p10k configure' to create it."
fi
