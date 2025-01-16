#!/bin/bash

ZSH_SETUP_PATH="$(pwd)"

# Color definitions with proper ANSI codes
RED=$'\e[1;31m'
GREEN=$'\e[1;32m'
YELLOW=$'\e[1;33m'
BLUE=$'\e[1;34m'
MAGENTA=$'\e[1;35m'
CYAN=$'\e[1;36m'
GRAY=$'\e[0;90m'
ORANGE=$'\e[38;5;208m'
PURPLE=$'\e[38;5;141m'
PINK=$'\e[38;5;211m'
WHITE=$'\e[1;37m'
NC=$'\e[0m'
BOLD=$'\e[1m'
UNDERLINE=$'\e[4m'
ITALIC=$'\e[3m'
DIM=$'\e[2m'

# Box drawing characters
TOP_LEFT="╭"
TOP_RIGHT="╮"
BOTTOM_LEFT="╰"
BOTTOM_RIGHT="╯"
VERTICAL="│"
HORIZONTAL="─"

# Helper functions for formatting
print_header() {
    local text="$1"
    local width=50
    local padding=$(( (width - ${#text}) / 2 ))
    
    echo
    printf "%s%s%s%s%s\n" "${BLUE}" "$TOP_LEFT" "$(printf '%*s' $width)" "$TOP_RIGHT" "${NC}"
    printf "%s%s%s%*s%s%s%s\n" "${BLUE}" "$VERTICAL" "${CYAN}" $padding "$text" "$(printf '%*s' $padding)" "${BLUE}$VERTICAL" "${NC}"
    printf "%s%s%s%s%s\n" "${BLUE}" "$BOTTOM_LEFT" "$(printf '%*s' $width | tr ' ' "$HORIZONTAL")" "$BOTTOM_RIGHT" "${NC}"
    echo
}

print_subheader() {
    local text="$1"
    printf "\n%s▓▒░ %s ░▒▓%s\n" "${PURPLE}" "$text" "${NC}"
}

print_section() {
    printf "\n%s◆ %s%s\n" "${ORANGE}" "$1" "${NC}"
}

print_item() {
    printf "  %s●%s %s%s%s\n" "${GREEN}" "${NC}" "${WHITE}" "$1" "${NC}"
}

print_code() {
    printf "    %s%s%s%s\n" "${CYAN}" "${DIM}" "$1" "${NC}"
}

print_description() {
    printf "    %s%s%s%s\n" "${ITALIC}" "${PINK}" "$1" "${NC}"
}

print_warning() {
    printf "%s%s⚠ %s%s\n" "${YELLOW}" "${BOLD}" "$1" "${NC}"
}

print_success() {
    printf "%s%s✓ %s%s\n" "${GREEN}" "${BOLD}" "$1" "${NC}"
}

print_error() {
    printf "%s%s✗ %s%s\n" "${RED}" "${BOLD}" "$1" "${NC}"
}

function helper_menu() {
    clear
    print_header "ZSH Configuration Helper"
    
    local options=(
        "${GREEN}🔧 Manage Aliases${NC}     - Create and modify aliases"
        "${BLUE}📝 Add Function${NC}      - Create new shell functions"
        "${PURPLE}👀 View Configuration${NC} - Browse all settings"
        "${ORANGE}📦 Manage Version${NC}    - Control version numbers"
        "${CYAN}🎨 ASCII Art Style${NC}    - Change welcome message"
        "${RED}✖ Quit${NC}              - Exit helper menu"
    )

    printf "%s\n" "${options[@]}" | fzf \
        --prompt $'\e[1;36mSelect an option > \e[0m' \
        --height 40% \
        --layout=reverse \
        --border rounded \
        --margin 1% \
        --padding 1% \
        --info inline \
        --header $'\e[1;33mWelcome to ZSH Configuration Helper\e[0m' \
        --header-first \
        --ansi \
        --bind 'enter:execute-silent(echo {})' \
        --preview-window=hidden \
        > /tmp/menu_selection

    local choice
    choice=$(cat /tmp/menu_selection | sed 's/\x1b\[[0-9;]*m//g' | cut -d'-' -f1 | tr -d '🔧📝👀📦🎨✖' | xargs)
    rm -f /tmp/menu_selection

    case $choice in
        "Manage Aliases")
            manage_aliases
            ;;
        "Add Function")
            add_new_function
            ;;
        "View Configuration")
            view_configuration
            ;;
        "Manage Version")
            manage_version
            ;;
        "ASCII Art Style")
            manage_ascii_art
            ;;
        "Quit")
            print_success "Thanks for using ZSH Configuration Helper!"
            return
            ;;
    esac

    helper_menu
}

