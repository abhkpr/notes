# Building Websites and Web Applications

> the complete process from idea to live product.

---

## the difference: website vs web application

before you start building, know what you are building.

**website** — primarily informational. user reads content, clicks links, fills a contact form. mostly static. your portfolio, a blog, a company landing page, a documentation site.

**web application** — user does things. creates accounts, saves data, interacts with other users, processes payments. the data changes based on user. Gmail, StudentOS, Notion, Twitter.

the line blurs but the distinction matters because they require different architecture. a website can be just HTML/CSS/JS files. a web application needs a backend, a database, authentication.

**rule of thumb:** if users log in and their data is saved, it is a web application.

---

## phase 1: define the idea

the biggest mistake beginners make is opening VS Code before they understand what they are building.

### what problem does it solve

every good product solves a real problem. write it in one sentence:

```
[target user] can [do something] without [pain point]

example:
"Students can track their daily goals and get AI feedback
without switching between five different apps"
```

if you cannot write this sentence clearly, your idea is not clear enough yet.

### who is it for

define your user specifically. not "everyone". real users have real constraints:
- what device do they use (mobile or desktop)
- what is their tech level (can they figure out complex UI)
- when do they use it (on the go, at a desk)
- what do they already use instead

### what are the core features

list everything you want to build. then cut it in half. then cut it in half again.

**MVC — Minimum Viable Core:** what is the absolute minimum that makes the product useful?

```
example: StudentOS

want to build:
- day planner
- goal tracking
- daily logs
- AI coach
- contribution graph
- social features
- export to PDF
- calendar view
- analytics dashboard
- gamification

MVP (what actually ships first):
- goal tracking
- daily logs
- AI feedback

everything else is v2
```

this is called an **MVP — Minimum Viable Product**. ship the core fast, learn from real users, then add features.

### what does success look like

define metrics before you build:
- how many users do you want in 3 months
- what does a user do every day in your app
- what makes someone come back tomorrow

---

## phase 2: plan the product

### user flows

a user flow maps every path a user can take through your app. draw it before you write one line of code.

```
new user flow:
lands on homepage
       ↓
clicks "Get Started"
       ↓
signup page → fills form → submits
       ↓
email verification (or skip)
       ↓
onboarding (set up profile)
       ↓
dashboard (main app)

returning user flow:
lands on homepage → already logged in → redirect to dashboard
OR
lands on login page → fills credentials → dashboard
```

draw this with pen and paper or on paper. every screen should be mapped.

### information architecture

IA is about organizing your content and features in a logical hierarchy. what pages exist, how they connect.

```
/ (home/landing)
├── /login
├── /signup
├── /dashboard
│   ├── /goals
│   ├── /log
│   └── /analytics
├── /profile
│   └── /profile/edit
└── /settings
```

### data modeling

figure out what data you need to store BEFORE you build anything. this saves massive refactoring later.

for each piece of data, ask: what fields does it have? how does it relate to other data?

```
users
  id, name, email, password_hash, avatar, created_at

goals
  id, user_id, title, completed, date, created_at

logs
  id, user_id, content, mood, date, created_at

sessions
  id, user_id, token, expires_at
```

the `user_id` in goals and logs is a **foreign key** — it connects that record to a specific user.

### feature list with priority

use MoSCoW prioritization:

```
MUST have (app does not work without this)
SHOULD have (important but not critical)
COULD have (nice to have if time allows)
WON'T have (not in this version)
```

---

## phase 3: design the UI

### design principles to internalize

**hierarchy** — most important things are biggest and highest contrast. user's eye should go: main headline → subheadline → content → action.

**consistency** — same button style everywhere. same spacing pattern. same font sizes. users build a mental model and consistency reinforces it.

**whitespace** — empty space is not wasted space. it creates breathing room, separates content, and signals quality. more whitespace = more premium.

**contrast** — text must be readable against its background. minimum contrast ratio 4.5:1 for normal text.

**feedback** — every action should have a visible response. button click → visual change. form submit → loading state → success/error. never leave user wondering if something worked.

**simplicity** — if a user has to think about how to use it, you have failed. interfaces should be obvious.

### design tokens: decide before you design

before designing any screen, define your system:

