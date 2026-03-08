# GitHub CLI

## What is GitHub CLI?

`gh` is the official GitHub command line tool. Instead of switching between terminal and browser for GitHub tasks, you do everything from the terminal — create repos, open PRs, manage issues, view CI status, merge branches, clone, fork, all of it.

```
without gh   →   push code → open browser → navigate to repo → click buttons
with gh      →   push code → gh pr create → done
```

---

## Install

```bash
# Ubuntu / Debian
sudo apt install gh

# or via official repo (latest version)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
  https://cli.github.com/packages stable main" \
  | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update && sudo apt install gh

# Arch
sudo pacman -S github-cli

# macOS
brew install gh

# verify
gh --version
```

---

## Authentication

```bash
# Login — opens browser to authenticate
gh auth login

# Prompts:
# → GitHub.com or GitHub Enterprise
# → HTTPS or SSH (pick SSH if you have keys set up)
# → Authenticate via browser or paste token

# Check current auth status
gh auth status

# Logout
gh auth logout

# Use a personal access token instead
gh auth login --with-token < token.txt
# or
echo "ghp_yourtoken" | gh auth login --with-token

# Refresh / add scopes
gh auth refresh -s read:project,write:packages
```

---

## Repos

```bash
# Create a new repo (interactive)
gh repo create

# Create with flags — no prompts
gh repo create my-project --public --clone
gh repo create my-project --private --description "my app"

# Clone a repo (shorter than git clone)
gh repo clone username/repo
gh repo clone username/repo ~/projects/repo

# Fork a repo and clone it
gh repo fork username/repo --clone

# View repo in browser
gh repo view
gh repo view username/repo --web

# List your repos
gh repo list
gh repo list --limit 20
gh repo list --public
gh repo list --private

# Rename a repo
gh repo rename new-name

# Delete a repo
gh repo delete username/repo

# Sync a fork with upstream
gh repo sync

# Edit repo settings
gh repo edit --description "new description"
gh repo edit --visibility public
gh repo edit --default-branch main
```

---

## Pull Requests

```bash
# Create a PR (interactive)
gh pr create

# Create with flags
gh pr create --title "feat: add search" --body "adds ctrl+k search modal"
gh pr create --title "fix: nav bug" --base main --head feature-branch
gh pr create --draft                        # draft PR
gh pr create --reviewer username1,username2 # request reviewers
gh pr create --label "bug,enhancement"
gh pr create --assignee "@me"

# List PRs
gh pr list
gh pr list --state open
gh pr list --state closed
gh pr list --author "@me"
gh pr list --label bug

# View a PR
gh pr view           # current branch's PR
gh pr view 42        # by number
gh pr view --web     # open in browser

# Check PR status / CI checks
gh pr checks
gh pr checks 42

# Checkout a PR branch locally
gh pr checkout 42

# Review a PR
gh pr review 42 --approve
gh pr review 42 --request-changes --body "needs tests"
gh pr review 42 --comment --body "looks good but check line 42"

# Merge a PR
gh pr merge 42
gh pr merge 42 --merge           # regular merge commit
gh pr merge 42 --squash          # squash into one commit
gh pr merge 42 --rebase          # rebase and merge
gh pr merge 42 --delete-branch   # delete branch after merge
gh pr merge --auto               # auto-merge when checks pass

# Close / reopen
gh pr close 42
gh pr reopen 42

# Edit a PR
gh pr edit 42 --title "new title"
gh pr edit 42 --add-label bug
gh pr edit 42 --add-reviewer username
```

---

## Issues

```bash
# Create an issue
gh issue create
gh issue create --title "bug: navbar breaks on mobile" --body "steps to reproduce..."
gh issue create --label "bug" --assignee "@me"

# List issues
gh issue list
gh issue list --label bug
gh issue list --assignee "@me"
gh issue list --state closed
gh issue list --limit 50

# View an issue
gh issue view 12
gh issue view 12 --web

# Close / reopen
gh issue close 12
gh issue close 12 --comment "fixed in #45"
gh issue reopen 12

# Edit
gh issue edit 12 --title "new title"
gh issue edit 12 --add-label enhancement
gh issue edit 12 --add-assignee username

# Delete
gh issue delete 12

# Pin / unpin
gh issue pin 12
gh issue unpin 12
```

---

## GitHub Actions / CI

```bash
# List workflows
gh workflow list

# View runs
gh run list
gh run list --workflow ci.yml
gh run list --branch main
gh run list --status failure

# Watch a run live (tails the output)
gh run watch
gh run watch 123456

# View a specific run
gh run view 123456
gh run view 123456 --log          # full logs
gh run view 123456 --log-failed   # only failed steps

# Re-run
gh run rerun 123456
gh run rerun 123456 --failed      # only failed jobs

# Trigger a workflow manually
gh workflow run ci.yml
gh workflow run deploy.yml --ref main
gh workflow run deploy.yml -f environment=production

# Enable / disable workflow
gh workflow enable ci.yml
gh workflow disable ci.yml

# Download artifacts from a run
gh run download 123456
gh run download 123456 --name my-artifact
```

