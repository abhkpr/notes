# TypeScript with React

> catch bugs before they happen. write code with confidence.

---

## why TypeScript

TypeScript is JavaScript with types. you write types for your data and TypeScript tells you at compile time when something is wrong — before you even run the code.

```javascript
// JavaScript — no error until runtime
function getUser(id) {
    return fetch(`/api/users/${id}`)
}

getUser("abc")   // works
getUser(123)     // works
getUser()        // works — but crashes at runtime, id is undefined

// TypeScript — error at compile time
function getUser(id: number) {
    return fetch(`/api/users/${id}`)
}

getUser("abc")   // ERROR: Argument of type 'string' is not assignable to 'number'
getUser()        // ERROR: Expected 1 arguments, but got 0
getUser(123)     // works
```

**benefits:**
- catch bugs while writing code, not after shipping
- autocomplete knows what properties exist on objects
- refactoring is safe — TypeScript tells you what breaks
- code is self-documenting — types explain what data looks like
- required in most professional React projects

---

## setup

```bash
# new React project with TypeScript
npm create vite@latest my-app -- --template react-ts

# add to existing project
npm install -D typescript @types/react @types/react-dom
npx tsc --init
```

**files:**
- `.ts` — TypeScript files
- `.tsx` — TypeScript files with JSX (React components)
- `tsconfig.json` — TypeScript configuration

---

## basic types

```typescript
// primitives
let name: string = "abhishek"
let age: number = 20
let active: boolean = true
let nothing: null = null
let notSet: undefined = undefined

// any — avoid this, it disables type checking
let data: any = "anything"

// unknown — safer than any
let input: unknown = getData()
if (typeof input === "string") {
    input.toUpperCase()  // now TypeScript knows it's a string
}

// never — function that never returns
function throwError(msg: string): never {
    throw new Error(msg)
}

// void — function that returns nothing
function logMessage(msg: string): void {
    console.log(msg)
}
```

---

## arrays and tuples

```typescript
// arrays
let numbers: number[] = [1, 2, 3]
let names: string[] = ["a", "b"]
let mixed: (string | number)[] = ["a", 1, "b", 2]
let anything: Array<string> = ["a", "b"]  // generic syntax

// readonly array — cannot be mutated
let fixed: readonly number[] = [1, 2, 3]
fixed.push(4)  // ERROR

// tuple — fixed length, fixed types at each position
let point: [number, number] = [10, 20]
let entry: [string, number] = ["age", 20]

// named tuple (clearer)
let user: [name: string, age: number] = ["abhishek", 20]
```

---

## objects and types

```typescript
// inline type
let user: { name: string; age: number; email: string } = {
    name: "abhishek",
    age: 20,
    email: "a@b.com"
}

// type alias — reusable type definition
type User = {
    id: number
    name: string
    email: string
    age?: number          // optional — may or may not exist
    readonly createdAt: Date  // cannot be changed after creation
}

// use it
const user: User = {
    id: 1,
    name: "abhishek",
    email: "a@b.com",
    createdAt: new Date()
}

user.createdAt = new Date()  // ERROR: readonly

// nested types
type Post = {
    id: number
    title: string
    author: User          // nested object type
    tags: string[]
    metadata: {
        views: number
        likes: number
    }
}
```

---

## interfaces

interfaces are similar to type aliases but are designed for objects and can be extended.

```typescript
// interface
interface User {
    id: number
    name: string
    email: string
}

// extend interface
interface Admin extends User {
    role: "admin" | "superadmin"
    permissions: string[]
}

// implement in class
class UserService implements User {
    id: number
    name: string
    email: string

    constructor(id: number, name: string, email: string) {
        this.id = id
        this.name = name
        this.email = email
    }
}

// type vs interface:
// type: can represent primitives, unions, tuples — more flexible
// interface: only objects, can be extended and merged — better for OOP
// in React: use type for props and state (most common), interface for classes
```

---

## union and intersection types

