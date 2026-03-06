# Full Stack — Frontend and Backend Together

> how the two halves connect into one working product.

---

## the big picture

a full stack app has two halves that work together:

```
user's browser                    your server
┌─────────────────┐               ┌──────────────────┐
│    FRONTEND     │   HTTP/JSON   │     BACKEND      │
│                 │◄────────────►│                  │
│  React (UI)     │               │  FastAPI (logic) │
│  HTML/CSS/JS    │               │  PostgreSQL (data)│
│  State          │               │  Auth            │
└─────────────────┘               └──────────────────┘
```

the frontend shows the UI and handles user interactions.
the backend processes logic, enforces rules, and talks to the database.
they communicate through an API — the contract between them.

---

## why separation matters

**security** — frontend code runs in the user's browser. anyone can see it, modify it, inspect it. never put secrets, business logic, or direct database access in the frontend. the backend is the gatekeeper.

**flexibility** — with a good API, you can build a web app, Android app, and iOS app all using the same backend.

**scaling** — frontend and backend can be scaled independently. if your UI gets millions of views (CDN), your API can scale separately.

**team work** — frontend and backend developers work in parallel once the API contract is agreed.

---

## the request-response cycle

every interaction follows this cycle:

```
1. user clicks "Load Goals" button

2. frontend runs:
   const goals = await fetch('/api/goals', {
       headers: { 'Authorization': `Bearer ${token}` }
   })

3. HTTP request leaves browser:
   GET /api/goals HTTP/1.1
   Host: api.studentos.com
   Authorization: Bearer eyJ...

4. backend receives request:
   - validates JWT token (who is this?)
   - checks permissions (are they allowed?)
   - queries database (get their goals)
   - formats response as JSON

5. HTTP response goes back:
   HTTP/1.1 200 OK
   Content-Type: application/json
   { "data": [...goals] }

6. frontend receives response:
   - parses JSON
   - updates state: setGoals(data)
   - React re-renders UI with goals

7. user sees their goals
```

---

## project structure for full stack

```
my-app/
├── frontend/              → React app
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── hooks/
│   │   ├── lib/
│   │   │   └── api.js    → all API calls
│   │   └── App.jsx
│   ├── .env
│   └── package.json
│
└── backend/               → FastAPI app
    ├── main.py            → FastAPI app, routes
    ├── models.py          → Pydantic models
    ├── database.py        → DB connection
    ├── auth.py            → JWT logic
    ├── routers/
    │   ├── goals.py       → /api/goals routes
    │   ├── logs.py        → /api/logs routes
    │   └── users.py       → /api/users routes
    ├── requirements.txt
    └── .env
```

---

## the API layer — the contract

the API is the contract between frontend and backend. agree on it before building either side.

**design the API first** — write down every endpoint, its method, request body, and response shape. both sides build to this contract.

```
GOALS API:

GET    /api/goals
  auth: required
  query: ?date=2026-03-06
  response: { data: Goal[], count: number }

POST   /api/goals
  auth: required
  body: { title: string, date: string }
  response: { data: Goal }
  errors: 400 (invalid), 401 (no auth)

PATCH  /api/goals/:id
  auth: required
  body: { title?: string, completed?: boolean }
  response: { data: Goal }
  errors: 404 (not found), 403 (not yours)

DELETE /api/goals/:id
  auth: required
  response: 204 No Content
  errors: 404, 403
```

---

## building the API client (frontend)

create one place in your frontend that handles all API communication. never scatter fetch calls across components.

