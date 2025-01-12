# System aliases for ZSH configuration
# These aliases provide quick access to common ZSH configuration tasks

# Help and Configuration Menu
alias help='source "${ZSH_SETUP_PATH}/helper_menu.sh" --help'
alias zshhelp='source "${ZSH_SETUP_PATH}/helper_menu.sh" --help'
alias config='source "${ZSH_SETUP_PATH}/helper_menu.sh" --config'
alias zshconfig='source "${ZSH_SETUP_PATH}/helper_menu.sh" --config'
alias zshcfg='source "${ZSH_SETUP_PATH}/helper_menu.sh" --config'
alias aliasconfig='source "${ZSH_SETUP_PATH}/helper_menu.sh" --config'

# Quick access to configuration files
alias zshrc='${EDITOR:-vim} ~/.zshrc'
alias zshalias='cd "${ZSH_SETUP_PATH}/aliases" && ${EDITOR:-vim} .'
alias zshfunc='cd "${ZSH_SETUP_PATH}/functions" && ${EDITOR:-vim} .'  

alias zsh='vim ~/.zshrc'
alias szsh='source ~/.zshrc'
alias czsh='source ~/.zshrc'