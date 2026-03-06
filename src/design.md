# Designing UI, Database and System Architecture

> think before you build. design saves you from rewriting everything.

---

## the order of design

most beginners open VS Code immediately. professionals do this first:

```
1. understand the problem
2. design the data (database)
3. design the system (architecture)
4. design the interface (UI/UX)
5. then write code
```

data design first because everything else depends on it. your UI is just a window into your data. your architecture is just how data moves around.

---

# part 1: UI design

## the design process

```
understand users
      ↓
information architecture
      ↓
wireframes (low fidelity)
      ↓
design system (colors, fonts, spacing)
      ↓
high fidelity mockups
      ↓
prototype (interactive)
      ↓
build
      ↓
test with real users
      ↓
iterate
```

---

## step 1: understand your users

before drawing anything, answer these:

**who uses this?**
- age, tech comfort level, device (mobile/desktop)
- what do they want to accomplish
- what frustrates them in current solutions

**what are the core user goals?**
```
example: StudentOS
user goal 1: track what i want to do today
user goal 2: log what i actually did
user goal 3: see my progress over time
user goal 4: get motivation when stuck

NOT a user goal: "use the app"
```

**what is the one thing a user does every single day?**
design your entire interface around that one thing. everything else is secondary.

---

## step 2: information architecture

IA is the skeleton of your app. what pages exist, how they connect, what lives where.

**site map — every page and its relationships:**
```
/ (home/landing)
├── /login
├── /signup
│   └── /verify-email
├── /dashboard          ← main page after login
│   ├── /goals          ← daily goals
│   ├── /log            ← daily learning log
│   └── /stats          ← progress/analytics
├── /profile
│   └── /profile/edit
└── /settings
```

**navigation structure:**
```
primary nav:   things users visit daily (dashboard, goals, log)
secondary nav: things users visit occasionally (profile, settings)
utility nav:   logout, help, notifications
```

**rule:** if a user needs more than 3 clicks to reach something they use daily, it is buried too deep.

---

## step 3: user flows

map every path a user takes. draw this before wireframing.

```
new user flow:
landing page → signup → onboarding → dashboard

returning user flow:
login page → dashboard

create goal flow:
dashboard → click "add goal" → type goal → press enter → goal appears

complete goal flow:
dashboard → see goal → click checkbox → goal marked done → confetti?

error flow:
login → wrong password → error message → try again OR forgot password
```

for every flow, also design the **sad path** — what happens when things go wrong. network error, empty state, validation failure.

---

## step 4: wireframes

wireframes are fast sketches. no color. no fonts. just boxes showing layout.

**do this on paper first.** a pencil sketch takes 2 minutes. the same thing in Figma takes 20.

```
desktop wireframe:
┌─────────────────────────────────────────────┐
│  [logo]    [nav]  [nav]  [nav]    [avatar]  │ ← navbar
├─────────────────────────────────────────────┤
│          │                                  │
│  sidebar │   main content area              │
│          │                                  │
│  [link]  │   ┌──────────────────────────┐   │
│  [link]  │   │  card                    │   │
│  [link]  │   └──────────────────────────┘   │
│  [link]  │                                  │
│          │   ┌──────────────────────────┐   │
│          │   │  card                    │   │
│          │   └──────────────────────────┘   │
└─────────────────────────────────────────────┘

mobile wireframe (same page):
┌──────────────────┐
│ [☰]    [logo]    │ ← navbar (sidebar hidden)
├──────────────────┤
│                  │
│  ┌────────────┐  │
│  │  card      │  │
│  └────────────┘  │
│                  │
│  ┌────────────┐  │
│  │  card      │  │
│  └────────────┘  │
│                  │
└──────────────────┘
```

**wireframe every state:**
- default (has data)
- empty state (no data yet)
- loading state
- error state
- mobile view

---

## step 5: design system

define your visual language before designing any screens. every decision made once, applied everywhere.

### colors

