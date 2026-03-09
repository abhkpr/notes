# GitHub CLI  Workflow

## The Mental Model

```
local machine                    github
─────────────────                ──────────────────
working directory  →  commit  →  push  →  repo
      ↓                                     ↓
   git add                              pull request
   git commit                           CI checks
   git push                             merge
```

Every project follows the same loop:
**branch → code → commit → push → PR → merge → pull**

---

## New Project from Scratch

```bash
# 1. create folder and init git
mkdir my-project
cd my-project
git init

# 2. create first file
echo "# My Project" > README.md

# 3. first commit
git add -A
git commit -m "init"

# 4. create github repo and push in one shot
gh repo create my-project --public --source=. --push
```

Done. Repo is live on GitHub in 4 steps.

---

## Existing Local Project → GitHub

```bash
cd ~/my-existing-project
git init
git add -A
git commit -m "init"
gh repo create my-existing-project --public --source=. --push
```

---

## Daily Feature Workflow

```bash
# 1. make sure you're on main and up to date
git checkout main
git pull

# 2. create a feature branch
git checkout -b feature/navbar

# 3. write code...

# 4. stage and commit
git add -A
git commit -m "feat: add navbar component"

# 5. push branch to github
git push -u origin HEAD

# 6. open a pull request
gh pr create --title "feat: add navbar" --body "adds responsive navbar"

# 7. check CI status
gh pr checks

# 8. merge and delete branch
gh pr merge --squash --delete-branch

# 9. come back to main and sync
git checkout main
git pull
```

---

## Commit Message Format

Good commit messages make your history readable.

```
feat: add search modal          → new feature
fix: navbar breaks on mobile    → bug fix
refactor: extract auth logic    → code cleanup
style: fix button spacing       → styling only
docs: update README             → documentation
chore: update dependencies      → maintenance
test: add login unit tests      → tests
```

```bash
# examples
git commit -m "feat: add ctrl+k search"
git commit -m "fix: regex tester not highlighting matches"
git commit -m "refactor: split toolkit into individual pages"
git commit -m "chore: add cloudflare notes"
```

---

## Branching Strategy

```
main          → always stable, always deployable
dev           → integration branch (optional)
feature/xyz   → new features
fix/xyz       → bug fixes
hotfix/xyz    → urgent production fixes
```

```bash
# create and switch to branch
git checkout -b feature/dark-mode

# list all branches
git branch -a

# switch between branches
git checkout main
git checkout feature/dark-mode

# delete a branch locally
git branch -d feature/dark-mode

# delete a branch on github
git push origin --delete feature/dark-mode
# or
gh pr merge --delete-branch
```

---

## Pull Requests

```bash
# create PR (interactive — asks for title, body, reviewers)
gh pr create

# create with flags (no prompts)
gh pr create --title "feat: add search" --body "adds ctrl+k search modal"

# draft PR (not ready to merge yet)
gh pr create --draft

# view your open PRs
gh pr list

# check CI status of current branch's PR
gh pr checks

# watch CI live
gh pr checks --watch

# view PR in browser
gh pr view --web

# merge options
gh pr merge --merge           # regular merge commit
gh pr merge --squash          # squash all commits into one
gh pr merge --rebase          # rebase onto main
gh pr merge --squash --delete-branch   # squash + clean up branch
```

---

## Cloning and Contributing

```bash
# clone your own repo
gh repo clone username/repo

# clone and immediately cd into it
gh repo clone username/repo && cd repo

# fork someone else's repo and clone it
gh repo fork username/repo --clone

# keep your fork in sync with upstream
git remote add upstream https://github.com/original/repo.git
git fetch upstream
git merge upstream/main
# or
gh repo sync
```

---

## Undoing Things

```bash
# undo last commit (keep changes)
git reset --soft HEAD~1

# undo last commit (discard changes)
git reset --hard HEAD~1

# undo changes to a file
git checkout -- filename.js

# undo all unstaged changes
git restore .

# revert a pushed commit (safe — creates new commit)
git revert abc1234
git push

# stash changes temporarily
git stash
git stash pop           # bring them back
git stash list          # see all stashes
git stash drop          # delete top stash
```

---

## Syncing and Conflicts

```bash
# pull latest from main
git pull origin main

# pull with rebase (cleaner history)
git pull --rebase origin main

# if you have conflicts after pull
# → open the conflicted files
# → look for <<<<<<< HEAD markers
# → fix manually
# → then
git add .
git rebase --continue
# or if merging
git merge --continue

# abort if things go wrong
git rebase --abort
git merge --abort
```

---

## Checking Status and History

```bash
# see what's changed
git status
git status -s           # short version

# see what changed in files
git diff
git diff --staged       # changes you've staged

# commit history
git log
git log --oneline       # compact
git log --oneline --graph --all    # visual branch tree

# who changed what line
git blame filename.js

# search commits
git log --grep="navbar"
git log --author="yourname"
```

---

## GitHub CLI Shortcuts

```bash
# open repo in browser
gh repo view --web

# see CI runs
gh run list
gh run watch            # watch current run live

# open issues
gh issue list
gh issue create --title "bug: trackpad not working"

# create a release
gh release create v1.0.0 --generate-notes

# create a gist from a file
gh gist create file.js --public
```

---

## For Your Projects

### notes-site

```bash
cd ~/notes-site

# add a new note
cp ~/Downloads/new-note.md src/
# add it to ORDER array in build.sh
nano build.sh

# build and push
bash build.sh
git add -A
git commit -m "chore: add new-note"
git push

# watch github pages deploy
gh run list
```

### mirage

```bash
cd ~/visual-site

# start a new page
git checkout -b feature/new-tool-page

# work on the page...

git add -A
git commit -m "feat: add binary-search visualizer page"
git push -u origin HEAD
gh pr create --title "feat: binary search page"
gh pr merge --squash --delete-branch
git checkout main && git pull
```

---

## Quick Reference

```
── setup ──────────────────────────────────────
git init                        init repo
gh repo create name --public    create on github
gh repo clone user/repo         clone a repo

── daily ──────────────────────────────────────
git checkout -b feature/name    new branch
git add -A                      stage all
git commit -m "feat: ..."       commit
git push -u origin HEAD         push branch
gh pr create                    open PR
gh pr merge --squash            merge
git checkout main && git pull   sync

── check ──────────────────────────────────────
git status                      what changed
git log --oneline               commit history
git diff                        line-by-line diff
gh pr list                      open PRs
gh run list                     CI runs
gh repo view --web              open in browser

── undo ───────────────────────────────────────
git reset --soft HEAD~1         undo last commit
git restore .                   discard all changes
git stash                       save for later
git revert abc123               undo pushed commit
```