function manage_aliases() {
    local alias_options=(
        "Add New Alias"
        "Create New Alias File"
        "Back to Main Menu"
    )

    local choice=$(printf '%s\n' "${alias_options[@]}" | fzf --prompt "Alias Management > " --height 40% --layout=reverse --border)

    case $choice in
        "Add New Alias")
            add_new_alias
            ;;
        "Create New Alias File")
            create_new_alias_file
            ;;
        "Back to Main Menu")
            return
            ;;
    esac

    manage_aliases
}

function create_new_alias_file() {
    echo "Enter the name for the new alias file (without .zsh extension):"
    echo -n "> "
    read filename
    
    if [[ -n "$filename" ]]; then
        local full_path="${ZSH_SETUP_PATH}/aliases/${filename}.zsh"
        
        if [[ -f "$full_path" ]]; then
            echo "File already exists: $full_path"
            echo "Press Enter to continue..."
            read
            return
        fi

        # Create the file with a header comment
        echo "# ${filename} aliases" > "$full_path"
        echo "File created: $full_path"
        
        # Ask if user wants to add aliases now
        echo -n "Would you like to add aliases to this file now? (y/n) "
        read response
        if [[ "$response" == "y" ]]; then
            add_new_alias "$filename"
        fi

        # Source the new file in the current session
        if [[ -f "$full_path" ]]; then
            source "$full_path"
            echo "New aliases are now available in your current session"
        fi
    fi
}

