# How to Build a Project

> from raw idea to deployed product. the complete mental model.

---

## the mindset shift

most beginners ask "how do I code this?"
a senior developer asks "should I build this at all, and if yes, what is the simplest version that works?"

senior developers are not smarter. they have seen more failure. they know what questions to ask before writing a single line of code. they know that the most expensive bugs are the ones built into the architecture on day one.

**the most important skill is not coding. it is thinking.**

---

## phase 1: understand the problem

before touching a keyboard, you must deeply understand what you are building and why.

### ask these questions

**what problem does this actually solve?**
be brutally honest. "I want to build a social network" is not a problem statement. "students at my college have no way to find study partners for specific subjects" is a problem statement.

**who is the user?**
not "everyone". be specific. a 19-year-old CS student at a tier-2 college with a mid-range Android phone and slow internet is a very specific user. design for that person.

**what does the user currently do without your product?**
if students find study partners through WhatsApp groups, that is your competition. you must be meaningfully better, not just different.

**what is the ONE core thing this product must do well?**
everything else is secondary. a notes app must make it fast to take and find notes. a chat app must deliver messages reliably. know your north star.

**what does success look like in 3 months?**
"10 active daily users who come back every day" is better than "1000 downloads". retention beats acquisition.

### write it down

write a one-paragraph description of the product:
```
[Product name] helps [specific user] to [solve specific problem]
by [core mechanism]. unlike [current alternative], we [key difference].
```

example:
```
StudyMatch helps CS students at tier-2 colleges find study partners
for specific subjects and exams by matching based on topic, level,
and schedule. unlike WhatsApp groups, we surface relevant people
automatically instead of requiring you to ask publicly.
```

this paragraph becomes your compass. every feature decision gets measured against it.

---

## phase 2: define features

### MVP first

MVP (Minimum Viable Product) is the smallest version that:
- actually solves the core problem
- is usable by real users
- can validate whether your idea is right

**not** the version with every feature you imagined.

### the feature list exercise

write down every feature you want. every single one. then:

**must have (MVP)** — without this, the product does not work at all
**should have** — makes the product significantly better, build after MVP
**nice to have** — polish and extra features, build much later
**do not build** — sounds good but adds complexity without proportional value

example for a private chat app:
```
must have:
- send and receive text messages
- end-to-end encryption
- user accounts

should have:
- message status (sent/delivered/read)
- push notifications
- local message storage

nice to have:
- message reactions
- voice messages
- profile photos

do not build yet:
- video calls
- stories
- groups (unless core to your idea)
```

### prioritize ruthlessly

every feature has a cost: time to build, complexity to maintain, surface area for bugs. ask for every feature: "if we never build this, does the product still work?" if yes, it is not MVP.

---

## phase 3: system design and architecture

now you think about how to build it, not what to build.

### draw it on paper first

before any code, draw the high-level architecture:

```
[Mobile App / Web Browser]
         |
         | HTTP requests
         |
    [API Server]
         |
    ┌────┴────┐
    |         |
[Database] [Cache]
```

or more complex:

```
[React Frontend]  [Android App]
        \              /
         \            /
        [API Gateway]
         /    |    \
        /     |     \
[Users  ] [Posts ] [Notifs ]
[Service] [Service] [Service]
    |         |         |
[User DB] [Post DB] [Redis]
```

draw it simple. the purpose is to understand: what components exist, how they talk to each other, where data lives, what happens when a request comes in.

### choose your architecture

**monolith** — one application handles everything. right choice for almost all beginners and small teams.
```
one codebase → one database → one server
```

**microservices** — separate services for separate features. only choose this if you have a large team, clear boundaries, and real scaling needs. do not start here.

**rule:** start with monolith. split only when you have a proven reason.

### define the data flow

pick one core user action and trace it completely:

example — user sends a message in chat app:
```
1. user types message, hits send
2. app validates: not empty, under 4000 chars
3. app encrypts message on device
4. POST /api/messages with encrypted payload
5. server validates auth token
6. server saves to database
7. server triggers notification to recipient
8. server returns 201 Created with message id
9. app shows message as "sent"
10. recipient receives push notification
11. recipient opens app, fetches new messages
12. app decrypts messages on device
13. message shows as delivered/read
```

if you can trace the data flow before building, you understand the system.

---

## phase 4: database design

the database is the most important decision you make. it is the hardest to change later. think carefully.

### identify your entities

entities are the things your app cares about. for a chat app:
- users
- messages
- conversations
- devices (for push notifications)

for a student productivity app:
- users
- goals
- daily logs
- study sessions

### design the schema

for each entity, define its fields and their types:

```
users
├── id           uuid, primary key
├── username     text, unique, not null
├── email        text, unique, not null
├── password     text (hashed), not null
├── created_at   timestamp
└── last_seen    timestamp

messages
├── id           uuid, primary key
├── sender_id    uuid, foreign key → users.id
├── receiver_id  uuid, foreign key → users.id
├── content      text (encrypted)
├── sent_at      timestamp
└── read_at      timestamp, nullable
```

### define relationships

**one-to-many** — one user has many messages. user is on the "one" side. use foreign key on the "many" side.

**many-to-many** — users can be in many groups, groups have many users. use a junction table:
```
users (id, name)
groups (id, name)
user_groups (user_id, group_id, joined_at)  ← junction table
```

**one-to-one** — user has one profile. can be in same table or separate.

### normalization rule of thumb

do not store the same data in two places. if user's name changes, you should update it in ONE place and it reflects everywhere.

### choose SQL or NoSQL

**use SQL (PostgreSQL) when:**
- data has clear structure and relationships
- you need transactions (financial data, bookings)
- you need complex queries and joins
- data integrity is critical

**use NoSQL (MongoDB) when:**
- data structure varies per record
- you are storing documents, JSON blobs
- you need to scale writes horizontally
- relationships between data are minimal

**use Redis when:**
- caching (temporary fast storage)
- sessions and auth tokens
- real-time features (pub/sub)
- rate limiting counters

**default choice: PostgreSQL.** it handles almost everything. add Redis for caching when needed.

---

## phase 5: API design

define your API before building it. this is the contract between frontend and backend.

### REST conventions

```
GET    /api/users              list all users
GET    /api/users/:id          get specific user
POST   /api/users              create user
PUT    /api/users/:id          replace user
PATCH  /api/users/:id          update fields
DELETE /api/users/:id          delete user

GET    /api/users/:id/posts    get user's posts
POST   /api/conversations/:id/messages   send message
```

### define each endpoint

for every endpoint, define:
- method and path
- request body (for POST/PUT/PATCH)
- response shape
- possible errors

example:
```
POST /api/auth/login

request body:
{
    "email": "a@b.com",
    "password": "secret"
}

success response (200):
{
    "token": "eyJ...",
    "user": {
        "id": "uuid",
        "name": "Abhishek",
        "email": "a@b.com"
    }
}

error responses:
400 — missing email or password
401 — wrong password
404 — user not found
429 — too many login attempts
500 — server error
```

write this before building. it forces you to think about edge cases early.

---

## phase 6: tech stack selection

choose boring, proven technology. the goal is to ship, not to use the newest thing.

### questions to ask

**do I already know this?** using familiar tech is 10x faster than learning while building.

**does it have good documentation and community?** you will get stuck. you need to find answers.

**is it appropriate for the scale?** don't use Kubernetes for an app with 10 users.

**will it cost money?** calculate hosting costs before deciding.

### a sensible stack for most projects

```
web frontend:  React + Tailwind CSS + Vite
mobile:        Kotlin + Jetpack Compose (Android)
backend:       FastAPI (Python) or Express (Node.js)
database:      PostgreSQL (Supabase for free managed)
cache:         Redis (if needed)
auth:          Supabase Auth or JWT
file storage:  Supabase Storage or Cloudinary
hosting:       Vercel (frontend), Railway (backend), Supabase (db)
cost:          $0 for small projects
```

