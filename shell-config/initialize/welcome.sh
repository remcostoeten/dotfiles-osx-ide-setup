#!/bin/bash

# Read version and last updated date
version=$(cat "$(dirname "$0")/../version.txt" | head -n 1)
last_updated=$(cat "$(dirname "$0")/../version.txt" | tail -n 1)

# Display welcome message
echo "Welcome! Version: $version, Last updated: $last_updated"
