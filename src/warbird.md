# warbird site — documentation

---

## table of contents

- [project structure](#project-structure)
- [daily workflow](#daily-workflow)
- [writing blog posts](#writing-blog-posts)
- [managing projects](#managing-projects)
- [updating about page](#updating-about-page)
- [adding social links](#adding-social-links)
- [customizing the look](#customizing-the-look)
- [custom domain setup](#custom-domain-setup)
- [troubleshooting](#troubleshooting)

---

## project structure

```
~/warbird/
├── .github/
│   └── workflows/
│       └── deploy.yml       ← github actions auto deploy
├── content/
│   ├── blog/                ← all blog posts go here
│   │   └── first-flight.md
│   ├── projects/
│   │   └── index.md         ← projects page
│   └── about.md             ← about page
├── themes/
│   └── warbird/
│       ├── layouts/         ← html templates
│       └── static/
│           └── css/
│               └── main.css ← all styles
└── hugo.toml                ← site config
```

---

## daily workflow

```bash
# 1. go to project
cd ~/warbird

# 2. make your changes (write post, edit page etc)

# 3. preview locally
hugo server
# open localhost:1313 in firefox

# 4. when happy, push to live
git add .
git commit -m "what you did"
git push

# site goes live in ~2 minutes automatically
```

---

## writing blog posts

every post is a markdown file inside `content/blog/`

**create a new post:**
```bash
nano ~/warbird/content/blog/your-post-name.md
```

**required front matter at the top:**
```markdown
---
title: "Your Post Title"
date: 2026-03-04
summary: "one line that shows on homepage and blog list"
---

your content starts here...
```

**example post:**
```markdown
---
title: "Learning Vim"
date: 2026-03-04
summary: "why i switched to vim and never looked back"
---

## why vim

started using vim because i wanted full keyboard control...

## keybinds i use daily

- `dd` to delete a line
- `yy` to copy a line
- `p` to paste

## conclusion

vim is hard at first but worth it.
```

**push it live:**
```bash
git add .
git commit -m "post: learning vim"
git push
```

**naming convention for post files:**
```
good: learning-vim.md
good: my-cp-journey.md
bad:  My Post.md
bad:  post1.md
```

---

## managing projects

edit the projects page:
```bash
nano ~/warbird/content/projects/index.md
```

**format for each project:**
```markdown
## project name
what it does, one or two lines
[visit →](https://link-to-project.com)

## another project
description here
[github →](https://github.com/abhkpr/repo)
```

**push:**
```bash
git add .
git commit -m "projects: add new project"
git push
```

---

## updating about page

```bash
nano ~/warbird/content/about.md
```

front matter must stay at top:
```markdown
---
title: "About"
layout: "about"
date: 2026-03-01
---

your about content here
```

update this whenever:
- you learn something new
- you start a new project
- your stack changes
- you want to add/remove social links

---

## adding social links

**STEP 1 — add to hugo.toml:**
```bash
nano ~/warbird/hugo.toml
```

add your links in the `[params]` section:
```toml
[params]
  description = "thoughts, projects and notes"
  author = "Abhishek Kumar"
  github = "https://github.com/abhkpr"
  notes = "https://abhkpr.github.io/notes"
  twitter = "https://twitter.com/yourhandle"
  linkedin = "https://linkedin.com/in/yourname"
```

**STEP 2 — add to about layout:**
```bash
nano ~/warbird/themes/warbird/layouts/page/about.html
```

add links inside `.social-links` div:
```html
<div class="social-links">
    <a href="{{ .Site.Params.github }}" target="_blank">github</a>
    <a href="{{ .Site.Params.notes }}" target="_blank">notes</a>
    <a href="{{ .Site.Params.twitter }}" target="_blank">twitter</a>
    <a href="{{ .Site.Params.linkedin }}" target="_blank">linkedin</a>
</div>
```

---

## customizing the look

all styles are in one file:
```bash
nano ~/warbird/themes/warbird/static/css/main.css
```

**color variables at the top — change these to retheme entire site:**
```css
:root {
    --bg:        #1a1a14;   /* main background */
    --bg2:       #222218;   /* secondary background */
    --cream:     #e8dcc8;   /* main text color */
    --olive:     #6b7c3a;   /* primary accent */
    --olive-lt:  #8a9e4a;   /* lighter accent */
    --amber:     #c8a84b;   /* hover color */
    --muted:     #8a8a7a;   /* muted text */
    --border:    #3a3a2a;   /* border color */
}
```

**fonts:**
```css
:root {
    --font-head: 'Special Elite', cursive;  /* headings */
    --font-mono: 'Share Tech Mono', monospace; /* body */
}
```

to change fonts go to `themes/warbird/layouts/_default/baseof.html`
and update the google fonts import link

---

## custom domain setup

when you get a domain (free .tech from github student pack etc):

**STEP 1 — update hugo.toml:**
```bash
nano ~/warbird/hugo.toml
```
```toml
baseURL = "https://yourdomain.tech/"
```

**STEP 2 — add CNAME file:**
```bash
echo "yourdomain.tech" > ~/warbird/static/CNAME
```

**STEP 3 — DNS settings on your registrar:**

add these records:
```
Type: A     Name: @    Value: 185.199.108.153
Type: A     Name: @    Value: 185.199.109.153
Type: A     Name: @    Value: 185.199.110.153
Type: A     Name: @    Value: 185.199.111.153
Type: CNAME Name: www  Value: abhkpr.github.io
```

**STEP 4 — enable on github:**
- repo settings → pages
- custom domain → enter your domain
- enable enforce https

**STEP 5 — push and wait:**
```bash
git add .
git commit -m "add custom domain"
git push
```

DNS takes 10-30 mins to propagate

---

## troubleshooting

**site not updating after push:**
- check Actions tab on github — is workflow green?
- if red, check the error in the failed step
- wait 2-3 mins after green before checking live site

**local preview broken:**
```bash
hugo server --disableFastRender
```

**workflow permissions error:**
- repo → settings → actions → general
- set read and write permissions
- re-run failed jobs

**post not showing up:**
- check date in front matter is not in the future
- check file is inside `content/blog/`
- check SUMMARY is correct

**styles not loading:**
- check `baseURL` in hugo.toml matches your actual url
- clear browser cache `ctrl + shift + r`

---

## quick reference

| task | command |
|---|---|
| new blog post | `nano content/blog/name.md` |
| preview locally | `hugo server` |
| push live | `git add . && git commit -m "" && git push` |
| edit styles | `nano themes/warbird/static/css/main.css` |
| edit config | `nano hugo.toml` |
| edit about | `nano content/about.md` |
| edit projects | `nano content/projects/index.md` |

---

```
✈ wheels up. keep writing, keep pushing.
```