```javascript
// frontend/src/lib/api.js

const BASE_URL = import.meta.env.VITE_API_URL

// helper to get auth token
const getToken = () => localStorage.getItem('token')

// base request function
async function request(method, path, body = null) {
    const headers = {
        'Content-Type': 'application/json'
    }

    const token = getToken()
    if (token) {
        headers['Authorization'] = `Bearer ${token}`
    }

    const config = {
        method,
        headers
    }

    if (body) {
        config.body = JSON.stringify(body)
    }

    const response = await fetch(`${BASE_URL}${path}`, config)

    // handle no content (DELETE)
    if (response.status === 204) return null

    const data = await response.json()

    // throw error with server message
    if (!response.ok) {
        throw new Error(data.detail || data.message || 'Something went wrong')
    }

    return data
}

// clean API interface
export const api = {
    get: (path) => request('GET', path),
    post: (path, body) => request('POST', path, body),
    patch: (path, body) => request('PATCH', path, body),
    delete: (path) => request('DELETE', path)
}

// feature-specific functions
export const goalsApi = {
    list: (date) => api.get(`/api/goals${date ? `?date=${date}` : ''}`),
    create: (goal) => api.post('/api/goals', goal),
    update: (id, updates) => api.patch(`/api/goals/${id}`, updates),
    delete: (id) => api.delete(`/api/goals/${id}`)
}

export const authApi = {
    login: (credentials) => api.post('/api/auth/login', credentials),
    signup: (userData) => api.post('/api/auth/signup', userData),
    logout: () => api.post('/api/auth/logout')
}
```

---

## using the API in React components

```jsx
// hooks/useGoals.js — custom hook for goals
import { useState, useEffect, useCallback } from 'react'
import { goalsApi } from '../lib/api'

export function useGoals(date) {
    const [goals, setGoals] = useState([])
    const [loading, setLoading] = useState(true)
    const [error, setError] = useState(null)

    const fetchGoals = useCallback(async () => {
        setLoading(true)
        setError(null)
        try {
            const { data } = await goalsApi.list(date)
            setGoals(data)
        } catch (err) {
            setError(err.message)
        } finally {
            setLoading(false)
        }
    }, [date])

    useEffect(() => {
        fetchGoals()
    }, [fetchGoals])

    const createGoal = async (title) => {
        try {
            const { data } = await goalsApi.create({ title, date })
            setGoals(prev => [...prev, data])
        } catch (err) {
            setError(err.message)
        }
    }

    const toggleGoal = async (id) => {
        const goal = goals.find(g => g.id === id)
        try {
            setGoals(prev => prev.map(g =>
                g.id === id ? { ...g, completed: !g.completed } : g
            ))
            await goalsApi.update(id, { completed: !goal.completed })
        } catch (err) {
            // revert on failure
            setGoals(prev => prev.map(g =>
                g.id === id ? { ...g, completed: goal.completed } : g
            ))
            setError(err.message)
        }
    }

    const deleteGoal = async (id) => {
        try {
            setGoals(prev => prev.filter(g => g.id !== id))
            await goalsApi.delete(id)
        } catch (err) {
            fetchGoals()  // refetch on failure
            setError(err.message)
        }
    }

    return { goals, loading, error, createGoal, toggleGoal, deleteGoal }
}

// Dashboard.jsx — uses the hook
function Dashboard() {
    const today = new Date().toISOString().split('T')[0]
    const { goals, loading, error, createGoal, toggleGoal, deleteGoal } = useGoals(today)

    if (loading) return <LoadingSpinner />
    if (error) return <ErrorMessage message={error} />

    return (
        <div>
            <GoalForm onSubmit={createGoal} />
            <GoalList
                goals={goals}
                onToggle={toggleGoal}
                onDelete={deleteGoal}
            />
        </div>
    )
}
```

---

## backend routes (FastAPI)