```
3 color rule:
  1 background color (and 1-2 surface variations)
  1 text color (and 1-2 muted variations)
  1 accent/brand color (and light/dark variations)

plus semantic colors:
  success: green
  warning: yellow/orange
  error:   red
  info:    blue

example dark theme:
  --bg:           #0d1117   background
  --surface:      #161b22   cards, elevated
  --surface-2:    #21262d   modals, dropdowns
  --border:       #30363d   all borders

  --text:         #e6edf3   primary text
  --text-muted:   #7d8590   secondary text
  --text-faint:   #484f58   disabled, placeholder

  --accent:       #6cb6ff   primary actions, links
  --accent-hover: #79c0ff   hover state

  --success:      #3fb950
  --warning:      #d29922
  --error:        #f85149
```

**contrast ratio:** text must be readable. minimum 4.5:1 for normal text, 3:1 for large text. test with a contrast checker.

### typography

```
pick ONE font family. two at most (one for headings, one for body).
for developer tools and terminals: monospace fonts work great (your notes site)
for general apps: Inter, Geist, or system-ui

type scale (stick to these sizes, nothing else):
  12px  — captions, labels, tiny text
  14px  — body text, secondary content
  16px  — default body (base)
  18px  — large body, subheadings
  20px  — h3
  24px  — h2
  32px  — h1
  48px  — hero headline

font weights:
  400  — regular (body text)
  500  — medium (labels, emphasis)
  600  — semibold (headings, buttons)
  700  — bold (strong emphasis only)

line height:
  1.4  — headings (tight)
  1.6  — body text (comfortable)
  1.8  — long-form reading
```

### spacing

use a 4px base grid. every spacing value is a multiple of 4:

```
4px   — tight (between icon and label)
8px   — small (between related elements)
12px  — medium-small
16px  — medium (default padding)
20px  — medium-large
24px  — large (between sections)
32px  — xl (section padding)
40px  — 2xl
48px  — 3xl
64px  — 4xl (hero padding)

rule: never eyeball spacing. always pick from the scale.
```

### components

define each component and all its states before building:

```
button:
  variants: primary, secondary, ghost, danger
  sizes:    sm, md, lg
  states:   default, hover, active, focus, disabled, loading

input:
  states: default, focus, error, disabled
  types:  text, password, search, textarea

card:
  variants: default, interactive (hover effect), selected
```

---

## step 6: layout principles

**grid system:**
```
desktop: 12-column grid, 24px gutters, 1200px max-width
tablet:  8-column grid,  16px gutters
mobile:  4-column grid,  16px gutters, full width
```

**visual hierarchy — size and weight tells users what to look at first:**
```
most important  → biggest, highest contrast, most white space around it
secondary       → medium size, slightly muted
tertiary        → small, muted color
least important → smallest, faintest
```

**white space is not wasted space:**
- increases perceived quality
- improves readability
- separates unrelated content
- focuses attention

**alignment:**
```
everything aligns to the grid
text aligns left (for LTR languages)
numbers align right (in tables)
icons center-align with text
```

**proximity — related things are close, unrelated things are far:**
```
label
[input field]

                        ← big gap here separates sections

another label
[another input]
```

---

## common layout patterns

**holy grail layout:**
```
┌─────────────────────────┐
│         header          │
├───────┬─────────┬───────┤
│       │         │       │
│ left  │  main   │ right │
│ side  │ content │ side  │
│       │         │       │
├───────┴─────────┴───────┤
│         footer          │
└─────────────────────────┘
```

**dashboard layout:**
```
┌─────────────────────────┐
│  navbar                 │
├──────┬──────────────────┤
│      │  stat  stat stat │
│ side │──────────────────┤
│ bar  │  main content    │
│      │                  │
│      │                  │
└──────┴──────────────────┘
```

**card grid:**
```
┌──────┐ ┌──────┐ ┌──────┐
│ card │ │ card │ │ card │
└──────┘ └──────┘ └──────┘
┌──────┐ ┌──────┐ ┌──────┐
│ card │ │ card │ │ card │
└──────┘ └──────┘ └──────┘
```

**master-detail:**
```
┌───────────────┬──────────────────┐
│ list item     │                  │
│ list item ←── │   detail view    │
│ list item     │   of selected    │
│ list item     │   item           │
└───────────────┴──────────────────┘
```

---

## mobile-first design

design for smallest screen first. then enhance for larger screens.