```
colors:
  background:    #0d1117
  surface:       #161b22  (cards, elevated elements)
  border:        #30363d
  text-primary:  #e6edf3
  text-muted:    #7d8590
  accent:        #6cb6ff  (primary actions)
  success:       #3fb950
  warning:       #d29922
  error:         #f85149

typography:
  font: Inter, system-ui, sans-serif
  sizes: 12 14 16 18 20 24 32 48px
  weights: 400 (regular) 500 (medium) 600 (semibold) 700 (bold)

spacing: 4 8 12 16 20 24 32 40 48 64px
  (multiples of 4 — everything aligns)

border-radius: 4 6 8 12 16px
  (consistent rounding across all elements)

shadows:
  sm: 0 1px 3px rgba(0,0,0,0.3)
  md: 0 4px 6px rgba(0,0,0,0.3)
  lg: 0 10px 15px rgba(0,0,0,0.3)
```

### wireframing

wireframes are low-fidelity sketches. no color, no real content. just boxes showing layout and structure.

**do this with pen and paper first.** it is 100x faster than designing in code.

```
┌──────────────────────────────────┐
│ [LOGO]          [nav] [nav] [CTA]│  ← navbar
├──────────────────────────────────┤
│                                  │
│   Big Headline Text              │  ← hero
│   Subheadline                    │
│   [Primary CTA] [Secondary CTA]  │
│                                  │
├──────────────────────────────────┤
│ Feature 1  │ Feature 2  │ Feature│  ← features
│ icon+text  │ icon+text  │ icon+  │
│            │            │ text   │
├──────────────────────────────────┤
│         [Final CTA]              │  ← footer CTA
└──────────────────────────────────┘
```

sketch every page. every state (empty, loading, error, success). then move to high-fidelity.

### responsive design from the start

design for mobile first. 60%+ of web traffic is mobile.

```
mobile (320-480px):  single column, stacked elements
tablet (768px):      two columns possible
desktop (1024px+):   full layout with sidebar etc
```

think about how each component changes at each breakpoint before you code.

---

## phase 4: choose your tech stack

your stack choice depends on: what are you building, how fast do you need to ship, what do you already know.

### for a website (no backend needed)

```
HTML + CSS + vanilla JS
just files, no framework needed
deploy: GitHub Pages, Netlify, Vercel (free)
```

or if you want a blog/content site:
```
Hugo (what you use) — markdown files → HTML
Astro — modern static site generator
11ty — flexible static site generator
```

### for a web application

**frontend:**
```
React  — most popular, huge ecosystem
Vue    — simpler learning curve
Svelte — smaller, faster, less code
```

**backend (choose one):**
```
FastAPI (Python) — fast, modern, automatic docs
Express (Node.js) — simple, huge ecosystem
Hono (Node.js)   — modern, very fast
Django (Python)  — batteries included, great for complex apps
```

**database (choose one):**
```
PostgreSQL — relational, ACID, best for most apps
SQLite    — file-based, great for small apps
MongoDB   — document, flexible schema
Supabase  — PostgreSQL + auth + real-time + storage (what you use)
PlanetScale — serverless MySQL
```

**hosting (free tiers):**
```
Vercel   — frontend, serverless functions
Railway  — backend + database
Render   — backend
Supabase — database + auth + storage
Cloudflare Pages — frontend + edge functions
```

### tech stack decision framework

```
building a portfolio/blog?
→ Hugo or Astro. No backend.

building an app with user accounts?
→ React + Supabase. Simple and fast to ship.

building something complex (real-time, payments, heavy backend)?
→ React + FastAPI + PostgreSQL

need to learn fundamentals?
→ vanilla HTML/CSS/JS first, then a framework
```

---

## phase 5: set up the project

### folder structure matters

good structure = less confusion when the project grows.

**static website:**
```
my-website/
├── index.html
├── about.html
├── css/
│   ├── style.css
│   └── components.css
├── js/
│   └── main.js
├── images/
└── fonts/
```