```python
# backend/routers/goals.py

from fastapi import APIRouter, Depends, HTTPException
from typing import Optional
from datetime import date as DateType

from ..auth import get_current_user
from ..database import db
from ..models import GoalCreate, GoalUpdate, GoalResponse

router = APIRouter(prefix="/api/goals", tags=["goals"])

@router.get("", response_model=dict)
async def list_goals(
    date: Optional[DateType] = None,
    user_id: str = Depends(get_current_user)
):
    goals = await db.goals.find(user_id=user_id, date=date)
    return { "data": goals, "count": len(goals) }

@router.post("", response_model=dict, status_code=201)
async def create_goal(
    goal: GoalCreate,
    user_id: str = Depends(get_current_user)
):
    created = await db.goals.create({
        **goal.dict(),
        "user_id": user_id
    })
    return { "data": created }

@router.patch("/{goal_id}", response_model=dict)
async def update_goal(
    goal_id: str,
    updates: GoalUpdate,
    user_id: str = Depends(get_current_user)
):
    goal = await db.goals.find_one(id=goal_id)

    if not goal:
        raise HTTPException(404, "Goal not found")
    if goal.user_id != user_id:
        raise HTTPException(403, "Not your goal")

    updated = await db.goals.update(
        goal_id,
        updates.dict(exclude_none=True)
    )
    return { "data": updated }

@router.delete("/{goal_id}", status_code=204)
async def delete_goal(
    goal_id: str,
    user_id: str = Depends(get_current_user)
):
    goal = await db.goals.find_one(id=goal_id)

    if not goal:
        raise HTTPException(404, "Goal not found")
    if goal.user_id != user_id:
        raise HTTPException(403, "Not your goal")

    await db.goals.delete(goal_id)

# backend/main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .routers import goals, logs, users, auth

app = FastAPI()

app.add_middleware(CORSMiddleware,
    allow_origins=["http://localhost:5173", "https://app.abhishekkumar.xyz"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)

app.include_router(auth.router)
app.include_router(goals.router)
app.include_router(logs.router)
app.include_router(users.router)
```

---

## authentication flow end to end

```
SIGNUP:

frontend:                        backend:
user fills form                  POST /api/auth/signup
→ POST /api/auth/signup    →     validate input
  { name, email, password }      check email not taken
                                 hash password (bcrypt)
                           ←     save user to DB
  { token, user }                create JWT
→ store token                    return token + user
→ redirect to dashboard

LOGIN:

frontend:                        backend:
user fills form                  POST /api/auth/login
→ POST /api/auth/login     →     find user by email
  { email, password }            verify password hash
                           ←     if match: create JWT
  { token, user }                return token + user
→ store token
→ redirect to dashboard

PROTECTED REQUEST:

frontend:                        backend:
→ GET /api/goals           →     extract token from header
  Authorization: Bearer...       verify JWT signature
                                 check expiry
                                 get user_id from token
                                 query DB for their goals
                           ←     return goals
  { data: [...] }
→ update state
→ render goals
```

**implementation:**

```javascript
// frontend/src/context/AuthContext.jsx
export function AuthProvider({ children }) {
    const [user, setUser] = useState(null)
    const [loading, setLoading] = useState(true)

    useEffect(() => {
        // check if already logged in
        const token = localStorage.getItem('token')
        const savedUser = localStorage.getItem('user')
        if (token && savedUser) {
            setUser(JSON.parse(savedUser))
        }
        setLoading(false)
    }, [])

    const login = async (email, password) => {
        const { token, user } = await authApi.login({ email, password })
        localStorage.setItem('token', token)
        localStorage.setItem('user', JSON.stringify(user))
        setUser(user)
    }

    const logout = () => {
        localStorage.removeItem('token')
        localStorage.removeItem('user')
        setUser(null)
    }

    return (
        <AuthContext.Provider value={{ user, loading, login, logout }}>
            {!loading && children}
        </AuthContext.Provider>
    )
}
```

---

## optimistic updates

update the UI immediately, then sync with backend. makes app feel instant.

```javascript
const toggleGoal = async (id) => {
    const goal = goals.find(g => g.id === id)
    const newCompleted = !goal.completed

    // 1. update UI immediately (optimistic)
    setGoals(prev => prev.map(g =>
        g.id === id ? { ...g, completed: newCompleted } : g
    ))

    try {
        // 2. sync with backend
        await goalsApi.update(id, { completed: newCompleted })
    } catch (err) {
        // 3. revert if backend fails
        setGoals(prev => prev.map(g =>
            g.id === id ? { ...g, completed: goal.completed } : g
        ))
        showError('Failed to update goal')
    }
}
```