```
ask for every element:
  does this need to exist on mobile?
  if yes: how does it adapt?
  if no: can it be hidden or moved?

desktop sidebar → mobile: bottom tab bar or hamburger menu
desktop table → mobile: cards or horizontal scroll
desktop multi-column form → mobile: single column
desktop hover tooltips → mobile: tap to reveal
```

---

# part 2: database design

## the design process

```
identify entities (what things exist)
      ↓
identify attributes (what properties each thing has)
      ↓
identify relationships (how things relate to each other)
      ↓
normalize (remove redundancy)
      ↓
add indexes (for performance)
      ↓
define constraints (for data integrity)
```

---

## step 1: identify entities

entities are the "nouns" of your system. the things you need to store.

```
StudentOS entities:
  user
  goal
  log
  session (auth)

blog entities:
  user
  post
  comment
  tag
  category

e-commerce entities:
  user
  product
  category
  order
  order_item
  address
  payment
  review
```

**rule:** if you find yourself storing a list of things inside a single field, that list should be its own table.

---

## step 2: attributes for each entity

for each entity, list every property it needs:

```
users:
  id            UUID, primary key
  email         TEXT, unique, not null
  password_hash TEXT, not null
  name          TEXT, not null
  avatar_url    TEXT, nullable
  bio           TEXT, nullable
  created_at    TIMESTAMPTZ, default now()
  updated_at    TIMESTAMPTZ, default now()
  last_seen_at  TIMESTAMPTZ

goals:
  id            UUID, primary key
  user_id       UUID, foreign key → users.id
  title         TEXT, not null
  completed     BOOLEAN, default false
  date          DATE, not null
  created_at    TIMESTAMPTZ, default now()

logs:
  id            UUID, primary key
  user_id       UUID, foreign key → users.id
  content       TEXT, not null
  mood          INTEGER, 1-5
  date          DATE, not null, default today
  created_at    TIMESTAMPTZ, default now()
```

**for every attribute ask:**
- is it required (NOT NULL) or optional (NULL)?
- what is the right data type?
- does it need a default value?
- does it need to be unique?
- will it be searched/filtered often? (needs index)

---

## step 3: relationships

relationships define how tables connect.

**one-to-many** — one user has many goals. most common relationship.
```
users ──────< goals
(one)          (many)

users.id = goals.user_id
```

**many-to-many** — one post has many tags. one tag has many posts. requires a junction table.
```
posts >──────< tags

posts ──────< post_tags >────── tags
posts.id = post_tags.post_id
tags.id  = post_tags.tag_id
```

**one-to-one** — one user has one profile. rare. often just means merge the tables.
```
users ────── profiles
users.id = profiles.user_id
```

**draw an ER diagram:**
```
┌──────────┐         ┌──────────┐
│  users   │         │  goals   │
├──────────┤         ├──────────┤
│ id  (PK) │────────<│ id  (PK) │
│ email    │         │ user_id  │ (FK)
│ name     │         │ title    │
│ ...      │         │ date     │
└──────────┘         └──────────┘
     │
     │               ┌──────────┐
     └──────────────<│  logs    │
                     ├──────────┤
                     │ id  (PK) │
                     │ user_id  │ (FK)
                     │ content  │
                     │ mood     │
                     └──────────┘
```

---

## step 4: normalization

normalization removes redundancy and prevents update anomalies.

**1NF — no repeating groups:**
```sql
-- bad: comma-separated values in a column
users: id, name, tags → "javascript,python,react"

-- good: separate table
user_tags: user_id, tag
```

**2NF — no partial dependencies:**
```sql
-- bad: order_items stores product_name (depends on product, not order_item)
order_items: order_id, product_id, product_name, quantity, price

-- good: get product_name by joining products table
order_items: order_id, product_id, quantity, price
products:    id, name, description
```

**3NF — no transitive dependencies:**
```sql
-- bad: city_population depends on city, not on user
users: id, name, city, city_population

-- good: separate table
users:  id, name, city_id
cities: id, name, population
```

**when to denormalize:** sometimes break these rules intentionally for performance. storing a `comment_count` on a `posts` table avoids expensive COUNT queries. trade off: you must keep it in sync.

---

## step 5: indexes

indexes speed up queries. without them, every query scans every row.

