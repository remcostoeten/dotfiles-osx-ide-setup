#!/bin/zsh

# Read the current version from version.txt
current_version=$(cat ../version.txt | head -n 1)

# Split the version into major and minor parts
IFS='.' read -r major minor <<< "$current_version"

# Check for the --medium flag
if [[ "$1" == "--medium" ]]; then
    minor=$((minor + 10))
else
    minor=$((minor + 1))
fi

# If minor is 100 or more, increment major and reset minor
if [[ "$minor" -ge 100 ]]; then
    major=$((major + 1))
    minor=0
fi

# Format the new version
new_version=$(printf "%d.%02d" "$major" "$minor")

# Get the current date
current_date=$(date +'%Y-%m-%d')

# Update version.txt with the new version and date
echo "$new_version" > ../version.txt
echo "$current_date" >> ../version.txt

# Update the version and last updated date in main_injector.sh
sed -i '' "s/^# Version: .*/# Version: $new_version/" ../main_injector.sh
sed -i '' "s/^# Last updated: .*/# Last updated: $current_date/" ../main_injector.sh

echo "Version updated to $new_version"
