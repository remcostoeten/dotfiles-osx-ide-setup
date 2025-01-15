#!/bin/bash

# Directory containing the initialization scripts
DIR_TO_SOURCE ="$(dirname "$0")/utilities"

# Source each file in the initialization directory
for file in "$DIR_TO_SOURCE"/*; do
    if [ -f "$file" ]; then
        source "$file"
    fi
done