function add_new_alias() {
    # Get list of existing alias files
    local files=()
    for f in "${ZSH_SETUP_PATH}/aliases"/*.zsh; do
        if [[ -f "$f" ]]; then
            files+=($(basename "$f" .zsh))
        fi
    done

    # Let user select the alias file
    local alias_file=$(printf '%s\n' "${files[@]}" | fzf --prompt "Select Alias File > " --height 40% --layout=reverse --border)

    if [[ -z "$alias_file" ]]; then
        return
    fi

    while true; do
        clear
        echo "Adding alias to ${alias_file}.zsh"
        echo "Enter alias name (or leave empty to finish):"
        echo -n "Name > "
        read alias_name

        if [[ -z "$alias_name" ]]; then
            break
        fi

        echo "Enter alias value:"
        echo -n "Value > "
        read alias_value

        if [[ -n "$alias_name" && -n "$alias_value" ]]; then
            echo "alias $alias_name='$alias_value'" >> "${ZSH_SETUP_PATH}/aliases/${alias_file}.zsh"
            echo "Added alias: $alias_name='$alias_value'"
            echo
            echo "Press Enter to add another alias, or Ctrl+C to finish..."
            read
        fi
    done
}

function add_new_env_var() {
    # Code to add a new environment variable
    echo "Adding a new environment variable..."
}

function add_new_function() {
    echo "Enter the name for the new function (without .zsh extension):"
    echo -n "> "
    read funcname
    
    if [[ -n "$funcname" ]]; then
        # Get the next available number
        local next_num=1
        for f in "${ZSH_SETUP_PATH}/functions"/*.zsh; do
            if [[ -f "$f" ]]; then
                local num=$(basename "$f" | grep -o '^[0-9]\+' || echo "0")
                if (( num >= next_num )); then
                    next_num=$((num + 1))
                fi
            fi
        done
        
        # Format number with leading zero if needed
        local num_padded=$(printf "%02d" $next_num)
        local full_path="${ZSH_SETUP_PATH}/functions/${num_padded}-${funcname}.zsh"
        
        if [[ -f "$full_path" ]]; then
            echo "File already exists: $full_path"
            echo "Press Enter to continue..."
            read
            return
        fi

        # Create the file with a template
        cat > "$full_path" << EOL
# ${funcname} function
# Description: Add your description here

function ${funcname}() {
    # Your code here
}
EOL
        echo "Function file created: $full_path"
        echo "Edit the file to implement your function"
        echo "The function will be available in your next shell session"
        echo
        echo "Press Enter to continue..."
        read
    fi
}

function add_new_option() {
    # Code to add a new zsh option
    echo "Adding a new zsh option..."
}

function add_new_init_file() {
    # Code to add a new initialization file
    echo "Adding a new initialization file..."
}

function add_new_plugin() {
    # Code to add a new plugin
    echo "Adding a new plugin..."
}

function generate_help_content() {
    {
        # How This Works Section
        print_subheader "❓ How This Works"
        print_section "System Overview:"
        print_description "This is a modular ZSH configuration system that manages your shell setup"
        
        print_section "File Management:"
        print_description "The system uses automatic file discovery:"
        print_code "• Files are sourced based on location and .zsh extension"
        print_code "• You can freely rename files while keeping the extension"
        print_code "• Numeric prefixes (01-, 02-) control load order"
        print_code "• Changes take effect on next shell start"
        
        print_section "Creating New Components:"
        print_description "Use the helper menu (zsh-setup) to create:"
        print_code "1. Aliases:"
        print_code "   • Select 'Manage Aliases' → 'Create New Alias File'"
        print_code "   • Files are created in aliases/*.zsh"
        print_code "2. Functions:"
        print_code "   • Select 'Add Function' to create new function"
        print_code "   • Files are auto-numbered (01-, 02-, etc.)"
        print_code "   • Created in functions/*.zsh with template"
        
        print_section "Directory Structure:"
        print_code "aliases/*.zsh   - Alias definitions by category"
        print_code "config/*.zsh    - Configuration files"
        print_code "functions/*.zsh - Custom shell functions (numbered)"
        print_code "plugins/*.zsh   - ZSH plugins"
        print_code "init/*.zsh      - Initialization scripts"
        
        print_section "Key Features:"
        print_description "• Automatic sourcing of new files"
        print_description "• Version management system"
        print_description "• Interactive configuration menu"
        print_description "• Searchable help system"
        
        print_section "Common Tasks:"
        print_code "help, zshhelp          - Access this help menu"
        print_code "zsh-setup              - Open configuration menu"
        print_code "version bump           - Increment version"
        
        print_section "Adding New Aliases:"
        print_description "1. Use 'zsh-setup' → 'Manage Aliases' → 'Create New Alias File'"
        print_description "2. Enter file name (e.g., 'docker' for docker-related aliases)"
        print_description "3. System automatically:"
        print_code "   • Creates the file in aliases/"
        print_code "   • Adds it to main_injector.sh"
        print_code "   • Sources it in current session"
        print_code "   • Makes it available in help menu"

        # Version Information
        print_subheader "📦 Version Information"
        print_item "Current Version: v$(get_version)"
        print_description "Use 'version' command to manage versions"
        print_code "version                    - Show current version"
        print_code "version bump               - Increment minor version (0.01)"
        print_code "version bump major         - Increment major version (0.1)"
        print_code "version bump custom <val>  - Increment by custom value"
        print_code "version set <version>      - Set specific version"

        # Environment Variables
        print_subheader "🌍 Environment Variables"
        if [[ -f "$ZSH_SETUP_PATH/config/env.zsh" ]]; then
            while IFS= read -r line; do
                if [[ $line =~ ^#.* ]]; then
                    print_description "${line}"
                elif [[ $line =~ ^export.* ]]; then
                    print_code "${line}"
                fi
            done < "$ZSH_SETUP_PATH/config/env.zsh"
        fi

        # ZSH Options
        print_subheader "⚙️  ZSH Options"
        if [[ -f "$ZSH_SETUP_PATH/config/options.zsh" ]]; then
            while IFS= read -r line; do
                if [[ $line =~ ^#.* ]]; then
                    print_description "${line}"
                else
                    print_code "${line}"
                fi
            done < "$ZSH_SETUP_PATH/config/options.zsh"
        fi

        # Aliases Section
        print_subheader "🔗 Aliases"
        
        # System Aliases
        print_section "System Aliases:"
        if [[ -f "$ZSH_SETUP_PATH/aliases/system.zsh" ]]; then
            while IFS= read -r line; do
                if [[ $line =~ ^#.* ]]; then
                    print_description "${line}"
                elif [[ $line =~ ^alias.* ]]; then
                    print_code "${line}"
                fi
            done < "$ZSH_SETUP_PATH/aliases/system.zsh"
        fi

        # Git Aliases
        print_section "Git Aliases:"
        if [[ -f "$ZSH_SETUP_PATH/aliases/git.sh" ]]; then
            while IFS= read -r line; do
                if [[ $line =~ ^#.* ]]; then
                    print_description "${line}"
                elif [[ $line =~ ^alias.* ]]; then
                    print_code "${line}"
                fi
            done < "$ZSH_SETUP_PATH/aliases/git.sh"
        fi

        # Functions
        print_subheader "🛠️  Custom Functions"
        
        # Git Commit Function
        print_section "Quick Git Commit (c):"
        print_description "Quickly commit changes with an optional file selection"
        print_code "c <message>              # Commits all changes"
        print_code "c \"message\" file.txt     # Commits specific file(s)"
        print_description "Examples:"
        print_code "c update readme          # Commits all with 'update readme'"
        print_code "c \"fix bug\" src/app.js   # Commits only src/app.js"
        
        # Other Custom Functions
        if [[ -d "$ZSH_SETUP_PATH/functions" ]]; then
            for file in "$ZSH_SETUP_PATH/functions"/*; do
                if [[ -f "$file" ]]; then
                    print_section "$(basename "$file"):"
                    # Read first comment block for description
                    awk '/^#/{p=1;print;next} p{exit}' "$file" | while IFS= read -r line; do
                        print_description "${line#\# }"
                    done
                fi
            done
        fi

        # Plugin Configurations
        print_subheader "🔌 Plugin Configurations"
        if [[ -f "$ZSH_SETUP_PATH/config/plugin-config.zsh" ]]; then
            while IFS= read -r line; do
                if [[ $line =~ ^#.* ]]; then
                    print_description "${line}"
                else
                    print_code "${line}"
                fi
            done < "$ZSH_SETUP_PATH/config/plugin-config.zsh"
        fi

        print_subheader "📋 Available Commands"
        print_item "help, zshhelp - Show this help menu"
        print_description "Access the interactive configuration menu"
        print_item "zsh-setup"
        print_description "Open the interactive ZSH configuration menu"
    }
}

function view_configuration() {
    clear
    print_header "ZSH Configuration Overview"
    
    # Create a header with available subjects
    local header_text="${BOLD}${WHITE}🔍 Interactive Configuration Browser${NC}

${CYAN}Navigation:${NC}
  • Type to filter    ${DIM}(instantly narrows results)${NC}
  • ESC to exit      ${DIM}(returns to main menu)${NC}
  • ENTER to view    ${DIM}(shows full content)${NC}
  • Ctrl-R to reload ${DIM}(refreshes content)${NC}

${YELLOW}Available Sections:${NC}
${CYAN}• ❓ How This Works    • 📦 Auto Updates     • 🔄 Version Info
• 🌍 Environment     • ⚙️  Options         • 🔗 Aliases
• 🛠️  Functions      • 🔌 Plugins         • 📋 Commands${NC}

${GREEN}${BOLD}Begin typing to search...${NC}"

    # Generate content and pipe to fzf for interactive searching
    generate_help_content | fzf --ansi \
                               --layout=reverse \
                               --height=100% \
                               --border \
                               --prompt="Search ZSH Help > " \
                               --preview-window=hidden \
                               --header="$header_text" \
                               --bind="enter:execute(echo {} | less -R)" \
                               --bind="ctrl-r:reload(generate_help_content)" \
                               --bind="change:top" \
                               --no-sort
}

function view_git_functions() {
    echo "Available Git Functions:"
    echo
    echo "Quick Commit (c):"
    echo "  Usage: c <commit message> [file1 file2 ...]"
    echo "  Examples:"
    echo "    c update readme          # Commits all changes with message 'update readme'"
    echo "    c \"fix bug\" file.txt    # Commits only file.txt with message 'fix bug'"
    echo
    read -p "Press Enter to continue..."
}

function show_git_history() {
    clear
    print_header "Git History"
    
    # Get the git log with version bumps highlighted
    git log --pretty=format:"${GREEN}%h${NC} - ${YELLOW}%cd${NC} - %s" --date=format:"%Y-%m-%d %H:%M:%S" | \
    while IFS= read -r line; do
        if [[ $line =~ "version bump" || $line =~ "Version" ]]; then
            printf "${CYAN}${BOLD}%s${NC}\n" "$line"
        else
            printf "%s\n" "$line"
        fi
    done | less -R

    print_success "Press q to return to version management"
}

function manage_version() {
    clear
    print_header "Version Management"
    
    local current_version=$(version get)
    print_item "Current Version: ${BOLD}${GREEN}v${current_version}${NC}"
    echo
    
    local version_options=(
        "${GREEN}${BOLD}📊 Show Current Version${NC}  - Display version info"
        "${BLUE}${BOLD}📈 Bump Minor Version${NC}    - Increment by 0.01"
        "${PURPLE}${BOLD}📈 Bump Major Version${NC}   - Increment by 0.1"
        "${ORANGE}${BOLD}📝 Set Custom Version${NC}   - Set specific version"
        "${CYAN}${BOLD}📜 View Version History${NC}  - Show git history"
        "${GRAY}${BOLD}↩ Back to Main Menu${NC}     - Return to main menu"
    )

    local choice=$(printf '%s\n' "${version_options[@]}" | fzf \
        --prompt "${CYAN}${BOLD}Version Control >${NC} " \
        --height 40% \
        --layout=reverse \
        --border rounded \
        --margin 1% \
        --padding 1% \
        --info inline \
        --header "${YELLOW}${BOLD}Version Management${NC}" \
        --header-first \
        --ansi)

    # Extract the actual command by removing color codes and emoji
    choice=$(echo "$choice" | sed 's/\x1b\[[0-9;]*m//g' | cut -d'-' -f1 | tr -d '📊📈📝📜↩' | xargs)

    case $choice in
        "Show Current Version")
            clear
            print_header "Current Version"
            version
            print_success "Press Enter to continue..."
            read
            ;;
        "Bump Minor Version")
            clear
            print_header "Bump Minor Version"
            version bump minor
            print_success "Version bumped successfully!"
            read -p "Press Enter to continue..."
            ;;
        "Bump Major Version")
            clear
            print_header "Bump Major Version"
            version bump major
            print_success "Version bumped successfully!"
            read -p "Press Enter to continue..."
            ;;
        "Set Custom Version")
            clear
            print_header "Set Custom Version"
            print_item "Current version: v$(version get)"
            echo
            echo -n "${CYAN}${BOLD}Enter new version number:${NC} "
            read new_version
            if [[ -n "$new_version" ]]; then
                version set "$new_version"
                print_success "Version updated successfully!"
            else
                print_warning "No version specified"
            fi
            read -p "Press Enter to continue..."
            ;;
        "View Version History")
            show_git_history
            ;;
        "Back to Main Menu")
            return
            ;;
    esac

    manage_version
}

function manage_ascii_art() {
    clear
    print_header "ASCII Art Selection"
    
    local ascii_options=(
        "${GREEN}${BOLD}🎨 Block Style (v1)${NC}      - Classic block letters"
        "${BLUE}${BOLD}🎨 Slashes Style (v2)${NC}    - Artistic slashes pattern"
        "${PURPLE}${BOLD}🎨 Simple Style (v3)${NC}     - Clean and minimal"
        "${ORANGE}${BOLD}🎨 Retro Style (v4)${NC}     - ASCII with shadows"
        "${PINK}${BOLD}🎨 Modern Style (v5)${NC}     - @ symbol pattern"
        "${GRAY}${BOLD}↩ Back to Main Menu${NC}     - Return to main menu"
    )

    local choice=$(printf '%s\n' "${ascii_options[@]}" | fzf \
        --prompt "${CYAN}${BOLD}Select ASCII Style >${NC} " \
        --height 40% \
        --layout=reverse \
        --border rounded \
        --margin 1% \
        --padding 1% \
        --info inline \
        --header "${YELLOW}${BOLD}Preview will be shown in welcome message${NC}" \
        --header-first \
        --ansi)

    # Extract the actual command by removing color codes and emoji
    choice=$(echo "$choice" | sed 's/\x1b\[[0-9;]*m//g' | cut -d'-' -f1 | tr -d '🎨↩' | xargs)

    case $choice in
        "Block Style (v1)")
            sed -i '' 's/display_welcome_with_art "v[1-5]"/display_welcome_with_art "v1"/' "${ZSH_SETUP_PATH}/welcome_message.sh"
            print_success "Welcome message updated to Block Style!"
            read -p "Press Enter to continue..."
            ;;
        "Slashes Style (v2)")
            sed -i '' 's/display_welcome_with_art "v[1-5]"/display_welcome_with_art "v2"/' "${ZSH_SETUP_PATH}/welcome_message.sh"
            print_success "Welcome message updated to Slashes Style!"
            read -p "Press Enter to continue..."
            ;;
        "Simple Style (v3)")
            sed -i '' 's/display_welcome_with_art "v[1-5]"/display_welcome_with_art "v3"/' "${ZSH_SETUP_PATH}/welcome_message.sh"
            print_success "Welcome message updated to Simple Style!"
            read -p "Press Enter to continue..."
            ;;
        "Retro Style (v4)")
            sed -i '' 's/display_welcome_with_art "v[1-5]"/display_welcome_with_art "v4"/' "${ZSH_SETUP_PATH}/welcome_message.sh"
            print_success "Welcome message updated to Retro Style!"
            read -p "Press Enter to continue..."
            ;;
        "Modern Style (v5)")
            sed -i '' 's/display_welcome_with_art "v[1-5]"/display_welcome_with_art "v5"/' "${ZSH_SETUP_PATH}/welcome_message.sh"
            print_success "Welcome message updated to Modern Style!"
            read -p "Press Enter to continue..."
            ;;
        "Back to Main Menu")
            return
            ;;
    esac

    manage_ascii_art
}

# Function to show welcome message
show_welcome() {
    source "$HOME/development/dotfiles/init/02-welcome.zsh"
}

# Function to show help
show_help() {
    show_welcome
    echo "\n\e[1;34mAvailable Commands:\e[0m"
    echo "  \e[1;33mhelp\e[0m, \e[1;33mzshhelp\e[0m     - Show this help message"
    echo "  \e[1;33mhelper_menu\e[0m     - Open the configuration helper"
}

# Check for direct access flags
if [[ "$1" == "--help" ]] || [[ "$1" == "help" ]] || [[ "$1" == "zshhelp" ]]; then
    show_help
    exit 0
elif [[ "$1" == "--config" ]]; then
    helper_menu
    exit 0
fi

# Create the help and zshhelp commands
alias help='show_help'
alias zshhelp='show_help'