### the golden rule

use the stack that gets you to a working product fastest. optimize later.

---

## phase 7: project setup

now you actually start. setup once, correctly, and you save hours later.

### folder structure

**web project (React):**
```
my-project/
├── src/
│   ├── components/       shared reusable components
│   │   ├── ui/           basic: Button, Input, Card, Modal
│   │   └── layout/       Navbar, Sidebar, Footer
│   ├── pages/            one file per page/route
│   ├── hooks/            custom React hooks
│   ├── lib/              utilities, API client, helpers
│   ├── store/            state management (Zustand/Redux)
│   ├── types/            TypeScript types
│   └── assets/           images, fonts, icons
├── public/               static files
├── .env                  environment variables
├── .env.example          template for env vars (commit this)
├── .gitignore
├── package.json
└── README.md
```

**backend project (FastAPI/Python):**
```
backend/
├── app/
│   ├── api/              route handlers
│   │   ├── auth.py
│   │   ├── users.py
│   │   └── messages.py
│   ├── models/           database models
│   ├── schemas/          Pydantic validation schemas
│   ├── services/         business logic
│   ├── db/               database connection, migrations
│   └── main.py           app entry point
├── tests/
├── .env
├── requirements.txt
└── README.md
```

**Android project (default structure):**
```
app/src/main/
├── java/com/yourpackage/
│   ├── ui/               screens and composables
│   │   ├── home/
│   │   ├── chat/
│   │   └── profile/
│   ├── data/             repository, database, API
│   ├── domain/           use cases and business logic
│   └── di/               dependency injection
├── res/                  layouts, strings, drawables
└── AndroidManifest.xml
```

### git setup

do this on day one, before any code:

```bash
git init
git remote add origin git@github.com:username/project.git

# create .gitignore immediately
echo "node_modules/
.env
dist/
.DS_Store
__pycache__/
*.pyc
.venv/
" > .gitignore

git add .gitignore
git commit -m "init: project setup"
git push -u origin main
```

### environment variables

never hardcode secrets. always use environment variables:

```bash
# .env (never commit this)
DATABASE_URL=postgresql://user:pass@host/db
JWT_SECRET=your-secret-key
GROQ_API_KEY=your-key
SUPABASE_URL=https://xxx.supabase.co

# .env.example (always commit this — template with no values)
DATABASE_URL=
JWT_SECRET=
GROQ_API_KEY=
SUPABASE_URL=
```

### README on day one

write a minimal README before starting:

```markdown
# Project Name

one sentence description.

## setup

git clone ...
cd project
npm install
cp .env.example .env
# fill in .env values
npm run dev

## stack

- React + Tailwind
- FastAPI
- PostgreSQL

## features

- [ ] user auth
- [ ] core feature 1
- [ ] core feature 2
```

---

## phase 8: development order

what to build first matters enormously. wrong order = wasted work.

### the rule: build vertically, not horizontally

**horizontal (wrong):**
build all UI first → then all API → then all database

**vertical (right):**
build one complete feature end to end → then next feature

a complete feature means: UI + API + database working together for that one thing.

### the order for most projects

**1. authentication first**
everything depends on knowing who the user is. build login/signup/logout before anything else.

**2. data models and database**
set up your tables. you can always add columns but redesigning the core schema is painful.

**3. core feature — read path**
the thing that shows data to the user. list of messages, list of goals, feed. build the display first.

**4. core feature — write path**
creating new data. send message, add goal, create post.

**5. core feature — update and delete**
edit and delete operations.

**6. error states and loading states**
every async operation needs: loading indicator, error message, empty state. do this per feature, not at the end.

**7. navigation and routing**
connect pages together. back button works. links work.

**8. secondary features**
notifications, search, filters, profile settings.

**9. polish**
animations, empty states, onboarding flow, edge cases.

**10. performance**
optimize only what is actually slow. do not prematurely optimize.

### commit strategy

commit often, in small pieces:

```bash
# good commits (small, specific, clear)
git commit -m "feat: add login form with validation"
git commit -m "feat: POST /api/auth/login endpoint"
git commit -m "fix: login redirects to dashboard on success"
git commit -m "feat: persist auth token in localStorage"

# bad commits
git commit -m "stuff"
git commit -m "fixed things"
git commit -m "working on auth"
```

**conventional commits format:**
```
feat:     new feature
fix:      bug fix
docs:     documentation only
style:    formatting, no logic change
refactor: code change that is not a fix or feature
test:     adding tests
chore:    build process, dependencies
```

### branch strategy (simple version)

```
main         → always deployable, production code
dev          → integration branch, work in progress
feature/xxx  → one branch per feature
fix/xxx      → one branch per bug fix
```

for solo projects: just commit to main. branches are for teams.

---

## phase 9: coding principles

### write code for the person who maintains it (that's you in 6 months)

**naming:** names should explain intent, not implementation:
```javascript
// bad
const d = new Date()
const arr2 = users.filter(u => u.a === true)
function proc(x) { }

// good
const currentDate = new Date()
const activeUsers = users.filter(user => user.isActive)
function processPayment(order) { }
```

**functions:** one function = one job. if you can't describe what a function does in one sentence without using "and", it does too much:
```javascript
// bad
function registerUserAndSendEmailAndCreateProfile(data) { }

// good
function createUser(data) { }
function sendWelcomeEmail(user) { }
function createProfile(userId) { }
```

