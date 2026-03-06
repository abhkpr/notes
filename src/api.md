# API Design and REST

> how programs talk to each other. the backbone of every app.

---

## what is an API

API (Application Programming Interface) is a contract between two programs. one program exposes a set of operations, the other calls them.

when your React frontend fetches users from your backend, it uses an API. when your app calls the Groq AI service, it uses an API. when Supabase saves your goals, it uses an API.

**why APIs matter:**
- frontend and backend are decoupled (can change independently)
- one backend can serve web app, mobile app, third-party apps
- multiple teams can work simultaneously
- you can version your API to not break existing clients

---

## REST

REST (Representational State Transfer) is the standard architecture for web APIs. it uses HTTP methods to perform operations on resources.

**resources** — the things your API manages. users, posts, goals, orders.
**endpoints** — the URLs where you access resources.
**HTTP methods** — the operations you perform.

```
HTTP method + URL = action

GET    /users          → list all users
GET    /users/123      → get user with id 123
POST   /users          → create a new user
PUT    /users/123      → replace user 123 completely
PATCH  /users/123      → update specific fields of user 123
DELETE /users/123      → delete user 123
```

---

## URL design

good URL design is clear, consistent, and predictable.

```
rules:
  use nouns, not verbs (resources, not actions)
  use plural for collections
  use lowercase and hyphens
  nest related resources

# good
GET /users
GET /users/123
GET /users/123/posts
GET /posts/456/comments
POST /users
DELETE /users/123

# bad
GET /getUsers
GET /user/123
GET /fetchAllPosts
POST /createNewUser
GET /user-posts/123
```

**resource hierarchy:**
```
/users                    → collection of users
/users/:id                → specific user
/users/:id/posts          → posts belonging to that user
/users/:id/posts/:postId  → specific post of that user

/organizations/:orgId/members/:userId  → member in org
```

**query parameters for filtering, sorting, pagination:**
```
/posts?published=true                    → filter
/users?city=Lucknow&age=20              → multiple filters
/posts?sort=created_at&order=desc        → sort
/users?page=2&limit=20                   → pagination
/users?page=2&per_page=20               → alternative pagination
/posts?fields=id,title,created_at        → field selection
/users?search=abhishek                   → search
/posts?include=author,comments           → include relations
```

---

## HTTP methods in detail

**GET** — read data. safe and idempotent. no body.
```
GET /users/123
→ returns user data
→ calling it 10 times has same result as calling once
→ never changes anything
```

**POST** — create a new resource. not idempotent.
```
POST /users
body: { "name": "Abhishek", "email": "a@b.com" }
→ creates new user
→ calling twice creates two users
```

**PUT** — replace resource entirely. idempotent.
```
PUT /users/123
body: { "name": "Abhishek Kumar", "email": "a@b.com", "age": 20 }
→ replaces all fields of user 123
→ fields not in body are set to null/default
```

**PATCH** — update specific fields. idempotent.
```
PATCH /users/123
body: { "age": 21 }
→ updates only age, other fields unchanged
→ most common for partial updates
```

**DELETE** — remove resource. idempotent.
```
DELETE /users/123
→ deletes user 123
→ calling again: still deleted (idempotent)
```

---

## HTTP status codes

always return the right status code. clients use these to understand what happened.

```
2xx — success
200 OK                  → standard success
201 Created             → resource created (POST)
204 No Content          → success, no body (DELETE)

3xx — redirect
301 Moved Permanently   → resource moved, update your URL
302 Found               → temporary redirect
304 Not Modified        → cached response still valid

4xx — client error (caller's fault)
400 Bad Request         → invalid input, validation failed
401 Unauthorized        → not authenticated (not logged in)
403 Forbidden           → authenticated but no permission
404 Not Found           → resource does not exist
405 Method Not Allowed  → wrong HTTP method
409 Conflict            → conflict (duplicate email)
410 Gone                → resource permanently deleted
422 Unprocessable       → validation error with details
429 Too Many Requests   → rate limited

5xx — server error (your fault)
500 Internal Server Error → something broke on server
502 Bad Gateway           → upstream server failed
503 Service Unavailable   → server overloaded or down
504 Gateway Timeout       → upstream server timed out
```

