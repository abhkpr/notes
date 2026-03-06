# Design Patterns

> solutions to problems that every developer faces. know the names, think at a higher level.

---

## what are design patterns

design patterns are reusable solutions to commonly occurring problems in software design. they are not code you copy-paste — they are blueprints you adapt to your situation.

coined by the "Gang of Four" in 1994 in the book "Design Patterns". the 23 patterns they described still apply today, though the language has changed.

**why learn them:**
- you are already using some without knowing their names
- naming a pattern lets you communicate complex ideas in one word
- knowing patterns helps you spot the right solution faster
- code becomes easier to reason about and maintain

**three categories:**
- **creational** — how objects are created
- **structural** — how objects are composed together
- **behavioral** — how objects communicate

---

## creational patterns

### singleton

ensures a class has only ONE instance. that instance is shared everywhere.

**use when:** database connection, config object, logger, app-wide state.

```javascript
// bad — creates new connection every time
function getDatabase() {
    return new DatabaseConnection(config)
}

// singleton — one connection shared everywhere
class Database {
    static instance = null

    static getInstance() {
        if (!Database.instance) {
            Database.instance = new Database()
        }
        return Database.instance
    }

    constructor() {
        this.connection = new DatabaseConnection(config)
    }

    query(sql) {
        return this.connection.query(sql)
    }
}

// usage — always returns same instance
const db1 = Database.getInstance()
const db2 = Database.getInstance()
db1 === db2  // true — same object

// in JavaScript modules — module system is already singleton
// lib/supabase.js
import { createClient } from '@supabase/supabase-js'

export const supabase = createClient(URL, KEY)
// every file that imports supabase gets the SAME instance — module singleton
```

```python
# Python singleton using module (simplest)
# config.py
import os
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
JWT_SECRET = os.getenv("JWT_SECRET")
DEBUG = os.getenv("DEBUG", "false").lower() == "true"

# importing this module always gives same object — singleton
from config import DATABASE_URL  # same value everywhere
```

---

### factory

creates objects without specifying the exact class. a function or method that decides what to create.

**use when:** creating different types of objects based on condition, hiding complex creation logic.

```javascript
// without factory — creation logic scattered everywhere
if (type === "admin") {
    user = new AdminUser(name, email, permissions)
} else if (type === "student") {
    user = new StudentUser(name, email, college)
} else {
    user = new GuestUser(name)
}

// factory — creation in one place
class UserFactory {
    static create(type, data) {
        switch (type) {
            case "admin":
                return new AdminUser(data.name, data.email, data.permissions)
            case "student":
                return new StudentUser(data.name, data.email, data.college)
            case "guest":
                return new GuestUser(data.name)
            default:
                throw new Error(`Unknown user type: ${type}`)
        }
    }
}

// usage
const user = UserFactory.create("student", { name: "Abhishek", college: "IIT" })
```

```python
# Python factory
def create_storage(storage_type: str):
    if storage_type == "local":
        return LocalStorage("/uploads")
    elif storage_type == "s3":
        return S3Storage(bucket=os.getenv("S3_BUCKET"))
    elif storage_type == "supabase":
        return SupabaseStorage(client=supabase)
    else:
        raise ValueError(f"Unknown storage type: {storage_type}")

# usage — changes based on environment
storage = create_storage(os.getenv("STORAGE_TYPE", "local"))
```

---

### builder

constructs complex objects step by step. lets you create different variations using the same construction process.

**use when:** object has many optional fields, creating SQL queries, building HTTP requests.