**DRY (Don't Repeat Yourself):** if you write the same code twice, make it a function. if you use the same value in multiple places, make it a constant or variable.

**YAGNI (You Aren't Gonna Need It):** don't build for imaginary future requirements. solve today's problem.

**handle errors:** every operation that can fail must have error handling. network requests, database queries, file operations.

```javascript
// bad
const user = await getUser(id)
displayUser(user)  // crashes if user is null

// good
const user = await getUser(id)
if (!user) {
    showError("User not found")
    return
}
displayUser(user)
```

### the review checklist before committing

ask yourself for every piece of code:
- does it work for the happy path?
- what happens if the input is empty/null/wrong type?
- what happens if the network request fails?
- what happens if the database is slow?
- is there anything hardcoded that should be a variable?
- can I understand this code in 6 months without comments?

---

## phase 10: testing

### types of tests

**manual testing** — you use the app yourself. always do this. not enough alone.

**unit tests** — test one function in isolation. fast, catch regressions:
```python
def test_calculate_streak():
    logs = [date(2026,3,1), date(2026,3,2), date(2026,3,3)]
    assert calculate_streak(logs) == 3
```

**integration tests** — test multiple parts working together. API endpoint tests:
```python
def test_login_success():
    response = client.post("/api/auth/login", json={
        "email": "test@test.com",
        "password": "correct"
    })
    assert response.status_code == 200
    assert "token" in response.json()
```

**end-to-end tests** — test the whole flow in a browser. Playwright, Cypress.

### test what matters

for small projects: manually test every feature before shipping. write automated tests for:
- authentication flows (login, logout, wrong password)
- core business logic (the calculation in your app that must be correct)
- any function you have had to fix a bug in

### testing checklist per feature

before marking a feature done:

```
happy path         → works correctly with valid input
empty input        → handles blank fields gracefully
invalid input      → shows clear error message
network failure    → shows error, doesn't crash
slow network       → shows loading state
duplicate action   → double-click submit doesn't send twice
unauthorized       → unauthenticated user gets redirected
mobile screen      → looks good on small screen
```

---

## phase 11: deployment

### before deploying

```
[ ] all environment variables set in hosting platform
[ ] .env not committed to git
[ ] database migrations run
[ ] build succeeds locally (npm run build)
[ ] no console.log with sensitive data
[ ] 404 page exists
[ ] error pages exist
[ ] favicon set
[ ] page titles are correct
[ ] OG tags for social sharing
```

### deployment pipeline

```
code pushed to git
        ↓
CI runs tests (GitHub Actions)
        ↓
if tests pass → deploy automatically
        ↓
    frontend → Vercel
    backend → Railway
    database → Supabase
```

### simple GitHub Actions for deployment

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
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 20
      - run: npm install
      - run: npm run build
      - run: npm test
```

Vercel and Railway auto-deploy when you push to main. GitHub Actions adds a test step first.

### the deployment commands to know

```bash
# check build works before deploying
npm run build

# check for TypeScript errors
npx tsc --noEmit

# check for unused dependencies
npx depcheck

# run tests
npm test

# check bundle size
npm run build -- --analyze
```

---

## phase 12: monitoring and maintenance

your work does not end at deployment.

### what to monitor

**errors** — know when something breaks before users tell you:
- Sentry (free tier) for frontend and backend error tracking
- Vercel Analytics for frontend performance

**uptime** — know if your server goes down:
- UptimeRobot (free) pings your server every 5 minutes

**performance** — know if your app is slow:
- Lighthouse in Chrome DevTools
- Core Web Vitals in Google Search Console

### logging

log the right things:
```python
# log these
logger.info(f"User {user_id} logged in")
logger.error(f"Payment failed for order {order_id}: {error}")
logger.warning(f"Rate limit hit for IP {ip_address}")

# don't log these
logger.info(f"Password: {password}")
logger.info(f"Token: {token}")
```

### maintenance checklist (monthly)

```
[ ] update dependencies (npm update / pip list --outdated)
[ ] check error logs for recurring issues
[ ] check database for unused data / cleanup
[ ] review security advisories for your stack
[ ] backup database
[ ] renew SSL certificate (Let's Encrypt auto-renews)
[ ] check if any API keys are expiring
```

### handling bugs in production

```
1. reproduce it — understand exactly what causes it
2. isolate it — find the specific code causing it
3. fix it — write the fix in a branch
4. test the fix — make sure it actually fixes it
5. deploy — push the fix
6. verify — confirm it is fixed in production
7. post-mortem — understand why it happened, prevent recurrence
```

---

## putting it all together

here is the complete checklist for any project from idea to deployed product:

### week 1: foundation
```
[ ] write the problem statement
[ ] define MVP features
[ ] design database schema on paper
[ ] design API endpoints
[ ] choose tech stack
[ ] set up git repo
[ ] set up project folder structure
[ ] set up .env and .gitignore
[ ] write minimal README
```

### week 2-3: core
```
[ ] set up database
[ ] implement authentication
[ ] build core read feature (display data)
[ ] build core write feature (create data)
[ ] connect frontend to backend
[ ] handle loading states
[ ] handle error states
[ ] handle empty states
```

### week 4: complete
```
[ ] implement secondary features
[ ] mobile responsive
[ ] test all user flows manually
[ ] fix bugs found in testing
[ ] write .env.example
[ ] write complete README
```

### week 5: deploy
```
[ ] set up hosting (Vercel, Railway)
[ ] configure environment variables
[ ] run database migrations
[ ] deploy and test in production
[ ] set up error monitoring
[ ] set up uptime monitoring
[ ] share with first real users
```

---

## the senior developer mindset summarized

**1. understand before building.** spend 20% of time understanding the problem deeply. it saves 80% of wasted implementation.

**2. simple is better.** the best code is code you don't have to write. the best feature is the one that solves the problem with least complexity.

**3. iterate, don't perfect.** ship something that works, learn from real users, improve. a perfect product that never ships helps no one.

**4. design for failure.** everything will fail. networks drop. databases go down. users do unexpected things. handle failures gracefully.

**5. future-you is your user.** write code, commit messages, and documentation as if a stranger who knows the stack will need to understand it in 6 months. that stranger is you.

**6. know when to stop.** a feature is done when it works, handles errors, and is tested. not when it is perfect.

**7. the problem is almost never the technology.** it is almost always the requirements, the design, or the communication.

---

```
=^._.^= think first. code second. ship always.
```
