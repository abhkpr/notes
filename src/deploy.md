# GitHub + Cloudflare — Full Developer Workflow

## The Big Picture

```
you write code
      ↓
git push → GitHub repo
      ↓
GitHub Actions (optional CI/CD)
      ↓
Cloudflare Pages (build + host)
      ↓
Cloudflare CDN (cache + serve globally)
      ↓
Cloudflare DNS (routes domain → CDN)
      ↓
visitor types your domain → gets your site in <50ms
```

Every piece has one job. GitHub stores and versions your code. Cloudflare Pages builds and hosts it. Cloudflare CDN serves it fast globally. Cloudflare DNS connects your domain to all of it.

---

## Part 1 — GitHub

### What GitHub Actually Is

GitHub is three things in one:

```
1. Remote git storage     → your code lives here, backed up, versioned
2. Collaboration layer    → PRs, issues, reviews, forks
3. Automation platform    → GitHub Actions runs your CI/CD pipelines
```

### Repository Structure

```
my-project/
├── .github/
│   └── workflows/
│       └── deploy.yml      ← GitHub Actions config
├── src/                    ← your source code
├── public/                 ← static assets
├── package.json
└── README.md
```

### GitHub Actions — Automated Pipelines

When you push code, GitHub Actions can automatically:
- run tests
- build your project
- deploy to Cloudflare Pages
- send notifications

```yaml
# .github/workflows/deploy.yml
name: Deploy to Cloudflare Pages

on:
  push:
    branches: [main]        # triggers on every push to main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Install dependencies
        run: npm install

      - name: Build
        run: npm run build

      - name: Deploy to Cloudflare Pages
        uses: cloudflare/pages-action@v1
        with:
          apiToken: ${{ secrets.CLOUDFLARE_API_TOKEN }}
          accountId: ${{ secrets.CLOUDFLARE_ACCOUNT_ID }}
          projectName: my-project
          directory: dist        # output folder after build
```

### GitHub Secrets

Never hardcode API keys. Store them in GitHub Secrets:

```
repo → Settings → Secrets and variables → Actions → New repository secret
```

Then access in workflows as `${{ secrets.SECRET_NAME }}`.

---

## Part 2 — Cloudflare Pages

### What Cloudflare Pages Is

Cloudflare Pages is a hosting platform for static sites and frontend apps. You connect your GitHub repo, Cloudflare builds it on every push, and deploys it globally on their network.

```
GitHub repo → Cloudflare Pages → 300+ edge locations worldwide
```

Free tier gives you:
- unlimited sites
- 500 builds/month
- unlimited bandwidth
- custom domains with free SSL
- preview deployments for every branch

### How to Connect GitHub → Cloudflare Pages

```
1. cloudflare.com → Workers & Pages → Pages → Create a project
2. Connect to Git → authorize GitHub → select your repo
3. Set build settings:

   Framework preset:   (pick your framework or None)
   Build command:      npm run build   (or bash build.sh for static)
   Build output dir:   dist            (or output, public, etc.)
   Root directory:     /               (leave blank usually)

4. Click Save and Deploy
```

Cloudflare Pages then:
- clones your repo
- runs the build command
- takes the output directory
- deploys it globally

### Build Settings by Project Type

```
Static HTML (no build step)
  Build command:     (leave empty)
  Output directory:  /  or  public

Bash build script (like your notes-site)
  Build command:     bash build.sh
  Output directory:  output

React / Vite
  Build command:     npm run build
  Output directory:  dist

Next.js
  Build command:     npm run build
  Output directory:  .next

SvelteKit
  Build command:     npm run build
  Output directory:  build
```

### Preview Deployments

Every branch and PR gets its own preview URL automatically:

```
main branch        →  my-project.pages.dev          (production)
feature/navbar     →  abc123.my-project.pages.dev   (preview)
fix/bug            →  def456.my-project.pages.dev   (preview)
```

This means you can share a preview link with anyone before merging. No extra config needed — it just works.