---

## error handling across the stack

errors should be handled at every layer:

```
database error
      ↓
backend catches it, returns appropriate HTTP status + message
      ↓
frontend api.js receives non-ok response, throws Error with message
      ↓
component catches error, sets error state
      ↓
UI shows error message to user
```

```python
# backend — always return clear error messages
@router.post("/api/goals")
async def create_goal(goal: GoalCreate):
    try:
        created = await db.goals.create(goal.dict())
        return { "data": created }
    except UniqueViolation:
        raise HTTPException(409, "Goal already exists for this date")
    except Exception as e:
        logger.error(f"Failed to create goal: {e}")
        raise HTTPException(500, "Failed to create goal")
```

```javascript
// frontend — one place to handle API errors
async function request(method, path, body) {
    try {
        const response = await fetch(...)
        const data = await response.json()

        if (!response.ok) {
            // handle specific error codes
            if (response.status === 401) {
                logout()  // token expired, logout user
                throw new Error('Session expired')
            }
            throw new Error(data.detail || 'Request failed')
        }

        return data
    } catch (err) {
        if (err.name === 'TypeError') {
            // network error (no internet, server down)
            throw new Error('Connection failed. Check your internet.')
        }
        throw err
    }
}
```

---

## environment configuration

```
development:
  frontend: localhost:5173
  backend: localhost:8000
  database: local PostgreSQL or Supabase

production:
  frontend: app.abhishekkumar.xyz (Vercel)
  backend: api.abhishekkumar.xyz (Railway)
  database: Supabase
```

```bash
# frontend/.env.development
VITE_API_URL=http://localhost:8000

# frontend/.env.production
VITE_API_URL=https://api.abhishekkumar.xyz

# backend/.env
DATABASE_URL=postgresql://...
JWT_SECRET=long-random-secret
CORS_ORIGINS=http://localhost:5173,https://app.abhishekkumar.xyz
```

---

## running full stack locally

```bash
# terminal 1 — backend
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn main:app --reload --port 8000

# terminal 2 — frontend
cd frontend
npm install
npm run dev
# runs on localhost:5173
# calls backend at localhost:8000
```

---

## deployment

```
STEP 1: deploy backend to Railway
  - connect GitHub repo
  - add environment variables
  - Railway auto-detects FastAPI
  - get URL: https://backend-abc.railway.app

STEP 2: set backend URL in frontend
  - frontend/.env.production:
    VITE_API_URL=https://backend-abc.railway.app

STEP 3: deploy frontend to Vercel
  - connect GitHub repo
  - add environment variables
  - Vercel auto-builds React
  - get URL: https://app.abhishekkumar.xyz

STEP 4: update CORS on backend
  - add frontend URL to allow_origins
  - redeploy backend
```

---

## common patterns

**loading state pattern:**
```jsx
function Page() {
    const { data, loading, error } = useFetch('/api/data')

    if (loading) return <Skeleton />    // show skeleton while loading
    if (error) return <Error />         // show error state
    if (!data?.length) return <Empty /> // show empty state
    return <DataList data={data} />     // show data
}
```

**form submission pattern:**
```jsx
const [status, setStatus] = useState('idle') // idle loading success error

const handleSubmit = async (formData) => {
    setStatus('loading')
    try {
        await api.post('/api/resource', formData)
        setStatus('success')
    } catch (err) {
        setStatus('error')
        setError(err.message)
    }
}

return (
    <button disabled={status === 'loading'}>
        {status === 'loading' ? 'Saving...' : 'Save'}
    </button>
)
```

---

```
=^._.^= frontend shows. backend knows. together they do.
```
