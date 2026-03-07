# Git & GitHub Cheatsheet

> version control. the thing that saves your ass.

---

## what is git

git tracks changes in your files over time.  
think of it like **save states in a video game** — you can go back to any point.

github is just a website that hosts your git repos online.

```
your laptop  →  git  →  github
(local)          (tool)    (remote)
```

---

## the mental model

```
working directory   →   staging area   →   repository
(files you edit)        (what you're         (saved history)
                         about to save)

    git add                git commit
```

---

## setup (do this once)

```bash
git config --global user.name "yourname"
git config --global user.email "youremail@gmail.com"
```

---

## starting a repo

```bash
# start fresh
git init

# or clone existing from github
git clone git@github.com:username/reponame.git
```

---

## daily workflow

```bash
# check what changed
git status

# see exact changes
git diff

# stage files
git add filename.md        # specific file
git add .                  # everything

# commit (save snapshot)
git commit -m "what you did"

# push to github
git push

# pull latest from github
git pull
```

---

## commit messages

keep them short and clear:

```bash
git commit -m "add vim notes"
git commit -m "fix typo in readme"
git commit -m "update git cheatsheet"
```

bad:
```bash
git commit -m "stuff"
git commit -m "asdfgh"
git commit -m "changes"
```

---

## branches

branches let you work on something without breaking the main stuff

```bash
# see all branches
git branch

# create new branch
git branch feature-x

# switch to it
git checkout feature-x

# shortcut — create and switch
git checkout -b feature-x

# merge back to main
git checkout main
git merge feature-x

# delete branch after merge
git branch -d feature-x
```

---

## undoing things

```bash
# unstage a file
git restore --staged filename.md

# discard changes in working dir (careful — permanent)
git restore filename.md

# undo last commit but keep changes
git reset --soft HEAD~1

# see commit history
git log --oneline
```

---

## remote (github)

```bash
# see remote urls
git remote -v

# add remote
git remote add origin git@github.com:username/repo.git

# change remote url
git remote set-url origin git@github.com:username/repo.git

# push for first time
git push -u origin main

# push after that
git push
```

---

## ssh setup (one time)

```bash
# generate key
ssh-keygen -t ed25519 -C "youremail@gmail.com"

# copy public key
cat ~/.ssh/id_ed25519.pub

# paste it on github → settings → ssh keys

# test it
ssh -T git@github.com
```

---

## common situations

**i messed up my last commit message:**
```bash
git commit --amend -m "correct message"
```

**i want to see what changed between commits:**
```bash
git log --oneline
git diff abc123 def456
```

**i accidentally committed to main, want a branch:**
```bash
git checkout -b new-branch
git checkout main
git reset --soft HEAD~1
```

**pull has conflicts:**
```bash
# open the conflicting file, look for:
<<<<<<< HEAD
your changes
=======
their changes
>>>>>>> main

# pick what to keep, delete the markers
# then:
git add .
git commit -m "resolve conflict"
```

---

## git ignore

create `.gitignore` to tell git what to ignore:

```bash
nano .gitignore
```

```
node_modules/
.env
*.log
__pycache__/
.DS_Store
```

---

## cheatsheet

| command | what it does |
|---|---|
| `git init` | start a repo |
| `git status` | see what changed |
| `git add .` | stage everything |
| `git commit -m ""` | save snapshot |
| `git push` | upload to github |
| `git pull` | download from github |
| `git clone` | copy a repo |
| `git log --oneline` | see history |
| `git branch` | list branches |
| `git checkout -b` | new branch |
| `git merge` | merge branch |
| `git diff` | see changes |

---


```
=^._.^= ノ  commit early, commit often
```