```typescript
// union — either one or the other
type ID = string | number
type Status = "active" | "inactive" | "pending"  // string literal union
type Result = Success | Error

let id: ID = "abc123"   // ok
let id: ID = 123        // ok
let id: ID = true       // ERROR

// literal types
type Direction = "north" | "south" | "east" | "west"
type HttpMethod = "GET" | "POST" | "PUT" | "PATCH" | "DELETE"
type Mood = 1 | 2 | 3 | 4 | 5

// intersection — both at the same time
type Employee = User & {
    department: string
    salary: number
}

// the resulting type has ALL properties from both
const emp: Employee = {
    id: 1,
    name: "Abhishek",
    email: "a@b.com",
    department: "Engineering",
    salary: 50000
}
```

---

## functions

```typescript
// parameter types and return type
function add(a: number, b: number): number {
    return a + b
}

// arrow function
const greet = (name: string): string => `hello ${name}`

// optional parameters
function createUser(name: string, age?: number): User {
    return { name, age: age ?? 0 }
}

// default parameters
function greet(name: string = "stranger"): string {
    return `hello ${name}`
}

// rest parameters
function sum(...numbers: number[]): number {
    return numbers.reduce((a, b) => a + b, 0)
}

// function type
type Handler = (event: MouseEvent) => void
type Transformer = (input: string) => string
type AsyncFetcher = (url: string) => Promise<User>

// overloads — same function, different signatures
function format(value: string): string
function format(value: number): string
function format(value: string | number): string {
    return String(value)
}

// void vs undefined
function log(msg: string): void { console.log(msg) }  // doesn't return
function nothing(): undefined { return undefined }     // returns undefined
```

---

## generics

generics let you write reusable code that works with any type while still being type-safe.

```typescript
// generic function — T is a type parameter
function identity<T>(value: T): T {
    return value
}

identity<string>("hello")   // T = string
identity<number>(42)        // T = number
identity("hello")           // T inferred as string

// generic array function
function first<T>(arr: T[]): T | undefined {
    return arr[0]
}

first([1, 2, 3])         // returns number | undefined
first(["a", "b", "c"])   // returns string | undefined

// generic API fetcher
async function fetchData<T>(url: string): Promise<T> {
    const res = await fetch(url)
    return res.json() as T
}

const user = await fetchData<User>('/api/user/1')
const posts = await fetchData<Post[]>('/api/posts')

// generic type with constraint
function getProperty<T, K extends keyof T>(obj: T, key: K): T[K] {
    return obj[key]
}

const user = { name: "abhi", age: 20 }
getProperty(user, "name")   // string
getProperty(user, "age")    // number
getProperty(user, "email")  // ERROR: "email" doesn't exist on type

// generic interface
interface ApiResponse<T> {
    data: T
    message: string
    success: boolean
}

type UserResponse = ApiResponse<User>
type PostListResponse = ApiResponse<Post[]>
```

---

## utility types

TypeScript has built-in utility types for common transformations.

```typescript
type User = {
    id: number
    name: string
    email: string
    password: string
    age: number
}

// Partial — all fields optional (for update operations)
type UpdateUser = Partial<User>
// { id?: number; name?: string; email?: string; ... }

// Required — all fields required
type RequiredUser = Required<User>

// Readonly — all fields readonly
type ImmutableUser = Readonly<User>

// Pick — select specific fields
type PublicUser = Pick<User, "id" | "name" | "email">
// { id: number; name: string; email: string }

// Omit — exclude specific fields
type SafeUser = Omit<User, "password">
// everything except password

// Record — object with specific key and value types
type UserMap = Record<string, User>
const users: UserMap = { "abc": user1, "def": user2 }

// Exclude — remove from union
type WithoutNull = Exclude<string | null | undefined, null | undefined>
// string

// Extract — keep only matching
type StringOrNumber = Extract<string | number | boolean, string | number>
// string | number

// NonNullable — remove null and undefined
type Defined = NonNullable<string | null | undefined>
// string

// ReturnType — get return type of function
function getUser() { return { id: 1, name: "abhi" } }
type UserType = ReturnType<typeof getUser>
// { id: number; name: string }

// Parameters — get parameter types of function
type GetUserParams = Parameters<typeof getUser>

// Awaited — unwrap promise type
type ResolvedUser = Awaited<Promise<User>>
// User
```

