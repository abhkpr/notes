# React

> the library for building user interfaces.

---

## what is React

React is a JavaScript library for building UIs. created by Facebook in 2013, it is now the most widely used frontend library.

**the core idea:** instead of manually manipulating the DOM, you describe what the UI should look like based on data (state). when data changes, React automatically updates the UI to match.

```
traditional DOM manipulation:
  data changes → you write code to find element → you manually update it

React way:
  data changes → React re-renders component → DOM updates automatically
```

**why React:**
- component-based: build reusable pieces
- declarative: describe what you want, not how to do it
- huge ecosystem: libraries for everything
- most in-demand frontend skill

---

## JSX

JSX is HTML-like syntax inside JavaScript. React compiles it to regular JS.

```jsx
// JSX
const element = <h1 className="title">Hello {name}</h1>

// compiles to
const element = React.createElement('h1', { className: 'title' }, 'Hello ' + name)
```

**JSX rules:**
```jsx
// 1. use className instead of class
<div className="card">

// 2. all tags must be closed
<img src="..." />
<br />
<input type="text" />

// 3. return one root element (or fragment)
return (
    <div>
        <h1>Title</h1>
        <p>Content</p>
    </div>
)

// or use fragment (renders nothing extra in DOM)
return (
    <>
        <h1>Title</h1>
        <p>Content</p>
    </>
)

// 4. JavaScript goes inside curly braces
<p>{user.name}</p>
<p>{2 + 2}</p>
<p>{isLoggedIn ? 'Welcome' : 'Please login'}</p>

// 5. style is an object
<div style={{ color: 'red', fontSize: '16px' }}>

// 6. camelCase for attributes
<input onChange={handler} onKeyDown={handler} />
<button onClick={handler} />
```

---

## components

a component is a function that returns JSX. it is the building block of React apps.

```jsx
// functional component
function Greeting({ name }) {
    return <h1>Hello {name}</h1>
}

// arrow function component
const Greeting = ({ name }) => {
    return <h1>Hello {name}</h1>
}

// use it
<Greeting name="Abhishek" />
```

**rules:**
- component name must start with capital letter
- must return JSX (or null)
- must be a pure function (same props = same output)

---

## props

props (properties) are inputs passed to a component. they are read-only — a component never modifies its own props.

```jsx
// passing props
<UserCard
    name="Abhishek"
    age={20}
    isStudent={true}
    onClick={handleClick}
    user={{ name: "Abhi", email: "a@b.com" }}
/>

// receiving props
function UserCard({ name, age, isStudent, onClick, user }) {
    return (
        <div onClick={onClick}>
            <h2>{name}</h2>
            <p>Age: {age}</p>
            {isStudent && <span>Student</span>}
        </div>
    )
}

// default props
function Button({ label = "Click me", variant = "primary" }) {
    return <button className={variant}>{label}</button>
}

// children prop — what goes between opening and closing tags
function Card({ children, title }) {
    return (
        <div className="card">
            <h2>{title}</h2>
            <div className="card-body">{children}</div>
        </div>
    )
}

<Card title="My Card">
    <p>This goes into children</p>
    <button>Action</button>
</Card>

// spread props
const buttonProps = { onClick: handleClick, disabled: false }
<button {...buttonProps}>Click</button>
```

---

## state (useState)

state is data that can change over time. when state changes, React re-renders the component.

```jsx
import { useState } from 'react'

function Counter() {
    // [currentValue, setterFunction] = useState(initialValue)
    const [count, setCount] = useState(0)

    return (
        <div>
            <p>Count: {count}</p>
            <button onClick={() => setCount(count + 1)}>+</button>
            <button onClick={() => setCount(count - 1)}>-</button>
            <button onClick={() => setCount(0)}>Reset</button>
        </div>
    )
}
```

**state rules:**
```jsx
// NEVER mutate state directly
state.name = 'new'        // WRONG — React won't re-render
setName('new')            // CORRECT

// for objects, spread and update
const [user, setUser] = useState({ name: 'Abhi', age: 20 })
setUser({ ...user, age: 21 })      // update one field
setUser(prev => ({ ...prev, age: prev.age + 1 }))  // based on previous

// for arrays, return new array
const [items, setItems] = useState([])
setItems([...items, newItem])               // add
setItems(items.filter(i => i.id !== id))   // remove
setItems(items.map(i => i.id === id ? { ...i, done: true } : i))  // update
```

**functional updates** — when new state depends on previous state, use function form:
```jsx
// risky (stale state in async code)
setCount(count + 1)

// safe (always gets latest state)
setCount(prev => prev + 1)
```

---

## side effects (useEffect)

useEffect runs code after a component renders. used for: fetching data, subscriptions, timers, DOM manipulation.