**React application:**
```
my-app/
├── public/
│   └── favicon.ico
├── src/
│   ├── components/     → reusable UI components
│   │   ├── Button.jsx
│   │   ├── Card.jsx
│   │   └── Navbar.jsx
│   ├── pages/          → full page components
│   │   ├── Home.jsx
│   │   ├── Dashboard.jsx
│   │   └── Profile.jsx
│   ├── hooks/          → custom React hooks
│   │   └── useAuth.js
│   ├── lib/            → utilities, API clients
│   │   ├── supabase.js
│   │   └── api.js
│   ├── context/        → global state
│   │   └── AuthContext.jsx
│   ├── App.jsx
│   ├── main.jsx
│   └── index.css
├── .env                → environment variables (never commit)
├── .gitignore
├── package.json
└── vite.config.js
```

### environment setup

```bash
# create React app with Vite
npm create vite@latest my-app -- --template react
cd my-app
npm install

# install common dependencies
npm install react-router-dom    # routing
npm install tailwindcss         # styling
npm install @supabase/supabase-js # database
npm install lucide-react        # icons

# start dev server
npm run dev
```

### git from day one

```bash
git init
echo "node_modules\n.env\ndist" > .gitignore
git add .
git commit -m "initial project setup"
```

create a GitHub repo and push. every feature you build = a commit. this gives you a history you can revert to.

---

## phase 6: build the frontend

### component thinking

break your UI into components before coding. a component is a reusable, self-contained piece of UI.

```
every page → break into sections
every section → break into components
every component → break into smaller components

dashboard page
├── Navbar
├── Sidebar
└── MainContent
    ├── StatsRow
    │   ├── StatCard
    │   ├── StatCard
    │   └── StatCard
    ├── GoalsList
    │   └── GoalItem (repeated)
    └── RecentActivity
        └── ActivityItem (repeated)
```

build bottom up — small components first, then compose them into pages.

### building a component

think about every component in three ways:

**1. what data does it need?** (props)
**2. what state does it manage internally?** (useState)
**3. what does it render?**

```jsx
// GoalItem component
// data it needs: goal object, onToggle function, onDelete function
// state: none (controlled by parent)

function GoalItem({ goal, onToggle, onDelete }) {
    return (
        <div className="goal-item">
            <input
                type="checkbox"
                checked={goal.completed}
                onChange={() => onToggle(goal.id)}
            />
            <span className={goal.completed ? "completed" : ""}>
                {goal.title}
            </span>
            <button onClick={() => onDelete(goal.id)}>delete</button>
        </div>
    )
}
```

### state management

**local state** — state that only one component needs. use `useState`.

**shared state** — state multiple components need. lift it to their common parent.

**global state** — state the whole app needs (current user, theme). use React Context or Zustand.

```javascript
// simple rule:
// start with useState
// if two sibling components need the same state → lift to parent
// if the whole app needs it → Context
```

### building pages

a page is just a component that represents a full screen. it:
1. fetches its data on mount (useEffect)
2. manages loading and error states
3. renders the data via smaller components

```jsx
function Dashboard() {
    const [goals, setGoals] = useState([])
    const [loading, setLoading] = useState(true)
    const [error, setError] = useState(null)

    useEffect(() => {
        fetchGoals()
    }, [])

    const fetchGoals = async () => {
        try {
            setLoading(true)
            const data = await getGoals()
            setGoals(data)
        } catch (err) {
            setError(err.message)
        } finally {
            setLoading(false)
        }
    }

    if (loading) return <Spinner />
    if (error) return <ErrorMessage message={error} />

    return (
        <div>
            <GoalsList goals={goals} />
        </div>
    )
}
```

always handle three states: loading, error, and success. never show nothing while waiting.

### routing

routing lets you have multiple "pages" in a SPA without reloading.

```jsx
// App.jsx
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom'

function App() {
    return (
        <BrowserRouter>
            <Routes>
                <Route path="/" element={<Home />} />
                <Route path="/login" element={<Login />} />
                <Route path="/dashboard" element={
                    <ProtectedRoute>
                        <Dashboard />
                    </ProtectedRoute>
                } />
                <Route path="/profile/:id" element={<Profile />} />
                <Route path="*" element={<NotFound />} />
            </Routes>
        </BrowserRouter>
    )
}

// protected route — redirect to login if not authenticated
function ProtectedRoute({ children }) {
    const { user } = useAuth()
    return user ? children : <Navigate to="/login" />
}
```

### connecting to backend / database