---

## TypeScript with React

### typed components

```typescript
// props type
type ButtonProps = {
    label: string
    onClick: () => void
    variant?: "primary" | "secondary" | "danger"
    disabled?: boolean
    loading?: boolean
}

// functional component with typed props
function Button({ label, onClick, variant = "primary", disabled, loading }: ButtonProps) {
    return (
        <button
            className={`btn btn-${variant}`}
            onClick={onClick}
            disabled={disabled || loading}
        >
            {loading ? "Loading..." : label}
        </button>
    )
}

// with children
type CardProps = {
    title: string
    children: React.ReactNode    // any valid JSX
    className?: string
}

function Card({ title, children, className = "" }: CardProps) {
    return (
        <div className={`card ${className}`}>
            <h2>{title}</h2>
            {children}
        </div>
    )
}

// React.FC (older style — you'll see this in existing code)
const Button: React.FC<ButtonProps> = ({ label, onClick }) => {
    return <button onClick={onClick}>{label}</button>
}
// prefer the function syntax above — React.FC has some issues
```

### typed useState

```typescript
// TypeScript infers type from initial value
const [count, setCount] = useState(0)       // number
const [name, setName] = useState("")        // string
const [active, setActive] = useState(false) // boolean

// explicit type when initial value is null/undefined
const [user, setUser] = useState<User | null>(null)
const [posts, setPosts] = useState<Post[]>([])
const [error, setError] = useState<string | null>(null)

// complex state
type FormState = {
    name: string
    email: string
    message: string
}

const [form, setForm] = useState<FormState>({
    name: "",
    email: "",
    message: ""
})
```

### typed useRef

```typescript
// DOM ref — must match element type
const inputRef = useRef<HTMLInputElement>(null)
const divRef = useRef<HTMLDivElement>(null)
const buttonRef = useRef<HTMLButtonElement>(null)

// access safely
inputRef.current?.focus()   // optional chaining for null
if (inputRef.current) {
    inputRef.current.value = ""
}

// mutable value ref (no null)
const countRef = useRef<number>(0)
countRef.current = 5  // always has a value
```

### typed useEffect and useCallback

```typescript
// useEffect — no return type needed (returns cleanup or nothing)
useEffect(() => {
    const handler = (e: KeyboardEvent) => {
        if (e.key === "Escape") closeModal()
    }
    document.addEventListener("keydown", handler)
    return () => document.removeEventListener("keydown", handler)
}, [])

// useCallback
const handleClick = useCallback((id: number): void => {
    deleteItem(id)
}, [])

const fetchUser = useCallback(async (id: string): Promise<User> => {
    const res = await fetch(`/api/users/${id}`)
    return res.json()
}, [])
```

### typed events

```typescript
// common event types
const handleClick = (e: React.MouseEvent<HTMLButtonElement>) => {
    e.preventDefault()
}

const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setValue(e.target.value)
}

const handleSelect = (e: React.ChangeEvent<HTMLSelectElement>) => {
    setSelected(e.target.value)
}

const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()
}

const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === "Enter") submit()
}

// inline (TypeScript infers from element)
<input onChange={(e) => setValue(e.target.value)} />
<button onClick={(e) => handleClick(e)} />
<form onSubmit={(e) => handleSubmit(e)} />
```

### typed custom hooks

