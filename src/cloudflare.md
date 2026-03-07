# Cloudflare

## What is Cloudflare?

Cloudflare sits **between your visitors and your server** — acting as a reverse proxy, CDN, firewall, and DNS provider all in one. When someone visits your site, the request hits Cloudflare first. Cloudflare decides what to do with it: serve it from cache, block it, or pass it through to your origin server.

You get all this on the **free plan** — which is genuinely one of the best free tiers in tech.

---

## How it Works — The Big Picture

```
Visitor → Cloudflare Edge → Your Server
            ↓
      (cache hit? serve instantly)
      (DDoS? block it)
      (bot? challenge it)
      (slow? compress + optimize)
```

Cloudflare has 300+ data centers globally. Your content is cached at the edge closest to the visitor, so a user in Tokyo gets served from Tokyo — not from your server in Frankfurt.

---

## Core Services

### 1. DNS

Cloudflare's DNS is the fastest in the world (1.1.1.1). When you add your domain to Cloudflare, you point your domain registrar's nameservers to Cloudflare. Then all DNS records are managed from the Cloudflare dashboard.

```
# DNS record types you'll use
A       → points domain to IPv4 address     example.com → 1.2.3.4
AAAA    → points domain to IPv6 address
CNAME   → alias to another domain           www → example.com
MX      → mail server records
TXT     → verification records (Google, SPF, DKIM)
```

**Proxy toggle (orange cloud)** — when enabled, traffic routes through Cloudflare. When disabled (grey cloud), it's DNS only — no Cloudflare benefits. Always enable it for web traffic.

---

### 2. CDN (Content Delivery Network)

Cloudflare caches your static assets (images, CSS, JS, fonts) at edge nodes worldwide.

```
# Cache behaviour by default
- HTML         → NOT cached (dynamic)
- CSS/JS/fonts → cached
- Images       → cached
- API responses → NOT cached
```

**Cache rules** — you can override this:
- Cache everything (useful for static sites)
- Bypass cache for `/admin/*`
- Set custom TTL per file type

**Cache purge** — after a deploy, purge the cache so visitors get fresh files:
- Dashboard → Caching → Purge Everything
- Or via API for CI/CD pipelines

---

### 3. DDoS Protection

Free, automatic, always on. Cloudflare absorbs the traffic so your server never sees the flood.

- Handles L3/L4 attacks (network layer)
- Handles L7 attacks (HTTP floods)
- No config needed on free plan — just works

---

### 4. Firewall / WAF

Block bad traffic before it reaches your server.

**Security levels** (Dashboard → Security → Settings):
```
Off        → no challenges
Essentially off → only known bad actors
Low        → fewer challenges
Medium     → default, good balance
High       → aggressive, may affect legit users
I'm Under Attack → JS challenge on every visitor
```

**Firewall Rules** (free: 5 rules):
```
# Block a country
(ip.geoip.country eq "CN")  → Block

# Block bad bots
(cf.client.bot)  → Block

# Rate limit a path
(http.request.uri.path eq "/api/login")  → Challenge

# Allow only your IP to /admin
(http.request.uri.path contains "/admin" and not ip.src eq 1.2.3.4) → Block
```

---

### 5. SSL/TLS

Free SSL certificate, auto-renewed, zero config.

**SSL modes** (Dashboard → SSL/TLS):
```
Off           → HTTP only (never use this)
Flexible      → HTTPS to visitor, HTTP to origin (avoid — insecure)
Full          → HTTPS to visitor, HTTPS to origin (self-signed OK)
Full (Strict) → HTTPS to visitor, valid cert on origin (best)
```

Always use **Full (Strict)** if your server has a real cert. Use **Full** if it has a self-signed cert.

**Always use HTTPS** — enable in SSL/TLS → Edge Certificates → toggle on. Redirects all HTTP → HTTPS automatically.

---

### 6. Pages (Static Site Hosting)

Deploy static sites directly on Cloudflare's network. No server needed.

```bash
# Deploy via CLI
npm install -g wrangler
wrangler pages deploy ./dist --project-name my-site

# Or connect GitHub repo in dashboard
# Cloudflare Pages → Create project → Connect to Git
```

- Free tier: unlimited sites, 500 builds/month, custom domains
- Automatic deployments on git push
- Preview deployments for every branch
- Way faster than GitHub Pages (global CDN vs single region)

**This is what you should use for visual-site / mirage instead of GitHub Pages.**

---

### 7. Workers (Serverless Functions)

Run JavaScript/TypeScript at the edge — 300+ locations, ~0ms cold start.

```javascript
// Basic worker — intercept requests
export default {
  async fetch(request, env) {
    const url = new URL(request.url)

    // redirect /old-page to /new-page
    if (url.pathname === '/old-page') {
      return Response.redirect('https://example.com/new-page', 301)
    }

    // add a custom header to all responses
    const response = await fetch(request)
    const newResponse = new Response(response.body, response)
    newResponse.headers.set('X-Custom-Header', 'hello')
    return newResponse
  }
}
```

**Free tier:** 100,000 requests/day, 10ms CPU per request

**Use cases:**
- A/B testing
- Auth middleware
- API proxying (hide your backend URL)
- Redirect rules
- Bot detection
- Geolocation-based responses