```javascript
// without builder — constructor hell
const query = new DatabaseQuery(
    "users",        // table
    ["id", "name"], // fields
    { age: 20 },    // where
    "name",         // order by
    "ASC",          // direction
    10,             // limit
    0               // offset
)

// with builder — readable, flexible
class QueryBuilder {
    constructor(table) {
        this.table = table
        this._fields = ["*"]
        this._where = {}
        this._orderBy = null
        this._limit = null
        this._offset = 0
    }

    select(...fields) {
        this._fields = fields
        return this  // return this for chaining
    }

    where(conditions) {
        this._where = { ...this._where, ...conditions }
        return this
    }

    orderBy(field, direction = "ASC") {
        this._orderBy = `${field} ${direction}`
        return this
    }

    limit(n) {
        this._limit = n
        return this
    }

    offset(n) {
        this._offset = n
        return this
    }

    build() {
        let sql = `SELECT ${this._fields.join(", ")} FROM ${this.table}`
        if (Object.keys(this._where).length) {
            const conditions = Object.entries(this._where)
                .map(([k, v]) => `${k} = '${v}'`)
                .join(" AND ")
            sql += ` WHERE ${conditions}`
        }
        if (this._orderBy) sql += ` ORDER BY ${this._orderBy}`
        if (this._limit) sql += ` LIMIT ${this._limit}`
        if (this._offset) sql += ` OFFSET ${this._offset}`
        return sql
    }
}

// usage — reads like English
const query = new QueryBuilder("users")
    .select("id", "name", "email")
    .where({ city: "Lucknow", active: true })
    .orderBy("name", "ASC")
    .limit(20)
    .offset(40)
    .build()
```

---

## structural patterns

### repository

separates data access logic from business logic. your components/services never talk to the database directly — they talk to the repository.

**use when:** always. this is the most important pattern for apps with a database.

```javascript
// without repository — data access mixed with business logic
async function Dashboard() {
    // direct database call in component — bad
    const { data } = await supabase
        .from('goals')
        .select('*')
        .eq('user_id', user.id)
        .order('created_at', { ascending: false })

    return <GoalList goals={data} />
}

// with repository — clean separation
// lib/repositories/goalsRepository.js
class GoalsRepository {
    async findByUser(userId, date = null) {
        let query = supabase
            .from('goals')
            .select('*')
            .eq('user_id', userId)
            .order('created_at', { ascending: false })

        if (date) query = query.eq('date', date)

        const { data, error } = await query
        if (error) throw error
        return data
    }

    async create(goal) {
        const { data, error } = await supabase
            .from('goals')
            .insert(goal)
            .select()
            .single()
        if (error) throw error
        return data
    }

    async update(id, updates) {
        const { data, error } = await supabase
            .from('goals')
            .update(updates)
            .eq('id', id)
            .select()
            .single()
        if (error) throw error
        return data
    }

    async delete(id) {
        const { error } = await supabase
            .from('goals')
            .delete()
            .eq('id', id)
        if (error) throw error
    }
}

export const goalsRepository = new GoalsRepository()

// component — clean, no database knowledge
async function Dashboard() {
    const goals = await goalsRepository.findByUser(user.id, today)
    return <GoalList goals={goals} />
}

// benefit: swap Supabase for any database → change only the repository
```

```python
# Python repository pattern
class GoalsRepository:
    def __init__(self, db):
        self.db = db

    async def find_by_user(self, user_id: str, date: str = None):
        query = "SELECT * FROM goals WHERE user_id = $1"
        params = [user_id]
        if date:
            query += " AND date = $2"
            params.append(date)
        return await self.db.fetch(query, *params)

    async def create(self, goal: dict):
        return await self.db.fetchrow(
            "INSERT INTO goals (user_id, title, date) VALUES ($1, $2, $3) RETURNING *",
            goal["user_id"], goal["title"], goal["date"]
        )

    async def update(self, id: str, updates: dict):
        set_clause = ", ".join(f"{k} = ${i+2}" for i, k in enumerate(updates.keys()))
        values = list(updates.values())
        return await self.db.fetchrow(
            f"UPDATE goals SET {set_clause} WHERE id = $1 RETURNING *",
            id, *values
        )

# inject repository into routes
goals_repo = GoalsRepository(db)

@router.get("/api/goals")
async def get_goals(user_id = Depends(get_current_user)):
    return await goals_repo.find_by_user(user_id)
```