---

## request and response format

**request headers:**
```
Content-Type: application/json    → body format
Authorization: Bearer <jwt-token> → auth token
Accept: application/json          → what format you want back
X-Request-ID: abc-123             → tracking ID
```

**request body (POST/PUT/PATCH):**
```json
{
    "name": "Abhishek Kumar",
    "email": "abhishek@example.com",
    "age": 20
}
```

**response structure — be consistent:**
```json
{
    "data": {
        "id": "123",
        "name": "Abhishek Kumar",
        "email": "abhishek@example.com",
        "created_at": "2026-03-06T10:00:00Z"
    },
    "message": "User created successfully"
}
```

**error response:**
```json
{
    "error": {
        "code": "VALIDATION_ERROR",
        "message": "Invalid email address",
        "details": [
            { "field": "email", "message": "Must be a valid email" },
            { "field": "age", "message": "Must be at least 18" }
        ]
    }
}
```

**list response with pagination:**
```json
{
    "data": [...],
    "pagination": {
        "page": 2,
        "per_page": 20,
        "total": 150,
        "total_pages": 8,
        "has_next": true,
        "has_prev": true
    }
}
```

---

## authentication

**how JWT works:**
```
1. user logs in with email + password
2. server verifies credentials
3. server creates JWT containing user ID and signs it
4. server sends JWT to client
5. client stores JWT (localStorage or cookie)
6. every request: client sends JWT in Authorization header
7. server validates JWT on every request
8. server knows who the user is from JWT payload
```

**JWT structure:**
```
header.payload.signature

eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiIxMjMiLCJleHAiOjE3...

decoded:
header:    { "alg": "HS256", "typ": "JWT" }
payload:   { "userId": "123", "email": "a@b.com", "exp": 1735689600 }
signature: HMAC-SHA256(header + payload, secret_key)
```

the signature is what makes it tamper-proof. if anyone changes the payload, the signature becomes invalid.

**sending JWT in requests:**
```javascript
fetch('/api/goals', {
    headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
    }
})
```

**API key authentication (for server-to-server):**
```
x-api-key: your-secret-api-key
```

---

## building a REST API with FastAPI

```python
from fastapi import FastAPI, HTTPException, Depends, status
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime

app = FastAPI(title="StudentOS API", version="1.0.0")

# CORS — allow frontend to call API
app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://app.abhishekkumar.xyz", "http://localhost:5173"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# models
class GoalCreate(BaseModel):
    title: str
    date: str

class GoalUpdate(BaseModel):
    title: Optional[str] = None
    completed: Optional[bool] = None

class GoalResponse(BaseModel):
    id: str
    title: str
    completed: bool
    date: str
    created_at: datetime

# routes
@app.get("/api/goals", response_model=list[GoalResponse])
async def get_goals(user_id: str = Depends(get_current_user)):
    goals = await db.fetch_goals(user_id)
    return goals

@app.post("/api/goals", response_model=GoalResponse, status_code=201)
async def create_goal(
    goal: GoalCreate,
    user_id: str = Depends(get_current_user)
):
    created = await db.create_goal({ **goal.dict(), "user_id": user_id })
    return created

@app.patch("/api/goals/{goal_id}", response_model=GoalResponse)
async def update_goal(
    goal_id: str,
    updates: GoalUpdate,
    user_id: str = Depends(get_current_user)
):
    goal = await db.get_goal(goal_id)

    if not goal:
        raise HTTPException(status_code=404, detail="Goal not found")

    if goal.user_id != user_id:
        raise HTTPException(status_code=403, detail="Not your goal")

    updated = await db.update_goal(goal_id, updates.dict(exclude_none=True))
    return updated

@app.delete("/api/goals/{goal_id}", status_code=204)
async def delete_goal(
    goal_id: str,
    user_id: str = Depends(get_current_user)
):
    goal = await db.get_goal(goal_id)

    if not goal:
        raise HTTPException(status_code=404, detail="Goal not found")

    if goal.user_id != user_id:
        raise HTTPException(status_code=403, detail="Not your goal")

    await db.delete_goal(goal_id)
```