---

### 8. Workers KV (Key-Value Store)

A global key-value database that lives at the edge. Workers can read/write from it.

```javascript
// In a Worker
await env.MY_KV.put('user:123', JSON.stringify({ name: 'Abhishek' }))
const user = await env.MY_KV.get('user:123', 'json')
```

**Free tier:** 100,000 reads/day, 1,000 writes/day, 1GB storage

---

### 9. R2 (Object Storage)

S3-compatible object storage — store images, videos, files. No egress fees (unlike AWS S3).

```javascript
// Upload via Worker
await env.MY_BUCKET.put('image.png', imageBuffer, {
  httpMetadata: { contentType: 'image/png' }
})

// Get a file
const object = await env.MY_BUCKET.get('image.png')
```

**Free tier:** 10GB storage, 1M read operations/month, 10M write operations/month

**Use instead of S3** for any project — same API, no cost for bandwidth.

---

### 10. Tunnel (Cloudflare Tunnel)

Expose a local server to the internet **without opening ports** or needing a public IP. Great for self-hosting.

```bash
# Install cloudflared
curl -L https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg

# Authenticate
cloudflared tunnel login

# Create a tunnel
cloudflared tunnel create my-tunnel

# Route traffic
cloudflared tunnel route dns my-tunnel myapp.example.com

# Run it (forwards localhost:3000 to the internet)
cloudflared tunnel run --url localhost:3000 my-tunnel
```

**Use cases:**
- Access your homelab from anywhere
- Share a local dev server without ngrok
- Self-host apps on a Raspberry Pi

---

### 11. Analytics

Free, privacy-respecting analytics — no cookies, no GDPR issues, no JavaScript required.

Dashboard → Analytics → Traffic:
- Requests, bandwidth, cached vs uncached
- Top countries, top paths
- Threat stats (blocked requests)

Not as detailed as Google Analytics but great for seeing traffic patterns without tracking users.

---

### 12. Email Routing

Forward emails from `@yourdomain.com` to any email address. Free.

```
hello@abhishekkumar.xyz → your.gmail@gmail.com
support@abhishekkumar.xyz → your.gmail@gmail.com
```

Dashboard → Email → Email Routing → Add address. No mail server needed.

---

## Practical Setup: New Project Checklist

```bash
# 1. Add your domain to Cloudflare
#    → cloudflare.com → Add site → enter domain → free plan

# 2. Update nameservers at your registrar
#    → Cloudflare gives you 2 nameservers to point to
#    → Takes up to 24h to propagate (usually 15min)

# 3. SSL → set to Full (Strict)

# 4. Enable Always Use HTTPS

# 5. Enable Brotli compression (Speed → Optimization)

# 6. Set up DNS records for your services

# 7. Enable Auto Minify for HTML/CSS/JS (Speed → Optimization)
```

---

## For Your Current Projects

### notes-site / mirage

Move from GitHub Pages to Cloudflare Pages:

```bash
# In Cloudflare dashboard
# Pages → Create project → Connect to GitHub
# Select repo → set build command and output dir

# For notes-site (bash build)
# Build command: bash build.sh
# Output directory: output

# For mirage (static HTML)
# Build command: (leave empty)
# Output directory: (root)
```

Then add custom domain:
```
Pages project → Custom domains → Add domain
→ notes.abhishekkumar.xyz
→ visual.abhishekkumar.xyz
```

Cloudflare auto-provisions SSL and creates the DNS record.

### Protect your API

If you have a FastAPI/Express backend:

```
# Firewall rule — block all direct origin access
# Only allow traffic through Cloudflare
(not cf.tls_client_auth.cert_verified) → Block non-CF traffic

# Rate limit login endpoint
(http.request.uri.path eq "/api/login") → 5 req/min per IP
```

---

## Key Free Plan Limits

| Service        | Free Limit                          |
|----------------|-------------------------------------|
| DNS            | Unlimited                           |
| CDN/Proxy      | Unlimited bandwidth                 |
| SSL            | Free, auto-renewed                  |
| Pages          | 500 builds/month, unlimited sites   |
| Workers        | 100,000 req/day                     |
| Workers KV     | 100K reads, 1K writes/day           |
| R2             | 10GB storage, no egress fees        |
| Firewall rules | 5 custom rules                      |
| Email Routing  | 200 routing addresses               |
| Analytics      | Unlimited                           |
| Tunnel         | Unlimited (free with account)       |

---

## Quick Reference — Dashboard Locations

```
DNS records          → DNS → Records
SSL mode             → SSL/TLS → Overview
Always HTTPS         → SSL/TLS → Edge Certificates
Cache purge          → Caching → Configuration → Purge
Firewall rules       → Security → WAF → Firewall rules
Security level       → Security → Settings
Page rules           → Rules → Page Rules
Speed / compression  → Speed → Optimization
Analytics            → Analytics → Traffic
Pages deploy         → Workers & Pages → Pages
Workers              → Workers & Pages → Workers
R2 buckets           → R2 Object Storage
Tunnel               → Zero Trust → Access → Tunnels
Email routing        → Email → Email Routing
```