```sql
-- always index:
-- 1. foreign keys
CREATE INDEX idx_goals_user_id ON goals(user_id);
CREATE INDEX idx_logs_user_id  ON logs(user_id);

-- 2. columns used in WHERE clauses often
CREATE INDEX idx_goals_date     ON goals(date);
CREATE INDEX idx_users_email    ON users(email);

-- 3. columns used in ORDER BY
CREATE INDEX idx_posts_created  ON posts(created_at DESC);

-- 4. composite indexes for common query patterns
-- "get all goals for user on a specific date"
CREATE INDEX idx_goals_user_date ON goals(user_id, date);

-- 5. partial indexes (only index rows matching a condition)
CREATE INDEX idx_published_posts ON posts(created_at)
WHERE published = true;
```

**cost of indexes:** they speed up reads but slow writes (index updated on every insert/update/delete). don't index everything. index what you query.

---

## step 6: constraints

constraints enforce data integrity at the database level:

```sql
CREATE TABLE goals (
    id         UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id    UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title      TEXT NOT NULL CHECK (length(trim(title)) > 0),
    completed  BOOLEAN NOT NULL DEFAULT false,
    mood       INTEGER CHECK (mood BETWEEN 1 AND 5),
    date       DATE NOT NULL DEFAULT CURRENT_DATE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    -- composite unique constraint
    UNIQUE(user_id, date, title)  -- no duplicate goals same day
);
```

**ON DELETE options:**
```
CASCADE    → delete child rows when parent deleted (delete goals when user deleted)
RESTRICT   → prevent parent deletion if children exist
SET NULL   → set foreign key to null when parent deleted
SET DEFAULT→ set foreign key to default value
```

---

## schema design patterns

**soft delete** — don't actually delete rows, mark them deleted:
```sql
ALTER TABLE users ADD COLUMN deleted_at TIMESTAMPTZ;

-- "delete" a user
UPDATE users SET deleted_at = NOW() WHERE id = $1;

-- query only active users
SELECT * FROM users WHERE deleted_at IS NULL;

-- partial index for performance
CREATE INDEX idx_active_users ON users(id) WHERE deleted_at IS NULL;
```

**audit trail** — track who changed what when:
```sql
CREATE TABLE audit_log (
    id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    table_name  TEXT NOT NULL,
    record_id   UUID NOT NULL,
    action      TEXT NOT NULL,  -- INSERT, UPDATE, DELETE
    old_data    JSONB,
    new_data    JSONB,
    user_id     UUID,
    created_at  TIMESTAMPTZ DEFAULT NOW()
);
```

**timestamps on everything:**
```sql
-- add to every table
created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()

-- auto-update updated_at with a trigger
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_updated_at
BEFORE UPDATE ON goals
FOR EACH ROW EXECUTE FUNCTION update_updated_at();
```

**ULID / UUID for IDs:**
```sql
-- UUID: random, globally unique, good default
id UUID DEFAULT gen_random_uuid() PRIMARY KEY

-- BIGSERIAL: auto-increment integer, smaller, faster joins
-- but reveals record count (user id 1, 2, 3...)
id BIGSERIAL PRIMARY KEY
```

---

# part 3: system architecture

## the design process

```
understand scale requirements
      ↓
identify components (what services exist)
      ↓
define data flow (how data moves)
      ↓
choose deployment strategy
      ↓
plan for failure (what happens when things break)
```

---

## step 1: understand your scale

don't over-engineer for scale you will never reach. but don't under-engineer either.

```
tier 1: personal project / MVP
  users: 0 - 1,000
  requests: < 100/day
  data: < 1GB
  solution: single server, managed database, simple deployment
  cost: $0-20/month

tier 2: small product
  users: 1,000 - 100,000
  requests: thousands/day
  data: 1GB - 100GB
  solution: separate frontend/backend, CDN, managed database
  cost: $20-200/month

tier 3: growing product
  users: 100,000 - 1,000,000
  requests: millions/day
  data: 100GB - 1TB
  solution: load balancer, multiple backend instances, read replicas, caching
  cost: $200-2000/month

tier 4: large scale
  users: 1M+
  requests: billions/day
  solution: microservices, multiple databases, global CDN, complex infra
  cost: $2000+/month
```

**start at tier 1. move up only when you hit limits.** most apps never leave tier 1.