### Environment Variables in Pages

```
Pages project → Settings → Environment variables

Key: API_BASE_URL
Value: https://api.myapp.com
Environment: Production / Preview / Both
```

Access in your code:
```javascript
const apiUrl = process.env.API_BASE_URL
```

---

## Part 3 — Cloudflare DNS

### What DNS Does

DNS translates your domain name into an IP address. Without DNS:

```
visitor types:  abhishekkumar.xyz
without DNS:    visitor has no idea where to go
with DNS:       abhishekkumar.xyz → 104.21.x.x (Cloudflare's IP)
                Cloudflare knows to serve your Pages project
```

### Adding Your Domain to Cloudflare

```
1. cloudflare.com → Add a site → enter your domain
2. Pick free plan
3. Cloudflare scans your existing DNS records
4. Cloudflare gives you 2 nameservers:
   e.g.  ava.ns.cloudflare.com
         bob.ns.cloudflare.com
5. Go to your domain registrar (GoDaddy, Namecheap, etc.)
   → change nameservers to the ones Cloudflare gave you
6. Wait 5–30 minutes for propagation
7. Done — Cloudflare now controls your DNS
```

### DNS Record Types

```
A        domain → IPv4 address
         example.com → 76.76.21.21

AAAA     domain → IPv6 address

CNAME    domain → another domain (alias)
         www → example.com
         blog → username.github.io

MX       mail server
         @ → mail.example.com  (handles email)

TXT      text records (verification, SPF, DKIM)
         @ → "v=spf1 include:_spf.google.com ~all"

NS       nameserver records (set by Cloudflare automatically)
```

### The Orange Cloud — Proxied vs DNS Only

This is the most important concept in Cloudflare DNS:

```
Orange cloud (proxied) ☁️  →  traffic goes through Cloudflare
                              get CDN, DDoS protection, firewall, SSL
                              visitor sees Cloudflare's IP, not yours

Grey cloud (DNS only)  ☁️  →  just DNS, no Cloudflare features
                              visitor connects directly to your server
                              use for: mail, FTP, SSH, non-HTTP services
```

**Always use orange cloud for web traffic.**

### Setting Up DNS for Cloudflare Pages

When you add a custom domain in Pages, Cloudflare creates the DNS record automatically. But if you do it manually:

```
Type:   CNAME
Name:   @  (or www, or blog, or visual)
Target: your-project.pages.dev
Proxy:  ON (orange cloud)
```

```
# examples for your projects
Type    Name      Target                          Proxy
CNAME   @         notes-site.pages.dev            ON
CNAME   visual    mirage.pages.dev                ON
CNAME   www       abhishekkumar.xyz               ON
```

### Subdomains

```bash
# app.abhishekkumar.xyz → notes-site
Type: CNAME  Name: app    Target: notes-site.pages.dev

# visual.abhishekkumar.xyz → mirage
Type: CNAME  Name: visual  Target: mirage.pages.dev

# api.abhishekkumar.xyz → your backend server
Type: A      Name: api     Target: 1.2.3.4 (your server IP)
```

---

## Part 4 — Cloudflare CDN

### What the CDN Does

CDN = Content Delivery Network. Cloudflare has 300+ data centers worldwide. When a visitor requests your site:

```
without CDN:
  visitor in Tokyo → request travels to your server in Frankfurt → 200ms

with Cloudflare CDN:
  visitor in Tokyo → Cloudflare Tokyo edge → cached copy served → 20ms
```

The first request hits your origin (Pages). Cloudflare caches the response. Every request after that is served from the nearest edge — fast.

### What Gets Cached by Default

```
Cached automatically:
  images       .jpg .png .gif .webp .svg .ico
  styles       .css
  scripts      .js
  fonts        .woff .woff2 .ttf
  documents    .pdf

NOT cached by default:
  HTML         .html  (because it can be dynamic)
  API routes   /api/*
  anything with Cache-Control: no-cache header
```

### Cache Rules — Control What Gets Cached