---

## validation

validate everything that comes from the client. never trust input.

```python
from pydantic import BaseModel, validator, EmailStr, constr

class UserCreate(BaseModel):
    name: constr(min_length=2, max_length=50)
    email: EmailStr
    password: constr(min_length=8)
    age: int

    @validator('age')
    def age_must_be_valid(cls, v):
        if v < 13 or v > 120:
            raise ValueError('Age must be between 13 and 120')
        return v

    @validator('name')
    def name_must_be_clean(cls, v):
        if not v.replace(' ', '').isalpha():
            raise ValueError('Name must contain only letters')
        return v.strip()
```

---

## rate limiting

prevent abuse by limiting how many requests a client can make.

```python
from slowapi import Limiter
from slowapi.util import get_remote_address

limiter = Limiter(key_func=get_remote_address)
app.state.limiter = limiter

@app.post("/api/login")
@limiter.limit("5/minute")  # max 5 login attempts per minute
async def login(request: Request, credentials: LoginForm):
    ...

@app.get("/api/goals")
@limiter.limit("100/minute")  # 100 reads per minute is fine
async def get_goals():
    ...
```

---

## API versioning

as your API evolves, you need to add features without breaking existing clients.

```
URL versioning (most common):
/api/v1/users
/api/v2/users

header versioning:
API-Version: 2

accept header versioning:
Accept: application/vnd.myapi.v2+json
```

```python
# FastAPI versioning
from fastapi import APIRouter

v1 = APIRouter(prefix="/api/v1")
v2 = APIRouter(prefix="/api/v2")

@v1.get("/users")
async def get_users_v1():
    return [{ "id": 1, "name": "Abhishek" }]

@v2.get("/users")
async def get_users_v2():
    return {
        "data": [{ "id": 1, "name": "Abhishek", "avatar": "..." }],
        "pagination": { "total": 1 }
    }

app.include_router(v1)
app.include_router(v2)
```

---

## API documentation

FastAPI auto-generates documentation. access at `/docs` (Swagger) and `/redoc`.

```python
app = FastAPI(
    title="StudentOS API",
    description="API for tracking student progress",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

@app.post("/api/goals", response_model=GoalResponse, status_code=201,
    summary="Create a new goal",
    description="Creates a daily micro goal for the authenticated user")
async def create_goal(
    goal: GoalCreate = Body(..., example={
        "title": "Study React hooks for 1 hour",
        "date": "2026-03-06"
    })
):
    """
    Create a new goal with:
    - **title**: what you want to achieve
    - **date**: the date for this goal
    """
    ...
```

---

## calling APIs from frontend

```javascript
// base API client
const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000'

const api = {
    async get(path) {
        const token = localStorage.getItem('token')
        const res = await fetch(`${API_URL}${path}`, {
            headers: {
                'Authorization': token ? `Bearer ${token}` : '',
                'Content-Type': 'application/json'
            }
        })
        if (!res.ok) {
            const error = await res.json()
            throw new Error(error.detail || 'Request failed')
        }
        return res.json()
    },

    async post(path, body) {
        const token = localStorage.getItem('token')
        const res = await fetch(`${API_URL}${path}`, {
            method: 'POST',
            headers: {
                'Authorization': token ? `Bearer ${token}` : '',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(body)
        })
        if (!res.ok) {
            const error = await res.json()
            throw new Error(error.detail || 'Request failed')
        }
        return res.json()
    },

    async patch(path, body) { /* similar */ },
    async delete(path) { /* similar */ }
}

// usage
const goals = await api.get('/api/goals')
const newGoal = await api.post('/api/goals', { title: 'Study SQL', date: '2026-03-06' })
```

---

```
=^._.^= a good API is a joy to use. a bad one is a nightmare.
```
