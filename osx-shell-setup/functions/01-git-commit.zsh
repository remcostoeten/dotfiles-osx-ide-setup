# Function to handle quick git commits with optional file paths
function c() {
    # If no arguments provided, show usage
    if [ $# -eq 0 ]; then
        echo "Usage: c <commit message> [file1 file2 ...]"
        echo "Examples:"
        echo "  c update readme          # Commits all changes with message 'update readme'"
        echo "  c \"fix bug\" file.txt    # Commits only file.txt with message 'fix bug'"
        return 1
    fi

    local commit_msg="$1"
    shift  # Remove the first argument (commit message)

    # If additional arguments are provided, they are file paths
    if [ $# -gt 0 ]; then
        # Add specific files
        git add "$@"
    else
        # Add all changes
        git add .
    fi

    # Perform the commit
    git commit -m "$commit_msg"
    
    # Automatically bump minor version after successful commit
    if [ $? -eq 0 ]; then
        # Only bump if version command exists
        if type version >/dev/null 2>&1; then
            version bump minor
            echo "Version automatically bumped after commit"
        fi
    fi
} 