Go to: **Cloudflare Dashboard → Rules → Cache Rules**

```
# Cache everything (for fully static sites like mirage)
If: hostname equals visual.abhishekkumar.xyz
Then: Cache Level = Cache Everything
      Edge TTL = 1 day

# Cache HTML too for static site
If: URI path ends with .html
Then: Cache Level = Cache Everything
      Edge TTL = 4 hours

# Never cache admin or API
If: URI path starts with /api
Then: Cache Level = Bypass
```

### Cache TTL (Time To Live)

How long Cloudflare keeps a cached copy before fetching fresh from origin:

```
Browser TTL    how long visitor's browser caches it
Edge TTL       how long Cloudflare's servers cache it

Recommended for static sites:
  HTML files:    Edge TTL = 4 hours   (changes sometimes)
  CSS/JS:        Edge TTL = 1 week    (versioned, rarely changes)
  Images:        Edge TTL = 1 month   (almost never changes)
  Fonts:         Edge TTL = 1 year    (never changes)
```

### Purging Cache After a Deploy

After you push new code and it deploys, Cloudflare might still serve the old cached version to visitors. Purge it:

```bash
# Option 1: Dashboard
# Cloudflare → Caching → Configuration → Purge Everything

# Option 2: CLI via API (good for CI/CD)
curl -X POST "https://api.cloudflare.com/client/v4/zones/ZONE_ID/purge_cache" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{"purge_everything":true}'

# Option 3: Purge specific files only
curl -X POST "https://api.cloudflare.com/client/v4/zones/ZONE_ID/purge_cache" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{"files":["https://yourdomain.com/index.html","https://yourdomain.com/style.css"]}'
```

### Cloudflare Pages Auto-Purges Cache

Good news — when you deploy via Cloudflare Pages, it automatically purges the CDN cache for you. You only need to manually purge if you're using a separate origin server.

---

## Part 5 — SSL / HTTPS

Cloudflare handles SSL automatically. Zero config.

```
visitor → HTTPS → Cloudflare edge (valid SSL cert)
                        ↓
               Cloudflare → your origin (SSL or not)
```

### SSL Modes

```
Off           HTTP only — never use this
Flexible      HTTPS to visitor, HTTP to origin — avoid (insecure)
Full          HTTPS to both, self-signed cert OK on origin
Full (Strict) HTTPS to both, valid cert required on origin — best
```

For Cloudflare Pages: always use **Full (Strict)** — Pages provides a valid cert automatically.

```
SSL/TLS → Overview → Full (Strict)
SSL/TLS → Edge Certificates → Always Use HTTPS → ON
SSL/TLS → Edge Certificates → Minimum TLS Version → TLS 1.2
```

---

## Part 6 — Full Deployment Architecture

### Static Site (notes-site / mirage)

```
┌─────────────────────────────────────────────────────────┐
│                    YOUR MACHINE                         │
│  write markdown/HTML → git push                         │
└─────────────────────────┬───────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│                      GITHUB                             │
│  stores code, triggers Pages build on push              │
└─────────────────────────┬───────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│               CLOUDFLARE PAGES                          │
│  runs build command → outputs static files              │
│  deploys to 300+ edge locations                         │
└─────────────────────────┬───────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│                 CLOUDFLARE CDN + DNS                    │
│  DNS: app.abhishekkumar.xyz → pages.dev                 │
│  CDN: serves cached files from nearest edge             │
│  SSL: HTTPS auto-provisioned                            │
│  DDoS: protected automatically                          │
└─────────────────────────┬───────────────────────────────┘
                          ↓
                      VISITOR
               gets your site in <50ms
               from nearest edge globally
```

### Full-Stack App (frontend + backend)

```
┌──────────────────────────────────────────────┐
│  GitHub repo                                 │
│  ├── frontend/   → Cloudflare Pages          │
│  └── backend/    → your VPS / Railway / Fly  │
└──────────────────────────────────────────────┘

DNS setup:
  app.yourdomain.com    CNAME → pages project   (frontend)
  api.yourdomain.com    A     → VPS IP          (backend)

Cloudflare proxy:
  app subdomain  → ON  (CDN + DDoS for frontend)
  api subdomain  → ON  (DDoS protection for API)
```