```typescript
// useFetch hook
function useFetch<T>(url: string) {
    const [data, setData] = useState<T | null>(null)
    const [loading, setLoading] = useState(true)
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const fetchData = async () => {
            try {
                const res = await fetch(url)
                const json: T = await res.json()
                setData(json)
            } catch (err) {
                setError(err instanceof Error ? err.message : "Unknown error")
            } finally {
                setLoading(false)
            }
        }
        fetchData()
    }, [url])

    return { data, loading, error }
}

// usage — TypeScript knows what data is
const { data: users, loading } = useFetch<User[]>('/api/users')
const { data: post } = useFetch<Post>('/api/posts/1')

// useLocalStorage hook
function useLocalStorage<T>(key: string, initial: T): [T, (val: T) => void] {
    const [value, setValue] = useState<T>(() => {
        const stored = localStorage.getItem(key)
        return stored ? JSON.parse(stored) : initial
    })

    const setStored = (val: T) => {
        setValue(val)
        localStorage.setItem(key, JSON.stringify(val))
    }

    return [value, setStored]
}
```

### typed context

```typescript
// define context type
type AuthContextType = {
    user: User | null
    loading: boolean
    login: (email: string, password: string) => Promise<void>
    logout: () => void
}

// create context with type
const AuthContext = createContext<AuthContextType | null>(null)

// provider
export function AuthProvider({ children }: { children: React.ReactNode }) {
    const [user, setUser] = useState<User | null>(null)
    const [loading, setLoading] = useState(true)

    const login = async (email: string, password: string): Promise<void> => {
        const userData = await authApi.login(email, password)
        setUser(userData)
    }

    const logout = (): void => {
        setUser(null)
    }

    return (
        <AuthContext.Provider value={{ user, loading, login, logout }}>
            {children}
        </AuthContext.Provider>
    )
}

// typed hook
export function useAuth(): AuthContextType {
    const context = useContext(AuthContext)
    if (!context) throw new Error("useAuth must be used within AuthProvider")
    return context
}
```

---

## type narrowing

TypeScript narrows types based on conditions.

```typescript
// typeof narrowing
function process(value: string | number) {
    if (typeof value === "string") {
        return value.toUpperCase()  // TypeScript knows: string
    }
    return value.toFixed(2)         // TypeScript knows: number
}

// instanceof narrowing
function handleError(error: unknown) {
    if (error instanceof Error) {
        console.log(error.message)  // TypeScript knows: Error
    }
}

// in operator narrowing
type Cat = { meow: () => void }
type Dog = { bark: () => void }

function makeSound(animal: Cat | Dog) {
    if ("meow" in animal) {
        animal.meow()  // TypeScript knows: Cat
    } else {
        animal.bark()  // TypeScript knows: Dog
    }
}

// discriminated union — best pattern for complex types
type Success = { status: "success"; data: User }
type Error = { status: "error"; message: string }
type Loading = { status: "loading" }

type State = Success | Error | Loading

function render(state: State) {
    switch (state.status) {
        case "success":
            return state.data.name  // TypeScript knows: Success
        case "error":
            return state.message    // TypeScript knows: Error
        case "loading":
            return "Loading..."     // TypeScript knows: Loading
    }
}
```

---

## tsconfig.json

```json
{
    "compilerOptions": {
        "target": "ES2020",
        "lib": ["ES2020", "DOM", "DOM.Iterable"],
        "module": "ESNext",
        "moduleResolution": "bundler",
        "jsx": "react-jsx",
        "strict": true,              // enable all strict checks
        "noUnusedLocals": true,      // error on unused variables
        "noUnusedParameters": true,  // error on unused parameters
        "noImplicitReturns": true,   // all code paths must return
        "skipLibCheck": true,
        "paths": {
            "@/*": ["./src/*"]       // alias: import from '@/components'
        }
    }
}
```

**`strict: true`** enables:
- `strictNullChecks` — null and undefined are not assignable to other types
- `noImplicitAny` — must explicitly type `any`
- `strictFunctionTypes` — stricter function type checking

always start with strict mode. easier than adding it later.

---

```
=^._.^= types are documentation that never goes stale
```
