#!/bin/bash

# ------------------------------------
#   Git Workflow Automation Script (Interactive)
#   File: interactive_git_automation.sh
#   Author: Raafiya Gouher
#   Date: 2025-07-09
#   Description: This script automates the process of creating a Git repository, adding branches,committing changes, and pushing to GitHub with user-defined inputs.
#   Version: 1.0
# ------------------------------------

# --- Prerequisite Checks & Auto-Install (Ubuntu/Debian) ---


# 🔧 Auto-fix line-ending warnings
git config --global core.autocrlf false
git config --global init.defaultBranch main

# --- Functions for installing missing tools ---

detect_os() {
    OS="$(uname -s)"
    case "$OS" in
        Linux*)
            if grep -qi microsoft /proc/version 2>/dev/null; then
                MACHINE="WSL"
                echo "🖥️ Detected: Windows Subsystem for Linux (WSL)"
            else
                MACHINE="Linux"
                echo "🖥️ Detected: Linux (Ubuntu/Debian)"
            fi
            ;;
        Darwin*)
            MACHINE="Mac"
            echo "🖥️ Detected: macOS"
            ;;
        MINGW*|MSYS*|CYGWIN*)
            MACHINE="Windows"
            echo "🖥️ Detected: Windows (Git Bash)"
            ;;
        *)
            MACHINE="UNKNOWN"
            echo "⚠️ Unsupported OS: $OS"
            ;;
    esac
}

detect_os 

install_git() {
    if [[ "$MACHINE" == "Linux" ]]; then
        echo "🛠 Installing Git on Linux..."
        sudo apt update && sudo apt install -y git
    elif [[ "$MACHINE" == "Mac" ]]; then
        echo "💡 macOS detected. Please install Git using Homebrew:"
        echo "   brew install git"
        exit 1
    elif [[ "$MACHINE" == "Windows" ]]; then
        echo "💡 Windows detected. Please install Git manually from:"
        echo "   https://git-scm.com/download/win"
        exit 1
    else
        echo "❌ Unsupported OS for automatic Git installation."
        exit 1
    fi
}


install_gh_cli() {
    if [[ "$MACHINE" == "Linux" ]]; then
        echo "🛠 Installing GitHub CLI on Linux..."
        type -p curl >/dev/null || sudo apt install -y curl
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
          sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
        sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
        https://cli.github.com/packages stable main" | \
        sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt update && sudo apt install -y gh
    elif [[ "$MACHINE" == "Mac" ]]; then
        echo "💡 macOS detected. Please install GitHub CLI using Homebrew:"
        echo "   brew install gh"
        exit 1
    elif [[ "$MACHINE" == "Windows" ]]; then
        echo "💡 Windows detected. Please install GitHub CLI manually from:"
        echo "   https://cli.github.com/"
        exit 1
    else
        echo "❌ Unsupported OS for GitHub CLI installation."
        exit 1
    fi
}


# --- Check for Git and GitHub CLI ---

if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed."
    read -p "Install Git now? (yes/no): " INSTALL_GIT
    [[ "$INSTALL_GIT" == "yes" ]] && install_git || exit 1
fi

if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed."
    read -p "Install GitHub CLI now? (yes/no): " INSTALL_GH
    [[ "$INSTALL_GH" == "yes" ]] && install_gh_cli || exit 1
fi

# --- Authenticate with GitHub CLI ---

if ! gh auth status &>/dev/null; then
    echo "🔐 GitHub CLI not authenticated. Logging in..."
    gh auth login || exit 1
fi

# --- User Input ---

echo "🚀 Git Automation Setup"

read -p "Enter your GitHub repository name: " REPO_NAME
read -p "Enter the number of additional branches: " BRANCH_COUNT

declare -a BRANCHES
for ((i=1; i<=BRANCH_COUNT; i++)); do
    read -p "Enter name for branch #$i: " BRANCH_NAME
    BRANCHES+=("$BRANCH_NAME")
done

read -p "Do you want to include a README.md file? (yes/no): " ADD_README
read -p "Should the GitHub repo be public or private? (public/private): " VISIBILITY

if [[ "$VISIBILITY" != "public" && "$VISIBILITY" != "private" ]]; then
    echo "❌ Invalid visibility option. Use 'public' or 'private'."
    exit 1
fi

# --- Create and initialize repository ---

echo "📁 Creating repo directory: $REPO_NAME"
mkdir "$REPO_NAME" && cd "$REPO_NAME" || exit

git init -b main
git config core.autocrlf false  # Also set locally

# --- Optional README.md ---
if [[ "$ADD_README" == "yes" ]]; then
    touch README.md
    git add README.md
    git commit -m "Add empty README.md"
fi

# --- Add version tracking file ---
SAMPLE_FILE="version.txt"
VERSION="1.0.0"
echo "Version: $VERSION (main)" > $SAMPLE_FILE
git add $SAMPLE_FILE
git commit -m "Initial version $VERSION on main"

# --- Create feature branches and version them ---
VERSION_MINOR=1
for branch in "${BRANCHES[@]}"; do
    VERSION="1.0.$VERSION_MINOR"
    git checkout -b "$branch"
    echo "Version: $VERSION ($branch)" >> $SAMPLE_FILE
    git add $SAMPLE_FILE
    git commit -m "Version $VERSION update in $branch"
    ((VERSION_MINOR++))
done

git checkout main

# --- Add scripts to repo ---
cp ../interactive_git_automation.sh .
cp ../test_git_automation.sh .
git add interactive_git_automation.sh test_git_automation.sh
git commit -m "Add Git automation and test scripts"

# --- Create GitHub repo ---
echo "🌐 Creating GitHub repo ($VISIBILITY)..."
gh repo create "$REPO_NAME" --"$VISIBILITY" --source=. --remote=origin --push

# --- Push branches ---
for branch in "${BRANCHES[@]}"; do
    git checkout "$branch"
    git push -u origin "$branch"
done

git checkout main
git push -u origin main

# --- Show Commit Log ---
echo "📜 Git Commit History:"
git log --oneline --graph --all

echo "✅ '$REPO_NAME' created, versioned, and pushed with all branches."
