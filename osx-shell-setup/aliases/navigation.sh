# Base development directory paths
export WERK_DEV_DIR='~/dev'
export PRIVE_DEV_DIR='~/development'

# Project-specific paths
export WERK="${WERK_DEV_DIR}/projects"
export BOUW="${WERK_DEV_DIR}/projects/Boouw7"
export TOOL="${WERK_DEV_DIR}/projects/Toolbox"
export TOOLBOX="${WERK_DEV_DIR}/projects/Toolbox"

# Directory traversal shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'

# Project navigation aliases
alias werk="cd ${WERK}"
alias bouw="cd ${BOUW}"
alias tool="cd ${TOOL}/devtools"
alias toolbox="cd ${TOOLBOX}/devtools"

# System directory shortcuts
alias downloads='cd ~/Downloads'
alias desktop='cd ~/Desktop'
alias documents='cd ~/Documents'
alias music='cd ~/Music'
alias pictures='cd ~/Pictures'
alias videos='cd ~/Videos'