---

### adapter

makes incompatible interfaces work together. wraps an object with a different interface.

**use when:** integrating third-party libraries, switching between services.

```javascript
// you have code that expects this interface
interface StorageService {
    save(key: string, data: any): Promise<void>
    load(key: string): Promise<any>
    delete(key: string): Promise<void>
}

// but you are using Supabase Storage (different API)
class SupabaseStorageAdapter implements StorageService {
    constructor(private supabase, private bucket: string) {}

    async save(key: string, data: any): Promise<void> {
        await this.supabase.storage
            .from(this.bucket)
            .upload(key, JSON.stringify(data))
    }

    async load(key: string): Promise<any> {
        const { data } = await this.supabase.storage
            .from(this.bucket)
            .download(key)
        return JSON.parse(await data.text())
    }

    async delete(key: string): Promise<void> {
        await this.supabase.storage
            .from(this.bucket)
            .remove([key])
    }
}

// your code works with any storage — swap Supabase for S3 anytime
const storage: StorageService = new SupabaseStorageAdapter(supabase, "uploads")
storage.save("user/avatar", imageData)
```

---

### decorator

adds behavior to an object without modifying it. wraps it with extra functionality.

**use when:** logging, caching, rate limiting, authentication — add to any function.

```javascript
// basic function
async function fetchUser(id) {
    const res = await fetch(`/api/users/${id}`)
    return res.json()
}

// decorator adds caching
function withCache(fn, ttl = 60000) {
    const cache = new Map()

    return async function(...args) {
        const key = JSON.stringify(args)

        if (cache.has(key)) {
            const { value, expiry } = cache.get(key)
            if (Date.now() < expiry) {
                console.log("cache hit:", key)
                return value
            }
        }

        const result = await fn(...args)
        cache.set(key, { value: result, expiry: Date.now() + ttl })
        return result
    }
}

// decorator adds logging
function withLogging(fn) {
    return async function(...args) {
        console.log(`calling ${fn.name} with`, args)
        const start = Date.now()
        const result = await fn(...args)
        console.log(`${fn.name} took ${Date.now() - start}ms`)
        return result
    }
}

// decorate the function
const cachedFetchUser = withCache(fetchUser, 5 * 60 * 1000)  // 5 min cache
const loggedFetchUser = withLogging(cachedFetchUser)

loggedFetchUser(1)  // logged + cached
```

```python
# Python decorators (built into language)
import functools
import time

# timing decorator
def timer(func):
    @functools.wraps(func)
    async def wrapper(*args, **kwargs):
        start = time.time()
        result = await func(*args, **kwargs)
        print(f"{func.__name__} took {time.time() - start:.3f}s")
        return result
    return wrapper

# cache decorator
def cache(ttl=60):
    def decorator(func):
        cached = {}
        @functools.wraps(func)
        async def wrapper(*args):
            key = str(args)
            if key in cached:
                value, expiry = cached[key]
                if time.time() < expiry:
                    return value
            result = await func(*args)
            cached[key] = (result, time.time() + ttl)
            return result
        return wrapper
    return decorator

# use decorators
@timer
@cache(ttl=300)
async def get_user(user_id: str):
    return await db.fetch_one("SELECT * FROM users WHERE id = $1", user_id)

# FastAPI dependency decorators
@app.get("/api/goals")
@limiter.limit("100/minute")
async def get_goals(user = Depends(get_current_user)):
    ...
```

---

## behavioral patterns

### observer (pub/sub)

one object (publisher) notifies many objects (subscribers) when something happens. subscribers don't know about each other.

**use when:** event systems, real-time updates, decoupling components.

