# Git and GitHub

> version control. the thing that saves your work and your career.

---

## what is Git

Git is a version control system. it tracks every change you make to your code over time. think of it like save states in a video game — you can go back to any point.

**why it matters:**
- you can undo any mistake, no matter how bad
- you can work on new features without breaking working code
- multiple people can work on the same project without conflicts
- your entire history is saved
- GitHub hosts your code online (backup + portfolio)

**Git** — the tool on your computer
**GitHub** — the website that hosts your Git repositories

---

## core concepts

**repository (repo)** — a project folder tracked by Git. contains all your files and their entire history.

**commit** — a snapshot of your code at a point in time. like a save point. every commit has a message describing what changed.

**branch** — a parallel version of your code. you create a branch to work on a feature without touching the main code. when done, you merge it back.

**remote** — a copy of your repo on a server (GitHub). you push to sync local → remote, pull to sync remote → local.

**staging area** — where you prepare changes before committing. you choose exactly which changes go into the next commit.

```
working directory → staging area → repository → remote
(your files)         (git add)     (git commit)  (git push)
```

---

## setup

```bash
# configure identity (do this once)
git config --global user.name "Abhishek Kumar"
git config --global user.email "your@email.com"
git config --global core.editor "vim"
git config --global init.defaultBranch main

# view config
git config --list

# SSH key setup (do once per machine)
ssh-keygen -t ed25519 -C "your@email.com"
cat ~/.ssh/id_ed25519.pub  # copy this to GitHub Settings > SSH keys

# test connection
ssh -T git@github.com
```

---

## starting a project

```bash
# option 1: new project
mkdir my-project
cd my-project
git init
git add .
git commit -m "initial commit"

# connect to GitHub (create repo on GitHub first)
git remote add origin git@github.com:username/repo.git
git push -u origin main

# option 2: clone existing project
git clone git@github.com:username/repo.git
cd repo

# option 3: clone someone else's project
git clone https://github.com/other/repo.git
```

---

## daily workflow

```bash
# check what has changed
git status                 # overview of changes
git diff                   # what changed in working directory
git diff --staged          # what changed in staging area

# stage changes
git add file.txt           # add specific file
git add .                  # add everything
git add src/               # add directory
git add -p                 # interactively choose what to stage

# commit
git commit -m "add login form validation"

# push to GitHub
git push

# pull latest changes
git pull
git pull --rebase          # cleaner history (rebase instead of merge)

# see history
git log                    # full log
git log --oneline          # compact, one line per commit
git log --oneline --graph  # with branch graph
git log -10                # last 10 commits
git log --author="Abhishek"
git log -- file.txt        # commits that touched this file
```

---

## good commit messages

a good commit message explains WHAT changed and WHY, not HOW.

```bash
# bad messages
git commit -m "fix"
git commit -m "changes"
git commit -m "asdfgh"
git commit -m "updated stuff"

# good messages
git commit -m "fix login form validation for empty email"
git commit -m "add dark mode toggle to navbar"
git commit -m "remove unused dependencies"
git commit -m "refactor API calls into separate lib/api.js"

# conventional commits format (used in real teams)
# type(scope): description

git commit -m "feat(auth): add Google OAuth login"
git commit -m "fix(dashboard): fix goals not loading on mobile"
git commit -m "docs(readme): update deployment instructions"
git commit -m "style(navbar): fix alignment on small screens"
git commit -m "refactor(api): extract fetch helpers into utils"
git commit -m "chore(deps): update dependencies"
```

**types:**
- `feat` — new feature
- `fix` — bug fix
- `docs` — documentation
- `style` — formatting, no logic change
- `refactor` — code restructure, no feature change
- `test` — adding tests
- `chore` — maintenance, deps, config

---

## branching

branches let you work on features or fixes without touching your main working code.

```bash
# see branches
git branch                  # local branches
git branch -r               # remote branches
git branch -a               # all branches

# create and switch
git branch feature-login    # create branch
git checkout feature-login  # switch to it
git checkout -b feature-login  # create AND switch (shortcut)
git switch -c feature-login    # modern way

# switch back
git checkout main
git switch main

# delete branch
git branch -d feature-login        # safe delete (only if merged)
git branch -D feature-login        # force delete
git push origin -d feature-login   # delete remote branch

# see which branch you are on
git status
git branch  # current branch has *
```

---

## merging

merge combines changes from one branch into another.

```bash
# merge feature branch into main
git checkout main
git merge feature-login

# merge with commit message
git merge feature-login -m "merge feature-login"

# abort merge if conflict is too complex
git merge --abort

# merge strategies
git merge --ff-only feature   # only fast-forward (no merge commit)
git merge --no-ff feature     # always create merge commit
git merge --squash feature    # squash all commits into one
```

**merge conflict** — when two branches changed the same lines. Git cannot decide which to keep.

```
<<<<<<< HEAD (your changes)
const name = "Abhishek"
=======
const name = "Abhi Kumar"
>>>>>>> feature-login (incoming changes)
```

to resolve:
1. open the file
2. delete the conflict markers `<<<<<<<` `=======` `>>>>>>>`
3. keep what you want
4. `git add file.txt`
5. `git commit`

---

## rebasing

rebase replays your commits on top of another branch. creates cleaner linear history.

