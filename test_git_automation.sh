#!/bin/bash

# ----------------------------
#   Git Automation Test Runner
#   File: test_git_automation.sh
#   Author: Raafiya Gouher
#   Date: 2025-07-09
#   Description: This script tests the interactive_git_automation.sh script by running it and checking its success.
#   Version: 1.0
# ----------------------------


echo "🔁 Running Git Automation Test..."

./interactive_git_automation.sh

if [ $? -eq 0 ]; then
    echo "✅ Git automation executed successfully."
else
    echo "❌ Script failed. Check output for issues."
    exit 1
fi

# Ask to view version file
read -p "Do you want to view version.txt from a branch? (yes/no): " VIEW_FILE
if [[ "$VIEW_FILE" == "yes" ]]; then
    read -p "Enter repo name: " REPO_NAME
    read -p "Enter branch to view version.txt (e.g., feature-login): " BRANCH
    cd "$REPO_NAME" || exit
    git checkout "$BRANCH"
    echo "📄 Contents of version.txt in $BRANCH:"
    cat version.txt
fi

echo "🧪 Test completed."
