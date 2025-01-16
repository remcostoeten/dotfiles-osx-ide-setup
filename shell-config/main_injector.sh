# -----------------------------------------------------------------------------
# Main injector responsible for sourcing all individual injectors. 
# -----------------------------------------------------------------------------
# Author: Remco Stoeten
# Version: $(cat "$(dirname "$0")/version.txt" | head -n 1)
# Last updated: $(cat "$(dirname "$0")/version.txt" | tail -n 1)
# -----------------------------------------------------------------------------
# Depends on:  ~/.zshrc
# -----------------------------------------------------------------------------

# Source welcome message
source "$(dirname "$0")/initialize/welcome.sh"

# Source colors first
source "$(dirname "$0")/initialize/colors.sh"

# Source all injectors
for injector in "$(dirname "$0")/injectors"/*; do
    if [ -f "$injector" ]; then
        source "$injector"
    fi
done