never put database calls directly in components. create a separate API layer.

```javascript
// lib/api.js — all API calls in one place

export const getGoals = async (userId) => {
    const { data, error } = await supabase
        .from('goals')
        .select('*')
        .eq('user_id', userId)
        .order('created_at', { ascending: false })

    if (error) throw error
    return data
}

export const createGoal = async (goal) => {
    const { data, error } = await supabase
        .from('goals')
        .insert(goal)
        .select()
        .single()

    if (error) throw error
    return data
}
```

then in your component, just call these functions. if you switch databases, you only change one file.

---

## phase 7: build the backend

you need a backend when:
- you have business logic that must run securely on the server
- you need to call third-party APIs with secret keys
- you have complex data processing
- you need to send emails, process payments, etc

with Supabase, many apps don't need a separate backend. Supabase handles auth, database, storage, and edge functions.

### API design

```
name your endpoints clearly:

GET    /api/goals           → get all goals for current user
GET    /api/goals/:id       → get specific goal
POST   /api/goals           → create goal
PATCH  /api/goals/:id       → update goal
DELETE /api/goals/:id       → delete goal

GET    /api/logs            → get all logs
POST   /api/logs            → create log
```

### FastAPI example

```python
from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel
from datetime import date

app = FastAPI()

class Goal(BaseModel):
    title: str
    date: date
    completed: bool = False

@app.get("/api/goals")
async def get_goals(user_id: str):
    # get from database
    goals = await db.fetch_goals(user_id)
    return goals

@app.post("/api/goals")
async def create_goal(goal: Goal, user_id: str):
    created = await db.create_goal(goal, user_id)
    return created

@app.patch("/api/goals/{goal_id}")
async def update_goal(goal_id: str, updates: dict):
    goal = await db.update_goal(goal_id, updates)
    if not goal:
        raise HTTPException(status_code=404, detail="Goal not found")
    return goal
```

### authentication flow

```
signup:
1. user submits email + password
2. server validates input
3. server hashes password (never store plain text)
4. server saves user to database
5. server creates session or returns JWT
6. client stores token, redirects to dashboard

login:
1. user submits email + password
2. server finds user by email
3. server compares password with stored hash
4. if match → create session/JWT → return token
5. if no match → return 401 Unauthorized

protected endpoint:
1. client sends request with token in Authorization header
2. server validates token
3. if valid → process request
4. if invalid → return 401
```

---

## phase 8: styling strategy

### CSS architecture

as your app grows, CSS becomes chaos without structure. use a naming convention.

**BEM (Block Element Modifier):**
```css
.card { }                 /* block */
.card__title { }          /* element */
.card__title--large { }   /* modifier */
.card--featured { }       /* block modifier */
```

**utility-first (Tailwind):**
```jsx
<div className="bg-gray-900 rounded-xl p-6 shadow-lg hover:shadow-xl transition">
    <h2 className="text-xl font-semibold text-white mb-2">{title}</h2>
    <p className="text-gray-400 text-sm">{description}</p>
</div>
```

### design a component in CSS

always think about every state:

```css
/* default state */
.button {
    padding: 8px 16px;
    background: var(--accent);
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.2s ease;
}

/* hover state */
.button:hover {
    background: var(--accent-dark);
    transform: translateY(-1px);
}

/* active/pressed state */
.button:active {
    transform: translateY(0);
}

/* focus state — MUST have for accessibility */
.button:focus-visible {
    outline: 2px solid var(--accent);
    outline-offset: 2px;
}

/* disabled state */
.button:disabled {
    opacity: 0.5;
    cursor: not-allowed;
    transform: none;
}

/* loading state */
.button.loading {
    pointer-events: none;
}
```

---

## phase 9: testing

you don't need a testing framework for every project. but you must test manually, systematically.

### manual testing checklist

for every feature you build:

```
functionality:
  does it do what it's supposed to do?
  does it work on mobile?
  does it work on different browsers? (Chrome, Firefox, Safari)

edge cases:
  what happens with empty state?
  what happens with very long text?
  what happens with bad/missing data?
  what happens if network is slow or fails?

error handling:
  does it show an error message when something fails?
  can the user recover from the error?

accessibility:
  can you navigate with keyboard only?
  do images have alt text?
  is there enough color contrast?
```