```javascript
// event emitter — observer pattern
class EventEmitter {
    constructor() {
        this.listeners = {}
    }

    on(event, callback) {
        if (!this.listeners[event]) {
            this.listeners[event] = []
        }
        this.listeners[event].push(callback)
        // return unsubscribe function
        return () => this.off(event, callback)
    }

    off(event, callback) {
        this.listeners[event] = this.listeners[event]
            ?.filter(cb => cb !== callback)
    }

    emit(event, data) {
        this.listeners[event]?.forEach(cb => cb(data))
    }
}

const events = new EventEmitter()

// subscribers
const unsubGoal = events.on("goal:created", (goal) => {
    console.log("new goal:", goal.title)
    updateDashboard(goal)
})

events.on("goal:created", (goal) => {
    sendNotification(`Goal created: ${goal.title}`)
})

events.on("user:login", (user) => {
    analytics.track("login", { userId: user.id })
})

// publisher
async function createGoal(data) {
    const goal = await db.create(data)
    events.emit("goal:created", goal)  // all subscribers notified
    return goal
}

// unsubscribe when done
unsubGoal()
```

```javascript
// React — useState and useEffect are observer pattern
// state is the publisher, components are subscribers
const [goals, setGoals] = useState([])
// every component that uses 'goals' is subscribed to it
// setGoals notifies all subscribers (re-renders)
```

---

### strategy

define a family of algorithms, put each in its own class, make them interchangeable.

**use when:** multiple ways to do the same thing, want to swap algorithms at runtime.

```javascript
// sorting strategies
const strategies = {
    byDate: (a, b) => new Date(b.createdAt) - new Date(a.createdAt),
    byTitle: (a, b) => a.title.localeCompare(b.title),
    byCompletion: (a, b) => b.completed - a.completed,
    byPriority: (a, b) => b.priority - a.priority
}

function sortGoals(goals, strategy) {
    return [...goals].sort(strategies[strategy])
}

// usage — swap strategy at runtime
const sorted = sortGoals(goals, "byDate")
const byName = sortGoals(goals, "byTitle")

// React — strategy in UI
function GoalList({ goals }) {
    const [sortBy, setSortBy] = useState("byDate")

    const sorted = sortGoals(goals, sortBy)

    return (
        <div>
            <select onChange={e => setSortBy(e.target.value)}>
                <option value="byDate">Newest first</option>
                <option value="byTitle">Alphabetical</option>
                <option value="byCompletion">Completion</option>
            </select>
            {sorted.map(goal => <GoalItem key={goal.id} goal={goal} />)}
        </div>
    )
}
```

```python
# payment strategy pattern
from abc import ABC, abstractmethod

class PaymentStrategy(ABC):
    @abstractmethod
    async def process(self, amount: float) -> bool:
        pass

class RazorpayStrategy(PaymentStrategy):
    async def process(self, amount: float) -> bool:
        # razorpay API call
        return True

class StripeStrategy(PaymentStrategy):
    async def process(self, amount: float) -> bool:
        # stripe API call
        return True

class UPIStrategy(PaymentStrategy):
    async def process(self, amount: float) -> bool:
        # UPI API call
        return True

# use any strategy
async def checkout(amount: float, payment_method: str):
    strategies = {
        "razorpay": RazorpayStrategy(),
        "stripe": StripeStrategy(),
        "upi": UPIStrategy()
    }
    strategy = strategies.get(payment_method)
    if not strategy:
        raise ValueError(f"Unknown payment method: {payment_method}")
    return await strategy.process(amount)
```

---

### middleware / chain of responsibility

pass a request through a chain of handlers. each handler decides to process it or pass it along.

**use when:** HTTP middleware, validation pipelines, event processing.

