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

## ✨ Features

✅ Interactive CLI inputs (repo name, branches, visibility)  
✅ Git & GitHub CLI detection and Linux auto-installation  
✅ GitHub authentication check  
✅ Optional README.md file creation  
✅ Version tracking via `version.txt`  
✅ Public or private GitHub repo creation  
✅ Pushes all branches and commits to GitHub  
✅ Companion test script to simulate full workflow  


---


## 💻 File Structure

Git-Automation-Project/
- `interactive_git_automation.sh` – Main interactive script
- `test_git_automation.sh` – Test runner to simulate the workflow
- `version.txt` – Tracks version info per branch
- `README.md` – Project documentation

---


## 🔧 Requirements

| Tool        | Required | Install Guide                         |
|-------------|----------|----------------------------------------|
| Git         | ✅ Yes   | [git-scm.com](https://git-scm.com/downloads) |
| GitHub CLI  | ✅ Yes   | [cli.github.com](https://cli.github.com/) |
| Linux (Debian/Ubuntu) | ✅ For auto-install | Works best with APT |

> ⚠️ **Windows users**: Use Git Bash or WSL.  
> ⚠️ **macOS**: Manual installation of Git and GitHub CLI is required.

---

## 📦 Setup Instructions

### 1. Clone the Project
```bash
git clone https://github.com/Raafiya-Gouher/Git-Workflow-Automation-Using-Interactive-Shell-Scripts.git
cd Git-Workflow-Automation-Using-Interactive-Shell-Scripts
```

---

## 🚀 Getting Started

### 🔧 Step 1: Make scripts executable

```
chmod +x interactive_git_automation.sh
chmod +x test_git_automation.sh
```


### ▶️ Step 2: Run the test script
```
./test_git_automation.sh
```

You will be prompted to:

* Enter a GitHub repository name

* Provide branch names

* Choose to include a README or not

* Set visibility (public/private)

* Authenticate via GitHub CLI (first-time only)
  
  
## 📄 What Gets Created

* A new Git repo under the given name

* A file called version.txt that tracks:
```
Version: 1.0.0 (main)
Version: 1.0.1 (feature-login)
Version: 1.0.2 (bugfix-api)
```
* A README (if opted in)
* Separate commits on each branch with version updates

* All changes pushed to a new GitHub repo
---


### 🧪 Testing Workflow

After running the main script, you can test by:

- Viewing branches in GitHub

- Opening and reading ``` version.txt ```

- Verifying commit history with:
  ```
  git log --oneline --graph --all
  ```

## 🧪 Sample Output

📁 Creating and initializing repo: my-test-repo
📄 README.md created.
🌐 Creating GitHub repo (public)...
✅ 'my-test-repo' has been created and pushed successfully.

📜 Git Commit History:
```
* 7a3 Initial version 1.0.2 on bugfix-api
* 37b Initial version 1.0.1 on feature-login
* c12 Initial version 1.0.0 on main
```
---