### testing with real data

test with real-world scenarios:
- create 100 items and see if list still works
- use a very long name and see if it breaks UI
- submit empty form and check validation
- disconnect internet and see how app handles it

---

## phase 10: deployment

### pre-deployment checklist

before you deploy:

```
code:
  no console.log left in production code
  no hardcoded API keys (use environment variables)
  no sensitive data in client-side code
  error handling everywhere

performance:
  images are optimized (compressed, right format)
  unused dependencies removed
  code minified (build tool handles this)

SEO (for websites):
  all pages have title and meta description
  images have alt text
  page loads fast

security:
  HTTPS enforced
  user input validated and sanitized
  authentication works correctly
  rate limiting on forms
```

### deployment process

**frontend to Vercel:**
```bash
# option 1: connect GitHub repo (recommended)
# push to GitHub → Vercel auto-deploys on every push

# option 2: CLI
npm install -g vercel
vercel
vercel --prod
```

**environment variables:**
```
in Vercel dashboard:
Settings → Environment Variables → Add

VITE_SUPABASE_URL = https://...
VITE_SUPABASE_ANON_KEY = eyJ...
VITE_GROQ_API_KEY = gsk_...
```

**custom domain:**
```
Vercel dashboard → project → Settings → Domains → add domain
DNS provider → add CNAME record pointing to cname.vercel-dns.com
wait 10-30 minutes for propagation
```

### deployment pipeline

```
you write code
       ↓
git commit + push to GitHub
       ↓
CI runs (if set up): tests, lint checks
       ↓
Vercel detects push → builds automatically
       ↓
if build passes → deploys to production
       ↓
site is live
```

---

## phase 11: after launch

launching is not the end. it is the beginning.

### monitor

- check error logs regularly (Vercel, Supabase dashboards)
- watch for performance issues
- monitor database usage (don't exceed free tier)

### gather feedback

- share with friends, ask them to break it
- watch someone use it without explaining anything (user testing)
- note every moment of confusion

### iterate

```
the loop:
  build → ship → measure → learn → build again
```

most successful products look nothing like their v1. the initial version teaches you what people actually want.

---

## the complete mental model

```
1. DEFINE
   what problem? who is it for? what is the MVP?

2. PLAN
   user flows → IA → data model → feature priority

3. DESIGN
   design tokens → wireframes → responsive layouts

4. STACK
   website (HTML/CSS) or app (React + backend)?

5. BUILD FRONTEND
   components → pages → routing → API calls

6. BUILD BACKEND (if needed)
   API design → endpoints → auth → database

7. STYLE
   CSS architecture → all component states

8. TEST
   functionality → edge cases → error states → mobile

9. DEPLOY
   environment variables → build → deploy → domain

10. ITERATE
    monitor → feedback → improve → repeat
```

---

## mistakes everyone makes

**building before defining** — writing code before knowing what you are building. wastes weeks.

**perfectionism before shipping** — spending 3 weeks on pixel-perfect design before anyone has used it. ship ugly, make it pretty after you know it works.

**no error handling** — assuming everything goes right. network always fails sometimes. always handle errors.

**ignoring mobile** — building only for desktop, then trying to make it responsive. mobile first always.

**over-engineering** — using microservices, Kubernetes, and Redis for an app with 5 users. start simple.

**not using version control** — one bad change and you cannot go back.

**storing secrets in code** — API keys committed to GitHub. services get hacked this way.

**not testing on real devices** — browser DevTools mobile mode is not the same as a real phone.

**building alone in silence** — not showing anyone until it is "done". share early, get feedback early.

---

## starter project ideas to practice

start small, ship something:

**website projects:**
- personal portfolio (your projects, bio, contact)
- documentation site for something you learned
- blog with markdown posts (like your notes site)

**web app projects:**
- URL shortener (short → redirect to long URL)
- expense tracker (add expenses, see totals by category)
- habit tracker (mark habits done each day)
- bookmark manager (save and tag URLs)
- simple notes app (create, edit, delete notes)

**once you are comfortable:**
- developer knowledge hub (your actual project)
- real-time chat app
- project management board

---

```
=^._.^= ship it. learn from it. build again.
```