```bash
# rebase feature branch on top of latest main
git checkout feature-login
git rebase main

# interactive rebase — rewrite last 3 commits
git rebase -i HEAD~3

# in the editor you can:
# pick   - keep commit as is
# reword - keep commit but edit message
# squash - combine with previous commit
# drop   - remove commit entirely
# fixup  - like squash but discard message

# after rebase, push requires force (history was rewritten)
git push --force-with-lease   # safer than --force
```

**merge vs rebase:**
- merge: preserves exact history, creates merge commit
- rebase: clean linear history, rewrites commits

use rebase for local cleanup before merging. use merge for combining completed features.

---

## undoing things

```bash
# undo unstaged changes (restore file to last commit)
git checkout -- file.txt
git restore file.txt       # modern way

# unstage a file (keep changes but remove from staging)
git reset HEAD file.txt
git restore --staged file.txt  # modern way

# undo last commit (keep changes in working directory)
git reset HEAD~1           # soft reset
git reset --soft HEAD~1    # same

# undo last commit (keep changes staged)
git reset --mixed HEAD~1

# undo last commit (DISCARD all changes — permanent!)
git reset --hard HEAD~1

# undo a specific commit by creating a new "undo" commit
git revert abc123          # safe, does not rewrite history

# view deleted commits
git reflog                 # last resort, shows all actions

# recover lost commit
git checkout abc123        # go back to that commit
git branch recovery-branch # save it as a branch
```

**safe rule:**
- `git revert` — safe on shared branches (does not rewrite history)
- `git reset` — only on local commits you haven't pushed yet

---

## stashing

temporarily save changes without committing.

```bash
# save current changes
git stash
git stash push -m "work in progress on login"

# list stashes
git stash list

# apply most recent stash (keeps stash)
git stash apply

# apply and remove stash
git stash pop

# apply specific stash
git stash apply stash@{2}

# drop stash
git stash drop
git stash drop stash@{1}

# clear all stashes
git stash clear
```

use case: you are in the middle of a feature, urgent bug comes in, stash your work, fix bug, pop stash and continue.

---

## working with remotes

```bash
# view remotes
git remote -v

# add remote
git remote add origin git@github.com:user/repo.git
git remote add upstream git@github.com:original/repo.git  # for forks

# remove remote
git remote remove origin

# push
git push origin main
git push -u origin main     # set upstream (do once, then just git push)
git push --force-with-lease # force push safely

# pull
git pull                    # fetch + merge
git pull --rebase           # fetch + rebase (cleaner)

# fetch (download but don't merge)
git fetch origin
git fetch --all

# see remote branches
git branch -r

# track remote branch
git checkout --track origin/feature-branch
```

---

## GitHub workflow (for solo projects)

```
1. work on main for small changes
2. create feature branch for larger features
3. push branch to GitHub
4. merge when done
5. delete branch

# typical day
git pull                          # get latest
git checkout -b feature-search    # new branch
# ... write code ...
git add .
git commit -m "feat: add search functionality"
git push origin feature-search    # push branch
# merge on GitHub or locally
git checkout main
git merge feature-search
git push
git branch -d feature-search
```

---

## GitHub workflow (for teams)

```
1. fork the repo (copy to your account)
2. clone your fork
3. create feature branch
4. write code, commit
5. push branch to your fork
6. open Pull Request on GitHub
7. team reviews code
8. address feedback
9. PR is merged
10. delete branch, pull latest main
```

---

## .gitignore

tell Git which files to never track.

```bash
# create .gitignore in project root
nano .gitignore
```

```gitignore
# dependencies
node_modules/
vendor/
.venv/

# environment variables (NEVER commit these)
.env
.env.local
.env.production
*.env

# build output
dist/
build/
out/
.next/

# OS files
.DS_Store        # Mac
Thumbs.db        # Windows
desktop.ini

# IDE files
.vscode/
.idea/
*.swp
*.swo

# logs
*.log
logs/

# temp files
*.tmp
.cache/
```

---

## useful commands

```bash
# search code in all commits
git log -S "function login"    # commits that added/removed this string
git log -G "regex pattern"     # commits matching regex

# who changed what line
git blame file.txt

# see a specific commit
git show abc123
git show HEAD                  # last commit
git show HEAD:file.txt         # file as it was in last commit

# compare branches
git diff main feature-branch
git diff main..feature-branch -- specific-file.txt

# find when a bug was introduced
git bisect start
git bisect bad                 # current commit is broken
git bisect good abc123         # this commit was good
# Git checks out middle commit — test it
git bisect good  # or git bisect bad
# repeat until Git finds the first bad commit
git bisect reset

# clean untracked files
git clean -n    # dry run, show what would be deleted
git clean -fd   # delete untracked files and directories

# archive project
git archive --format=zip HEAD > project.zip
```

---

## tags (marking releases)

```bash
# create tag
git tag v1.0.0
git tag -a v1.0.0 -m "first release"   # annotated tag

# list tags
git tag

# push tags
git push origin v1.0.0
git push origin --tags    # push all tags

# checkout tag
git checkout v1.0.0

# delete tag
git tag -d v1.0.0
git push origin -d v1.0.0
```

---

## GitHub Actions (CI/CD)

automate tasks when you push code.

```yaml
# .github/workflows/deploy.yml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: 20
      
      - name: Install dependencies
        run: npm install
      
      - name: Build
        run: npm run build
      
      - name: Deploy to Vercel
        run: npx vercel --prod --token=${{ secrets.VERCEL_TOKEN }}
```

---

```
=^._.^= commit early. commit often. write good messages.
```
