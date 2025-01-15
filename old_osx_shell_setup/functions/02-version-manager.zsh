#!/bin/zsh

# Function to get current version
get_version() {
    local version_file="$DOTFILES/config/version.txt"
    if [[ -f "$version_file" ]]; then
        cat "$version_file"
    else
        echo "0.1"
    fi
}

# Function to set version
set_version() {
    local version_file="$DOTFILES/config/version.txt"
    echo "$1" > "$version_file"
    git add "$version_file"
    git commit -m "chore: bump version to $1"
}

# Function to increment version
increment_version() {
    local current_version=$(get_version)
    local increment_type=${1:-"minor"}  # default to minor increment (0.01)
    local increment_value=${2:-""}      # custom increment value if provided
    
    if [[ -n "$increment_value" ]]; then
        # Use custom increment value
        local new_version=$(echo "$current_version + $increment_value" | bc)
    else
        case "$increment_type" in
            "major")  # Increment by 0.1
                local new_version=$(echo "$current_version + 0.1" | bc)
                ;;
            "minor")  # Increment by 0.01
                local new_version=$(echo "$current_version + 0.01" | bc)
                ;;
            *)
                echo "Invalid increment type. Use 'major', 'minor', or provide a custom value."
                return 1
                ;;
        esac
    fi
    
    # Format to ensure two decimal places
    new_version=$(printf "%.2f" "$new_version")
    set_version "$new_version"
    echo "Version bumped from $current_version to $new_version"
}

# Main version command
version() {
    local command=$1
    shift  # Remove first argument

    case "$command" in
        "get")
            get_version
            ;;
        "set")
            if [[ -z "$1" ]]; then
                echo "Usage: version set <version_number>"
                return 1
            fi
            set_version "$1"
            ;;
        "bump")
            local increment_type=$1
            local custom_value=$2
            increment_version "$increment_type" "$custom_value"
            ;;
        *)
            echo "Current version: $(get_version)"
            echo
            echo "Usage:"
            echo "  version                    - Show current version"
            echo "  version get                - Get current version"
            echo "  version set <version>      - Set specific version"
            echo "  version bump               - Increment minor version (0.01)"
            echo "  version bump major         - Increment major version (0.1)"
            echo "  version bump minor         - Increment minor version (0.01)"
            echo "  version bump custom <val>  - Increment by custom value"
            ;;
    esac
} 