<h1 align="center">🚀 Git Workflow Automation with Shell Scripts</h1>

<p align="center">
  <b>Automate your Git version control tasks with a single script!</b><br>
  Create repositories, branches, version commits, and push to GitHub – all hands-free.
</p>

---

## 📌 Overview

This project simplifies repetitive Git tasks using interactive, cross-platform **Bash scripts**. Whether you're a developer, DevOps engineer, or student, this tool helps you automate:

- ✅ Git repository creation (local + remote)
- 🌳 Branch management
- 📝 Version file updates
- 🔄 Automated commits
- ☁️ GitHub integration using GitHub CLI (`gh`)

---

## 🧰 Features

| Feature | Description |
|--------|-------------|
| 🔧 Auto-installs Git & GitHub CLI (if missing) | No setup headaches |
| 🌱 Creates multiple branches | With unique commit messages per branch |
| 🗂️ Adds version tracking file (`version.txt`) | Tracks changes by branch/version |
| 📄 Optional README.md file creation | You choose what to include |
| 🐙 Creates and pushes to GitHub repo via CLI | Fully remote-enabled |
| 🧪 Includes test script | Simulate & verify your workflow |

---

## 💻 File Structure

📁 Git-Automation-Project/
├── interactive_git_automation.sh # Main script (interactive)
├── test_git_automation.sh # Test runner
├── version.txt # Auto-updated version file
└── README.md # You're reading it!



## ⚙️ Requirements

- Git ✅  
- GitHub CLI (`gh`) ✅  
- Unix-like shell (Linux, macOS, Git Bash on Windows)

> 💡 Windows users must run via **Git Bash** or **WSL**.

---

## 🚀 Getting Started

### 🔧 Step 1: Make scripts executable


chmod +x interactive_git_automation.sh test_git_automation.sh
▶️ Step 2: Run the test script

./test_git_automation.sh
This will:

Prompt you for repo name, branch names, and visibility

Set up README.md (optional)

Add version.txt with commits per branch

Create a repo on GitHub

Push all branches and commits

📜 Example Commit Log

* 0dd4287 (origin/feature2, feature2) Version 1.0.2 update in feature2
* 381a0e7 (origin/feature1, feature1) Version 1.0.1 update in feature1
* 172a373 (origin/main, main) Initial version 1.0.0 on main