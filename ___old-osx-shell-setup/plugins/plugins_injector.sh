#!/bin/zsh

# Get the directory where this script is located
CURRENT_DIR="${0:A:h}"

# Install plugins if they don't exist
function install_plugin() {
    local plugin_name=$1
    local plugin_url=$2
    local plugin_path="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin_name"
    
    if [[ ! -d "$plugin_path" ]]; then
        echo "Installing $plugin_name..."
        git clone --depth=1 "$plugin_url" "$plugin_path"
    fi
}

# Install custom plugins
install_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
install_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting"

# Configure plugins
plugins=(
    git                     # Git aliases and functions
    zsh-autosuggestions     # Fish-like autosuggestions
    zsh-syntax-highlighting # Fish-like syntax highlighting
    z                      # Jump to directories with 'z'
    docker                 # Docker completions and aliases
    npm                    # NPM completions and aliases
    node                   # Node.js completions and aliases
    brew                   # Homebrew completions and aliases
    macos                  # macOS specific aliases
    vscode                 # VSCode aliases
)

# Source each plugin
for plugin in $plugins; do
    plugin_path="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin/$plugin.plugin.zsh"
    builtin_path="$ZSH/plugins/$plugin/$plugin.plugin.zsh"
    
    if [[ -f "$plugin_path" ]]; then
        source "$plugin_path"
    elif [[ -f "$builtin_path" ]]; then
        source "$builtin_path"
    fi
done 