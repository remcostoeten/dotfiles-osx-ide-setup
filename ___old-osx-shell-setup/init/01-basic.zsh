# Basic ZSH Configuration
# @author Remco Stoeten
# @description Core ZSH settings and options for better shell experience

# History Configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format
setopt SHARE_HISTORY            # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST   # Expire a duplicate event first when trimming history
setopt HIST_IGNORE_DUPS         # Do not record an event that was just recorded again
setopt HIST_IGNORE_ALL_DUPS     # Delete an old recorded event if a new event is a duplicate
setopt HIST_FIND_NO_DUPS        # Do not display a previously found event
setopt HIST_SAVE_NO_DUPS        # Do not write a duplicate event to the history file
setopt HIST_VERIFY              # Do not execute immediately upon history expansion

# Directory Navigation
setopt AUTO_CD                  # If a command is issued that can't be executed as a normal command,
                               # and the command is the name of a directory, perform the cd command to that directory
setopt AUTO_PUSHD              # Make cd push the old directory onto the directory stack
setopt PUSHD_IGNORE_DUPS       # Don't push multiple copies of the same directory onto the directory stack
setopt PUSHD_MINUS             # Exchanges the meanings of '+' and '-' when used with a number to specify a directory in the stack

# Completion
setopt COMPLETE_IN_WORD        # Complete from both ends of a word
setopt ALWAYS_TO_END           # Move cursor to the end of a completed word
setopt PATH_DIRS               # Perform path search even on command names with slashes
setopt AUTO_MENU              # Show completion menu on a successive tab press
setopt AUTO_LIST              # Automatically list choices on ambiguous completion
setopt AUTO_PARAM_SLASH       # If completed parameter is a directory, add a trailing slash
setopt NO_COMPLETE_ALIASES    # Don't expand aliases _before_ completion has finished

# Correction
setopt CORRECT                # Try to correct the spelling of commands
setopt CORRECT_ALL           # Try to correct the spelling of all arguments in a line

# Input/Output
setopt INTERACTIVE_COMMENTS    # Allow comments even in interactive shells
setopt NO_CLOBBER            # Don't overwrite existing files with > and >>
                            # Use >! and >>! to bypass
setopt NO_FLOW_CONTROL       # Disable start/stop characters in shell editor

# Job Control
setopt LONG_LIST_JOBS        # List jobs in the long format by default
setopt AUTO_RESUME          # Attempt to resume existing job before creating a new process
setopt NOTIFY              # Report status of background jobs immediately

# Expansion and Globbing
setopt EXTENDED_GLOB        # Treat #, ~, and ^ as part of patterns for filename generation
setopt GLOB_DOTS           # Include dotfiles in globbing
setopt NUMERIC_GLOB_SORT   # Sort filenames numerically when it makes sense

# Input/Output
setopt NO_BEEP             # Don't beep on error
setopt PRINT_EXIT_VALUE    # Print exit value if non-zero
setopt RM_STAR_WAIT       # Wait 10 seconds before executing 'rm *'

# Shell State
setopt NO_HUP             # Don't kill background jobs when shell exits

# Editor
export EDITOR='vim'       # Set default editor to vim
export VISUAL='vim'       # Set default visual editor to vim

# Default permissions: rwxr-xr-x for directories, rw-r--r-- for files
umask 022

# Load colors for use in prompts and elsewhere
autoload -U colors && colors

# Enable command substitution in prompt
setopt PROMPT_SUBST

# Ensure path arrays don't contain duplicates
typeset -U path PATH

# Add common directories to PATH if they exist
[[ -d /usr/local/bin ]] && path=(/usr/local/bin $path)
[[ -d /usr/local/sbin ]] && path=(/usr/local/sbin $path)
[[ -d $HOME/.local/bin ]] && path=($HOME/.local/bin $path)
[[ -d $HOME/bin ]] && path=($HOME/bin $path)

# Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Node Version Manager (nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load nvm bash_completion

# Rust/Cargo
[[ -f $HOME/.cargo/env ]] && source $HOME/.cargo/env

# Python poetry
[[ -d $HOME/.poetry/bin ]] && path=($HOME/.poetry/bin $path)

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
[[ -d $PNPM_HOME ]] && path=($PNPM_HOME $path)

# Golang
export GOPATH="$HOME/go"
[[ -d $GOPATH/bin ]] && path=($GOPATH/bin $path)

# Export the final PATH
export PATH
