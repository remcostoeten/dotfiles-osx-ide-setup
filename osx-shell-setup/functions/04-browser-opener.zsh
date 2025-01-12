#!/bin/zsh

# Function to open URLs in different browsers
# Usage: www example.com [--ff|--chrome|--brave|--arc]
# Example: www github.com --ff (opens in Firefox)
function www() {
    local url=$1
    local browser="open" # Default to system default browser
    
    # If no URL is provided, show usage
    if [[ -z "$url" ]]; then
        echo "Usage: www <url> [--ff|--chrome|--brave|--arc]"
        return 1
    fi
    
    # If URL doesn't start with http(s)://, add it
    if [[ ! "$url" =~ ^https?:// ]]; then
        url="https://$url"
    fi
    
    # Check for browser flags
    case "$2" in
        --ff)
            browser="open -a Firefox"
            ;;
        --chrome)
            browser="open -a 'Google Chrome'"
            ;;
        --brave)
            browser="open -a Brave"
            ;;
        --arc)
            browser="open -a Arc"
            ;;
    esac
    
    # Open the URL in the selected browser
    eval "$browser '$url'"
} 