---

## Part 7 — Complete Setup Walkthrough

### Step 1 — Create repo and push code

```bash
mkdir my-site && cd my-site
echo "<h1>Hello</h1>" > index.html
git init && git add -A && git commit -m "init"
gh repo create my-site --public --source=. --push
```

### Step 2 — Connect to Cloudflare Pages

```
Cloudflare Dashboard
→ Workers & Pages
→ Pages → Create a project
→ Connect to Git → select GitHub → select my-site repo
→ Build settings:
    Build command:    (empty for plain HTML)
    Output dir:       /
→ Save and Deploy
```

Your site is now live at `my-site.pages.dev`.

### Step 3 — Add your domain to Cloudflare

```
Cloudflare Dashboard → Add a site → yourdomain.com
→ Free plan
→ Copy the 2 nameservers Cloudflare gives you
→ Go to your registrar → update nameservers
→ Wait for propagation (usually 15 min)
```

### Step 4 — Add custom domain to Pages

```
Pages project → Custom domains → Set up a custom domain
→ Enter: yourdomain.com (or app.yourdomain.com)
→ Cloudflare automatically creates DNS record
→ SSL certificate provisioned in ~1 min
```

### Step 5 — Configure SSL

```
SSL/TLS → Overview → Full (Strict)
SSL/TLS → Edge Certificates → Always Use HTTPS → ON
```

### Step 6 — Set up cache rules (optional but good)

```
Rules → Cache Rules → Create rule
Name: Cache static assets
If: hostname = yourdomain.com
Then: Cache Everything
      Edge TTL: 1 day
```

### Step 7 — Push to deploy

From now on, every push to `main`:

```bash
git add -A
git commit -m "update content"
git push
# → GitHub notifies Cloudflare Pages
# → Pages rebuilds
# → deploys globally
# → cache purged automatically
# → visitors get new version
```

---

## For Your Projects

### notes-site → app.abhishekkumar.xyz

```
Repo:          github.com/you/notes-site
Pages project: notes-site
Build command: bash build.sh
Output dir:    output
Domain:        app.abhishekkumar.xyz

DNS record (auto-created by Pages):
  CNAME  app  →  notes-site.pages.dev  (proxied)
```

### mirage → visual.abhishekkumar.xyz

```
Repo:          github.com/you/mirage
Pages project: mirage
Build command: (empty — pure static HTML)
Output dir:    /
Domain:        visual.abhishekkumar.xyz

DNS record (auto-created by Pages):
  CNAME  visual  →  mirage.pages.dev  (proxied)
```

---

## Quick Reference

```
── github ─────────────────────────────────────────
git push origin main          triggers Pages build
.github/workflows/deploy.yml  CI/CD pipeline config
Settings → Secrets            store API tokens safely
gh run list                   see build status

── cloudflare pages ───────────────────────────────
Workers & Pages → Pages       create/manage projects
Settings → Builds             build command + output dir
Settings → Environment vars   API keys for build
Custom domains                connect your domain
Deployments                   see all deploy history
branch-name.project.pages.dev preview URL per branch

── cloudflare dns ─────────────────────────────────
DNS → Records                 manage all DNS records
Orange cloud = ON             proxied (CDN + protection)
Grey cloud = OFF              DNS only (mail, SSH, FTP)
CNAME @ → project.pages.dev  point domain to Pages

── cloudflare cdn ─────────────────────────────────
Caching → Configuration       cache settings
Rules → Cache Rules           custom cache per path
Purge Everything              clear cache after deploy
Edge TTL                      how long CF caches files

── ssl ────────────────────────────────────────────
SSL/TLS → Full (Strict)       correct mode for Pages
Always Use HTTPS → ON         force HTTPS everywhere
```