---

## step 2: components

every web application has these core components:

```
client                    your infrastructure
┌───────────┐             ┌─────────────────────────────┐
│           │             │                             │
│  browser  │──HTTP/S────►│  CDN (static files)         │
│           │             │                             │
│  mobile   │──HTTP/S────►│  web server / API           │
│   app     │             │                             │
│           │             │  database                   │
└───────────┘             │                             │
                          │  file storage               │
                          │                             │
                          │  cache (Redis)              │
                          │                             │
                          │  queue (background jobs)    │
                          │                             │
                          └─────────────────────────────┘
```

**CDN (Content Delivery Network)**
- serves static files (HTML, CSS, JS, images) from servers near the user
- Vercel and Cloudflare are CDNs
- dramatically faster page loads globally

**web server / API**
- processes requests, runs business logic
- talks to database, calls external services
- FastAPI, Express, Django

**database**
- persists all application data
- PostgreSQL for most apps

**file storage**
- user uploads, images, documents
- Supabase Storage, AWS S3, Cloudflare R2

**cache**
- stores frequently accessed data in memory for fast retrieval
- Redis is the standard
- cache DB query results, session data, computed values

**queue**
- background jobs that don't need to happen synchronously
- sending emails, processing images, generating reports
- Celery + Redis, BullMQ

---

## step 3: data flow

trace how data moves through your system for each key operation.

**user login:**
```
browser
  → POST /api/auth/login {email, password}
  → API server
      → query database: SELECT * FROM users WHERE email = ?
      → verify password hash
      → create JWT token
      → return {token, user}
  → browser stores token
  → browser redirects to dashboard
```

**load dashboard:**
```
browser
  → GET /api/goals?date=today (with JWT in header)
  → API server
      → validate JWT → extract user_id
      → check cache: "goals:user_id:2026-03-06"
      → cache miss → query database
      → store result in cache (TTL 60 seconds)
      → return goals
  → browser renders goals
```

**file upload:**
```
browser
  → POST /api/upload (multipart form data)
  → API server
      → validate file type and size
      → generate unique filename
      → upload to Supabase Storage
      → save file URL to database
      → return {url}
  → browser shows uploaded image
```

---

## step 4: architecture patterns

### monolith

everything in one codebase, one deployment. simple to start with.

```
┌─────────────────────────────┐
│         monolith            │
│                             │
│  auth module                │
│  goals module               │
│  logs module                │
│  notifications module       │
│  file upload module         │
│                             │
└─────────────────────────────┘
         │
         ▼
┌─────────────────────────────┐
│        database             │
└─────────────────────────────┘
```

**use for:** almost everything. startups, MVPs, small to medium apps.

**pros:** simple to develop, deploy, debug. no network between services.
**cons:** as it grows, harder to scale individual parts. one bug can crash everything.

### microservices

split into many small services, each with its own database.

```
┌──────────┐  ┌──────────┐  ┌──────────┐
│  auth    │  │  goals   │  │  notify  │
│ service  │  │ service  │  │ service  │
└──────────┘  └──────────┘  └──────────┘
     │              │              │
┌────┴───┐    ┌─────┴──┐    ┌──────┴─┐
│auth db │    │goals db│    │notify  │
└────────┘    └────────┘    │  db    │
                            └────────┘
```

**use for:** large teams, services that need to scale independently, after outgrowing monolith.

**pros:** scale services independently, different tech stacks, isolated failures.
**cons:** massive operational complexity, network calls between services, hard to debug.

**rule:** don't start with microservices. start monolith, split when you have a clear reason.

### the practical architecture for your projects

```
┌─────────────────────────────────────────┐
│               Vercel CDN                │
│         (React frontend, static)        │
└─────────────────────────────────────────┘
                     │ HTTPS
                     ▼
┌─────────────────────────────────────────┐
│            Railway / Render             │
│            (FastAPI backend)            │
│                                         │
│  routes → services → repositories      │
│                                         │
└─────────────────────────────────────────┘
          │                    │
          ▼                    ▼
┌──────────────────┐  ┌───────────────────┐
│    Supabase      │  │  Supabase Storage │
│   PostgreSQL     │  │  (file uploads)   │
└──────────────────┘  └───────────────────┘
```