```jsx
import { useEffect } from 'react'

// runs after EVERY render
useEffect(() => {
    console.log('rendered')
})

// runs ONCE after first render (component mounted)
useEffect(() => {
    fetchData()
}, [])  // empty dependency array

// runs when 'userId' changes
useEffect(() => {
    fetchUser(userId)
}, [userId])

// cleanup function (runs before next effect or when component unmounts)
useEffect(() => {
    const timer = setInterval(() => {
        setTime(new Date())
    }, 1000)

    return () => clearInterval(timer)  // cleanup
}, [])

// fetching data pattern
useEffect(() => {
    let cancelled = false

    const fetchData = async () => {
        setLoading(true)
        try {
            const data = await getUsers()
            if (!cancelled) {
                setUsers(data)
            }
        } catch (err) {
            if (!cancelled) setError(err.message)
        } finally {
            if (!cancelled) setLoading(false)
        }
    }

    fetchData()

    return () => { cancelled = true }  // prevent state update on unmounted component
}, [])
```

**dependency array rules:**
- no array: runs after every render
- empty array `[]`: runs once on mount
- `[a, b]`: runs when a or b changes
- include every value from component scope that the effect uses

---

## derived state and memoization

some values don't need useState — they can be calculated from existing state.

```jsx
// bad — unnecessary state
const [users, setUsers] = useState([])
const [filteredUsers, setFilteredUsers] = useState([])

useEffect(() => {
    setFilteredUsers(users.filter(u => u.active))
}, [users])

// good — derived value
const [users, setUsers] = useState([])
const filteredUsers = users.filter(u => u.active)  // calculated on every render
```

**useMemo** — memoize expensive calculations (recalculate only when deps change):
```jsx
import { useMemo } from 'react'

const expensiveResult = useMemo(() => {
    return processLargeDataset(data)
}, [data])  // only recalculates when data changes
```

**useCallback** — memoize functions (prevent child re-renders):
```jsx
import { useCallback } from 'react'

const handleClick = useCallback((id) => {
    deleteItem(id)
}, [])  // stable function reference
```

---

## context (useContext)

context shares data without passing props through every level. use for: current user, theme, language.

```jsx
import { createContext, useContext, useState } from 'react'

// 1. create context
const AuthContext = createContext(null)

// 2. create provider component
export function AuthProvider({ children }) {
    const [user, setUser] = useState(null)
    const [loading, setLoading] = useState(true)

    const login = async (email, password) => {
        const user = await signIn(email, password)
        setUser(user)
    }

    const logout = async () => {
        await signOut()
        setUser(null)
    }

    return (
        <AuthContext.Provider value={{ user, loading, login, logout }}>
            {children}
        </AuthContext.Provider>
    )
}

// 3. create custom hook
export function useAuth() {
    const context = useContext(AuthContext)
    if (!context) throw new Error('useAuth must be used within AuthProvider')
    return context
}

// 4. wrap app with provider
function App() {
    return (
        <AuthProvider>
            <Router>
                <Routes>...</Routes>
            </Router>
        </AuthProvider>
    )
}

// 5. use in any component
function Navbar() {
    const { user, logout } = useAuth()

    return (
        <nav>
            {user ? (
                <>
                    <span>Hello {user.name}</span>
                    <button onClick={logout}>Logout</button>
                </>
            ) : (
                <a href="/login">Login</a>
            )}
        </nav>
    )
}
```

---

## useRef

useRef stores a mutable value that does NOT trigger re-render. used for: DOM references, storing previous values, timers.

```jsx
import { useRef, useEffect } from 'react'

// DOM reference
function SearchBar() {
    const inputRef = useRef(null)

    useEffect(() => {
        inputRef.current.focus()  // focus input on mount
    }, [])

    return <input ref={inputRef} type="text" />
}

// store mutable value without re-render
function Timer() {
    const intervalRef = useRef(null)
    const [count, setCount] = useState(0)

    const start = () => {
        intervalRef.current = setInterval(() => {
            setCount(prev => prev + 1)
        }, 1000)
    }

    const stop = () => {
        clearInterval(intervalRef.current)
    }

    return (
        <div>
            <p>{count}</p>
            <button onClick={start}>Start</button>
            <button onClick={stop}>Stop</button>
        </div>
    )
}

// store previous value
function Component({ value }) {
    const prevValue = useRef(value)

    useEffect(() => {
        prevValue.current = value
    }, [value])

    return <p>Current: {value}, Previous: {prevValue.current}</p>
}
```

---

## custom hooks

extract reusable logic into custom hooks. a custom hook is a function starting with `use` that calls other hooks.

