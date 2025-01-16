#!/bin/bash

# Directory containing the alias  scripts
DIR_TO_SOURCE="$(dirname "$0")/aliasses"

# Source each file in the alias directory
for file in "$DIR_TO_SOURCE"/*; do
    if [ -f "$file" ]; then
        source "$file"
    fi
done