this is tier 1/2 architecture. handles tens of thousands of users easily. zero cost to start.

---

## step 5: caching strategy

cache = storing results so you don't compute or fetch them again.

```
cache hit:  request → cache → return cached data (fast, ~1ms)
cache miss: request → cache → not found → database → store in cache → return data
```

**what to cache:**
```
good candidates:
  results of expensive DB queries
  user session data
  computed values (stats, aggregates)
  external API responses
  rendered HTML fragments

bad candidates:
  data that changes every request
  unique per-user data (unless caching per user)
  very large objects
```

**cache invalidation** — when to clear the cache:

```
time-based (TTL):
  cache expires after N seconds
  simple, but may serve stale data
  good for: stats, public content

event-based:
  clear cache when data changes
  more complex but always fresh
  good for: user-specific data

example:
  cache user's goals for 60 seconds (TTL)
  when user creates/updates/deletes a goal: clear their goals cache
```

---

## step 6: handling failure

design for failure. every component will fail eventually.

**what can fail:**
```
database is down        → show maintenance page, retry
external API is down    → fallback response, queue retry
server runs out of memory → auto-restart, alert
bad deploy breaks app   → rollback to previous version
user sends malicious data → validate, sanitize, reject
too many requests       → rate limiting, queue
```

**retry logic:**
```python
import asyncio

async def with_retry(fn, max_attempts=3, delay=1):
    for attempt in range(max_attempts):
        try:
            return await fn()
        except Exception as e:
            if attempt == max_attempts - 1:
                raise
            await asyncio.sleep(delay * (2 ** attempt))  # exponential backoff
```

**circuit breaker** — stop calling a failing service:
```
closed (normal) → open (failing, stop calling) → half-open (try again)
```

**graceful degradation** — app still works when parts fail:
```
search service down → show all results unsorted (not an error page)
recommendation service down → show popular items instead
image processing down → show original image
```

---

## step 7: API design in architecture

your API is the contract between frontend and backend. design it before building either.

**REST resource structure:**
```
/api/v1/users
/api/v1/users/:id
/api/v1/users/:id/goals
/api/v1/goals
/api/v1/goals/:id
/api/v1/logs
/api/v1/auth/login
/api/v1/auth/signup
/api/v1/auth/logout
```

**versioning:**
```
/api/v1/... → current stable version
/api/v2/... → new version (backwards incompatible changes)

never break existing clients.
deprecate old versions with a sunset date.
```

**pagination:**
```json
GET /api/goals?page=2&per_page=20

{
    "data": [...],
    "pagination": {
        "page": 2,
        "per_page": 20,
        "total": 150,
        "total_pages": 8
    }
}
```

---

## putting it all together: design document

before starting any project write a simple design doc. one page is enough.

```
# ProjectName — Design Document

## problem
what problem does this solve? for who?

## users
who uses this? what do they do daily?

## core features (MVP)
1. ...
2. ...
3. ...

## pages / screens
- /        landing page
- /login   login
- /app     main app (protected)

## data model
users:  id, email, name, created_at
posts:  id, user_id, title, content, created_at

## API endpoints
GET  /api/posts        list posts
POST /api/posts        create post
GET  /api/posts/:id    get post
DELETE /api/posts/:id  delete post

## architecture
frontend: React on Vercel
backend:  FastAPI on Railway
database: PostgreSQL on Supabase

## what i am NOT building (v1)
- comments
- notifications
- mobile app
```

one page. written before any code. saves weeks of rework.

---

## common design mistakes

**designing for scale you don't have** — adding Redis, message queues, microservices for an app with 10 users. complexity kills projects.

**no empty states** — every list or data view needs a design for when it's empty. "no goals yet — add your first one!"

**no error states** — every async operation needs a design for failure.

**inconsistent spacing** — not using a spacing system. elements feel misaligned and random.

**too many fonts and colors** — pick one font, one accent color, stick to it.

**designing only the happy path** — what happens when the network fails? when input is wrong? when the user is on a slow 2G connection?

**no mobile design** — over 60% of traffic is mobile. design for it first.

**not documenting the data model** — changing the schema later when the app is running is painful. think it through before writing any code.

---

```
=^._.^= measure twice, cut once
```