```javascript
// Express/FastAPI middleware IS chain of responsibility
// request passes through each middleware in order

// custom middleware pipeline
class Pipeline {
    constructor() {
        this.steps = []
    }

    use(step) {
        this.steps.push(step)
        return this
    }

    async execute(context) {
        let index = 0

        const next = async () => {
            if (index < this.steps.length) {
                const step = this.steps[index++]
                await step(context, next)
            }
        }

        await next()
        return context
    }
}

// define pipeline
const pipeline = new Pipeline()
    .use(async (ctx, next) => {
        console.log("step 1: validate input")
        if (!ctx.data.title) throw new Error("Title required")
        await next()
    })
    .use(async (ctx, next) => {
        console.log("step 2: sanitize")
        ctx.data.title = ctx.data.title.trim()
        await next()
    })
    .use(async (ctx, next) => {
        console.log("step 3: save to database")
        ctx.result = await db.create(ctx.data)
        await next()
    })

// run pipeline
const context = { data: { title: "  Study React  " } }
await pipeline.execute(context)
console.log(context.result)  // saved goal
```

---

### command

encapsulate a request as an object. lets you parameterize, queue, log, and undo operations.

**use when:** undo/redo functionality, queuing operations, logging actions.

```javascript
// command pattern for undo/redo
class GoalManager {
    constructor() {
        this.goals = []
        this.history = []  // stack of commands
        this.redoStack = []
    }

    execute(command) {
        command.execute(this.goals)
        this.history.push(command)
        this.redoStack = []  // clear redo on new action
    }

    undo() {
        const command = this.history.pop()
        if (command) {
            command.undo(this.goals)
            this.redoStack.push(command)
        }
    }

    redo() {
        const command = this.redoStack.pop()
        if (command) {
            command.execute(this.goals)
            this.history.push(command)
        }
    }
}

// commands
class AddGoalCommand {
    constructor(goal) { this.goal = goal }
    execute(goals) { goals.push(this.goal) }
    undo(goals) { goals.splice(goals.indexOf(this.goal), 1) }
}

class DeleteGoalCommand {
    constructor(goal) {
        this.goal = goal
        this.index = null
    }
    execute(goals) {
        this.index = goals.indexOf(this.goal)
        goals.splice(this.index, 1)
    }
    undo(goals) {
        goals.splice(this.index, 0, this.goal)
    }
}

// usage
const manager = new GoalManager()
manager.execute(new AddGoalCommand({ id: 1, title: "Study React" }))
manager.execute(new AddGoalCommand({ id: 2, title: "Study SQL" }))
manager.undo()  // removes "Study SQL"
manager.redo()  // adds "Study SQL" back
```

---

## MVC — Model View Controller

not one of the original Gang of Four patterns, but the most widely used architectural pattern. separates application into three parts.

```
Model      → data and business logic (database, rules)
View       → what user sees (HTML, components)
Controller → handles input, connects model and view
```

```
React + FastAPI:

Model:      PostgreSQL database + Pydantic models + business logic
View:       React components (JSX)
Controller: FastAPI routes + React event handlers
```

```python
# FastAPI as MVC

# Model (models.py)
class Goal(BaseModel):
    id: str
    title: str
    completed: bool
    user_id: str

# Controller (routers/goals.py)
@router.post("/api/goals")
async def create_goal(goal: GoalCreate, user = Depends(get_current_user)):
    # controller validates, calls model, returns to view
    if not goal.title.strip():
        raise HTTPException(400, "Title cannot be empty")
    created = await goals_repo.create({ **goal.dict(), "user_id": user.id })
    return { "data": created }

# View (React components) — separate codebase
```

---

## patterns you already use

```
useState + context    → observer pattern
React Router          → front controller
API layer (lib/api.js)→ facade pattern
useCallback + useMemo → flyweight pattern
Supabase client       → singleton
try/catch everywhere  → chain of responsibility
.map() .filter()      → iterator pattern
```

---

## when NOT to use patterns

patterns are tools, not rules. adding a pattern when you do not need it makes code more complex, not better.

**do not use a pattern if:**
- it adds more code than it saves
- the problem it solves does not exist yet
- simpler code achieves the same thing

start simple. reach for patterns when you feel the pain the pattern solves.

---

```
=^._.^= patterns are vocabulary, not rules
```