---

## Releases

```bash
# Create a release
gh release create v1.0.0
gh release create v1.0.0 --title "First Release" --notes "Initial release"
gh release create v1.0.0 --generate-notes    # auto-generate from commits
gh release create v1.0.0 --draft
gh release create v1.0.0 --prerelease

# Upload assets to a release
gh release create v1.0.0 ./dist/app.zip ./dist/app.tar.gz
gh release upload v1.0.0 ./build/app.zip

# List releases
gh release list

# View a release
gh release view v1.0.0
gh release view v1.0.0 --web

# Delete a release
gh release delete v1.0.0

# Download release assets
gh release download v1.0.0
gh release download v1.0.0 --pattern "*.zip"
```

---

## Gists

```bash
# Create a gist
gh gist create file.js
gh gist create file.js --public
gh gist create file.js --desc "utility function"
gh gist create file1.js file2.css   # multiple files
echo "hello" | gh gist create -     # from stdin

# List gists
gh gist list

# View a gist
gh gist view abc123
gh gist view abc123 --web
gh gist view abc123 --raw    # raw content

# Clone a gist
gh gist clone abc123

# Edit a gist
gh gist edit abc123

# Delete
gh gist delete abc123
```

---

## SSH Keys & GPG

```bash
# Add SSH key to GitHub
gh ssh-key add ~/.ssh/id_ed25519.pub --title "my laptop"

# List SSH keys
gh ssh-key list

# Delete SSH key
gh ssh-key delete 12345

# Add GPG key
gh gpg-key add public-key.gpg

# List GPG keys
gh gpg-key list
```

---

## Aliases — Create Custom Shortcuts

```bash
# Create an alias
gh alias set prc 'pr create --fill'
gh alias set co 'pr checkout'
gh alias set lg 'repo view --web'

# Use the alias
gh prc
gh co 42

# List aliases
gh alias list

# Delete alias
gh alias delete prc

# Shell alias (runs shell commands)
gh alias set --shell latest 'gh release list --limit 1'
```

---

## Config

```bash
# View current config
gh config list

# Set editor
gh config set editor vim
gh config set editor "code --wait"

# Set git protocol
gh config set git_protocol ssh
gh config set git_protocol https

# Set browser
gh config set browser firefox

# Set prompt
gh config set prompt enabled
```

---

## Useful Combos

```bash
# Create repo, push existing project, open in browser
git init && git add -A && git commit -m "init"
gh repo create my-project --public --source=. --push
gh repo view --web

# Quick PR from current branch
git add -A && git commit -m "feat: my feature"
git push -u origin HEAD
gh pr create --fill    # uses last commit message as title

# See CI status of current PR and watch it
gh pr checks --watch

# Clone, checkout a PR, test it
gh repo clone user/repo
cd repo
gh pr checkout 42
# test...
gh pr review 42 --approve

# Release workflow
gh release create v1.2.0 --generate-notes
# github auto-writes release notes from merged PRs

# Find and fix a failing CI run
gh run list --status failure
gh run view 123456 --log-failed
# fix the issue, push, re-run
gh run rerun 123456 --failed
```

---

## For Your Projects

```bash
# notes-site — after a build and push
cd ~/notes-site
git add -A && git commit -m "add cloudflare notes"
git push
gh repo view --web    # open in browser to verify GitHub Pages

# mirage — create PR for a feature branch
cd ~/visual-site
git checkout -b feature/dark-mode-toggle
# make changes
git add -A && git commit -m "feat: dark mode toggle"
git push -u origin HEAD
gh pr create --title "feat: dark mode toggle" --body "adds toggle button to navbar"

# Check if GitHub Pages deployment succeeded
gh run list --workflow pages    # if using Actions
gh run watch                    # watch the deploy live

# Quick release tag
gh release create v2.0.0 --generate-notes --title "Mirage v2"
```

---

## Quick Reference

```
gh auth login              authenticate
gh repo create             create new repo
gh repo clone user/repo    clone a repo
gh pr create               create pull request
gh pr list                 list open PRs
gh pr merge 42             merge PR #42
gh issue create            create issue
gh issue list              list issues
gh run list                list CI runs
gh run watch               watch current run live
gh workflow run ci.yml     trigger a workflow
gh release create v1.0.0   create release
gh gist create file.js     create a gist
gh alias set co 'pr checkout'  create shortcut
gh config set editor vim   set editor
```