```jsx
// useFetch — reusable data fetching
function useFetch(url) {
    const [data, setData] = useState(null)
    const [loading, setLoading] = useState(true)
    const [error, setError] = useState(null)

    useEffect(() => {
        let cancelled = false

        const fetchData = async () => {
            setLoading(true)
            setError(null)
            try {
                const res = await fetch(url)
                const json = await res.json()
                if (!cancelled) setData(json)
            } catch (err) {
                if (!cancelled) setError(err.message)
            } finally {
                if (!cancelled) setLoading(false)
            }
        }

        fetchData()
        return () => { cancelled = true }
    }, [url])

    return { data, loading, error }
}

// usage
function UserList() {
    const { data: users, loading, error } = useFetch('/api/users')

    if (loading) return <Spinner />
    if (error) return <Error message={error} />
    return <ul>{users.map(u => <li key={u.id}>{u.name}</li>)}</ul>
}

// useLocalStorage
function useLocalStorage(key, initialValue) {
    const [value, setValue] = useState(() => {
        try {
            const item = localStorage.getItem(key)
            return item ? JSON.parse(item) : initialValue
        } catch {
            return initialValue
        }
    })

    const setStoredValue = (newValue) => {
        setValue(newValue)
        localStorage.setItem(key, JSON.stringify(newValue))
    }

    return [value, setStoredValue]
}

// useDebounce — delay value update
function useDebounce(value, delay = 500) {
    const [debouncedValue, setDebouncedValue] = useState(value)

    useEffect(() => {
        const timer = setTimeout(() => {
            setDebouncedValue(value)
        }, delay)
        return () => clearTimeout(timer)
    }, [value, delay])

    return debouncedValue
}

// useToggle
function useToggle(initial = false) {
    const [value, setValue] = useState(initial)
    const toggle = useCallback(() => setValue(v => !v), [])
    return [value, toggle]
}
```

---

## rendering patterns

```jsx
// conditional rendering
function Component({ isLoggedIn, data }) {
    // if/else
    if (!isLoggedIn) return <Login />

    // ternary
    return (
        <div>
            {isLoggedIn ? <Dashboard /> : <Login />}

            {/* && short circuit — renders only if true */}
            {data && <DataTable data={data} />}

            {/* null renders nothing */}
            {false && <p>this never renders</p>}
        </div>
    )
}

// list rendering — always add key
function UserList({ users }) {
    return (
        <ul>
            {users.map(user => (
                <UserItem key={user.id} user={user} />
            ))}
        </ul>
    )
}

// key must be unique and stable (don't use array index if list can reorder)

// loading/error/empty pattern
function DataComponent() {
    const { data, loading, error } = useFetch('/api/data')

    if (loading) return <LoadingSpinner />
    if (error) return <ErrorMessage message={error} />
    if (!data || data.length === 0) return <EmptyState />

    return <DataGrid data={data} />
}
```

---

## forms in React

```jsx
// controlled input — React controls the value
function LoginForm() {
    const [email, setEmail] = useState('')
    const [password, setPassword] = useState('')
    const [error, setError] = useState(null)
    const [loading, setLoading] = useState(false)

    const handleSubmit = async (e) => {
        e.preventDefault()  // prevent page reload
        setLoading(true)
        setError(null)

        try {
            await login(email, password)
        } catch (err) {
            setError(err.message)
        } finally {
            setLoading(false)
        }
    }

    return (
        <form onSubmit={handleSubmit}>
            <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="Email"
                required
            />
            <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="Password"
                minLength={8}
            />
            {error && <p className="error">{error}</p>}
            <button type="submit" disabled={loading}>
                {loading ? 'Logging in...' : 'Login'}
            </button>
        </form>
    )
}

// form with single state object
function ProfileForm({ user }) {
    const [form, setForm] = useState({
        name: user.name || '',
        bio: user.bio || '',
        college: user.college || ''
    })

    const handleChange = (e) => {
        const { name, value } = e.target
        setForm(prev => ({ ...prev, [name]: value }))
    }

    return (
        <form>
            <input name="name" value={form.name} onChange={handleChange} />
            <input name="bio" value={form.bio} onChange={handleChange} />
            <input name="college" value={form.college} onChange={handleChange} />
        </form>
    )
}
```

---

## performance optimization

```jsx
// React.memo — skip re-render if props haven't changed
const UserCard = React.memo(function UserCard({ user }) {
    return <div>{user.name}</div>
})

// useMemo — memoize expensive computation
const sortedUsers = useMemo(() => {
    return [...users].sort((a, b) => a.name.localeCompare(b.name))
}, [users])

// useCallback — stable function reference for child components
const handleDelete = useCallback((id) => {
    setItems(prev => prev.filter(item => item.id !== id))
}, [])

// lazy loading — load component only when needed
const HeavyComponent = lazy(() => import('./HeavyComponent'))

function App() {
    return (
        <Suspense fallback={<Spinner />}>
            <HeavyComponent />
        </Suspense>
    )
}
```

**when to optimize:** don't optimize prematurely. only use memo/useMemo/useCallback when you can measure a performance problem. they add complexity.

---

## project structure patterns

```
src/
├── components/          → reusable UI components
│   ├── ui/              → basic building blocks (Button, Input, Card)
│   └── features/        → feature-specific components
│       └── auth/
│           ├── LoginForm.jsx
│           └── SignupForm.jsx
├── pages/               → route-level components
│   ├── Home.jsx
│   ├── Dashboard.jsx
│   └── Profile.jsx
├── hooks/               → custom hooks
│   ├── useAuth.js
│   ├── useFetch.js
│   └── useLocalStorage.js
├── lib/                 → utilities, API clients, config
│   ├── supabase.js
│   ├── api.js
│   └── utils.js
├── context/             → React context providers
│   └── AuthContext.jsx
├── App.jsx
├── main.jsx
└── index.css
```

---

```
=^._.^= think in components. think in state.
```
