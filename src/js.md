# JavaScript and TypeScript

> make it interactive. make it work.

---

## what is JavaScript

JavaScript (JS) is the programming language of the web. while HTML structures content and CSS styles it, JavaScript makes it **interactive and dynamic**.

originally created in 1995 by Brendan Eich in just 10 days, it has grown into one of the most widely used programming languages in the world. today it runs:
- in the browser (frontend)
- on servers (Node.js backend)
- in mobile apps (React Native)
- in desktop apps (Electron)

**JavaScript engine** — every browser has one (V8 in Chrome, SpiderMonkey in Firefox). it reads and executes JS code.

**JavaScript is single-threaded** — it can only do one thing at a time. but it handles async operations (network requests, timers) without blocking using an **event loop**.

---

## how JS runs in the browser

```
HTML is parsed
      ↓
browser encounters <script src="app.js">
      ↓
JS file is downloaded
      ↓
JS engine parses and compiles JS
      ↓
JS executes: manipulates DOM, handles events, fetches data
      ↓
user interacts → event fires → JS responds
```

---

## variables

variables store data. use `const` by default, `let` when you need to reassign, never use `var`.

```javascript
const name = "abhishek"    // cannot be reassigned
let count = 0              // can be reassigned
var old = "avoid"          // old way, has scoping issues

count = count + 1          // ok, let can be reassigned
name = "other"             // ERROR — const cannot be reassigned

// const with objects/arrays — the variable can't be reassigned
// but the contents CAN be changed
const user = { name: "abhi" }
user.name = "other"        // ok
user = {}                  // ERROR
```

**why avoid var?** var is function-scoped and hoisted, which causes confusing bugs. `let` and `const` are block-scoped and behave more predictably.

---

## data types

```javascript
// primitives — stored by value
let name = "abhishek"       // string
let age = 20                // number
let price = 3.99            // number (no separate float type)
let isStudent = true        // boolean
let nothing = null          // intentional empty value
let notDefined = undefined  // declared but no value
let id = Symbol('id')       // unique identifier

// reference types — stored by reference
let arr = [1, 2, 3]         // array
let obj = { name: "abhi" }  // object
let fn = () => {}           // function

// check type
typeof "hello"    // "string"
typeof 42         // "number"
typeof true       // "boolean"
typeof null       // "object" — historic bug in JS
typeof undefined  // "undefined"
typeof []         // "object"
typeof {}         // "object"
Array.isArray([]) // true — better check for arrays
```

**null vs undefined:**
- undefined = variable declared but never assigned a value
- null = intentionally set to empty, means "no value"

---

## strings

strings are sequences of characters, immutable in JS.

```javascript
let name = "abhishek"
let str1 = 'single quotes also work'
let str2 = `template literal with ${name}`  // preferred for dynamic strings

// template literals can be multiline
let html = `
    <div>
        <p>${name}</p>
    </div>
`

// common methods
name.length            // 8
name.toUpperCase()     // "ABHISHEK"
name.toLowerCase()     // "abhishek"
name.trim()            // remove whitespace from both ends
name.trimStart()       // remove from start
name.trimEnd()         // remove from end
name.includes("abhi")  // true
name.startsWith("ab")  // true
name.endsWith("ek")    // true
name.replace("abhi", "xyz")     // "xyzshek" — first match
name.replaceAll("a", "x")       // all matches
name.split("")                  // ["a","b","h",...]
name.split(" ")                 // split by space
name.slice(0, 4)                // "abhi" — (start, end)
name.slice(-2)                  // "ek" — from end
name.indexOf("sh")              // 4 — first index of
name.lastIndexOf("a")           // last index of
name.padStart(10, "0")          // "00abhishek"
name.padEnd(10, ".")            // "abhishek.."
name.repeat(2)                  // "abhishekabhishek"

// convert
Number("42")        // 42
parseInt("42px")    // 42 — extracts number
parseFloat("3.14")  // 3.14
String(42)          // "42"
(42).toString()     // "42"
```

---

## numbers

```javascript
let x = 10
let y = 3

// operators
x + y    // 13
x - y    // 7
x * y    // 30
x / y    // 3.333...
x // y   // no floor division — use Math.floor(x/y)
x % y    // 1 (remainder/modulo)
x ** y   // 1000 (exponent)

// floating point issue (famous JS quirk)
0.1 + 0.2 === 0.3    // FALSE — 0.30000000000000004
// fix: (0.1 + 0.2).toFixed(1) === "0.3"

// special values
Infinity      // result of dividing by zero
-Infinity
NaN           // Not a Number (result of invalid math)
isNaN("abc")  // true

// Math object
Math.floor(3.7)      // 3 — round down
Math.ceil(3.2)       // 4 — round up
Math.round(3.5)      // 4 — round to nearest
Math.abs(-5)         // 5 — absolute value
Math.max(1, 2, 3)    // 3
Math.min(1, 2, 3)    // 1
Math.sqrt(16)        // 4
Math.pow(2, 10)      // 1024
Math.random()        // 0 to 1 (exclusive)
Math.floor(Math.random() * 100) // 0 to 99

// number formatting
(1234567.89).toLocaleString('en-IN')  // "12,34,567.89"
(3.14159).toFixed(2)                  // "3.14"
```

---

## arrays

arrays are ordered lists. they can hold any type of value.

```javascript
let arr = [1, 2, 3, 4, 5]
let mixed = [1, "hello", true, null, { name: "abhi" }]

// access
arr[0]               // 1 — first element
arr[arr.length - 1]  // 5 — last element
arr.at(-1)           // 5 — last element (modern, clean)

// add and remove
arr.push(6)          // add to end, returns new length
arr.pop()            // remove from end, returns removed item
arr.unshift(0)       // add to start
arr.shift()          // remove from start

// splice — modify in place
arr.splice(2, 1)       // remove 1 element at index 2
arr.splice(2, 0, 99)   // insert 99 at index 2, remove nothing
arr.splice(2, 1, 99)   // replace element at index 2 with 99

// search
arr.indexOf(3)              // 2 — index of value, -1 if not found
arr.includes(3)             // true — check if value exists
arr.find(x => x > 3)        // 4 — first matching element
arr.findIndex(x => x > 3)   // 3 — index of first match

// transform (return new array, don't mutate)
arr.map(x => x * 2)              // [2, 4, 6, 8, 10]
arr.filter(x => x > 2)           // [3, 4, 5]
arr.reduce((acc, x) => acc + x, 0) // 15 — accumulate to single value
arr.slice(1, 3)                  // [2, 3] — copy portion

// iteration
arr.forEach(x => console.log(x))
for (const x of arr) { }

// check
arr.every(x => x > 0)     // true if all match predicate
arr.some(x => x > 4)      // true if any match predicate

// sort — mutates original
arr.sort((a, b) => a - b)  // ascending numbers
arr.sort((a, b) => b - a)  // descending numbers
arr.sort()                 // alphabetical (converts to string first — careful!)

// other
arr.reverse()              // reverses in place
arr.flat()                 // flatten one level
arr.flat(2)                // flatten two levels
arr.flat(Infinity)         // flatten all levels
arr.join(", ")             // "1, 2, 3, 4, 5"
[...arr1, ...arr2]         // spread to combine

// destructuring
const [first, second, ...rest] = arr
const [a, , b] = [1, 2, 3]  // skip second element
```

---

## objects

objects store key-value pairs. they are the most important data structure in JS.

```javascript
const user = {
    name: "abhishek",
    age: 20,
    isStudent: true,
    address: {
        city: "lucknow",
        state: "UP"
    },
    greet() {
        return `hello, i'm ${this.name}`
    }
}

// access
user.name              // "abhishek" — dot notation
user["name"]           // "abhishek" — bracket notation (useful for dynamic keys)
user.address.city      // "lucknow"
user.greet()           // "hello, i'm abhishek"

// add, update, delete
user.email = "a@b.com"   // add new property
user.age = 21            // update
delete user.age          // delete

// check
"name" in user           // true
user.hasOwnProperty("name")  // true

// iterate
Object.keys(user)          // ["name", "age", ...]
Object.values(user)        // ["abhishek", 20, ...]
Object.entries(user)       // [["name","abhishek"], ...]

for (const key in user) { console.log(key, user[key]) }
for (const [key, val] of Object.entries(user)) { }

// copy and merge
const copy = { ...user }                    // shallow copy
const merged = { ...user, ...extraData }    // merge
const updated = { ...user, age: 21 }        // update specific field

// destructuring
const { name, age } = user
const { name: userName, age: userAge } = user  // rename
const { name, ...rest } = user                 // rest operator

// shorthand property
const name = "abhi"
const age = 20
const obj = { name, age }  // same as { name: name, age: age }

// computed property names
const key = "name"
const obj = { [key]: "abhishek" }  // { name: "abhishek" }
```

---

## functions

functions are reusable blocks of code. in JS, functions are first-class — they can be stored in variables, passed as arguments, and returned from other functions.

```javascript
// function declaration — hoisted (can call before declaration)
function add(a, b) {
    return a + b
}

// function expression — not hoisted
const add = function(a, b) {
    return a + b
}

// arrow function — concise syntax, no own 'this'
const add = (a, b) => a + b          // implicit return
const add = (a, b) => {              // explicit return
    return a + b
}
const double = x => x * 2           // single param, no parens needed
const greet = () => "hello"          // no params

// default parameters
function greet(name = "stranger") {
    return `hello ${name}`
}

// rest parameters — collect extra args into array
function sum(...numbers) {
    return numbers.reduce((a, b) => a + b, 0)
}
sum(1, 2, 3, 4, 5)  // 15

// spread in function call
Math.max(...[1, 2, 3])  // 3

// higher order functions — functions that take/return functions
function applyTwice(fn, value) {
    return fn(fn(value))
}
applyTwice(x => x * 2, 3)  // 12

// closures — inner function remembers outer scope
function counter() {
    let count = 0
    return {
        increment: () => ++count,
        decrement: () => --count,
        value: () => count
    }
}
const c = counter()
c.increment()  // 1
c.increment()  // 2
c.value()      // 2
```

---

## control flow

```javascript
// if / else if / else
if (age > 18) {
    console.log("adult")
} else if (age > 13) {
    console.log("teen")
} else {
    console.log("child")
}

// ternary — for simple conditions
const label = age > 18 ? "adult" : "minor"

// optional chaining — safe navigation
const city = user?.address?.city      // undefined if any is null/undefined
const first = arr?.[0]                // safe array access
const result = obj?.method?.()        // safe method call

// nullish coalescing — default for null/undefined
const name = user.name ?? "anonymous"  // only if null or undefined

// logical OR — default for falsy values
const name = user.name || "anonymous"  // if empty string, 0, false, null, undefined

// logical AND — short circuit
const isAdmin = user.role === "admin"
isAdmin && showAdminPanel()            // only runs if isAdmin is true

// switch
switch (status) {
    case "active":
        console.log("active")
        break
    case "inactive":
        console.log("inactive")
        break
    default:
        console.log("unknown")
}
```

---

## loops

```javascript
// for loop
for (let i = 0; i < 5; i++) {
    console.log(i)
}

// for of — iterate values (use for arrays)
for (const item of arr) {
    console.log(item)
}

// for in — iterate keys (use for objects)
for (const key in obj) {
    console.log(key, obj[key])
}

// while
while (condition) {
    // runs while condition is true
}

// do while — runs at least once
do {
    // code
} while (condition)

// break and continue
for (const x of arr) {
    if (x === 3) break     // exit loop
    if (x === 2) continue  // skip to next iteration
    console.log(x)
}

// prefer array methods over loops when transforming data
const doubled = arr.map(x => x * 2)       // cleaner than for loop
const evens = arr.filter(x => x % 2 === 0)
```

---

## async / await

JavaScript is single-threaded but handles async operations (network requests, timers, file reading) without blocking using an **event loop**.

a **Promise** represents a value that will be available in the future.

```javascript
// promise states: pending → fulfilled or rejected

const promise = new Promise((resolve, reject) => {
    // do async work
    if (success) resolve(data)
    else reject(new Error("failed"))
})

// async/await — cleaner way to work with promises
async function fetchUser(id) {
    try {
        const response = await fetch(`/api/users/${id}`)
        // await pauses execution until promise resolves
        
        if (!response.ok) {
            throw new Error(`HTTP error: ${response.status}`)
        }
        
        const data = await response.json()
        return data
    } catch (error) {
        console.error("fetch failed:", error)
        throw error  // re-throw if caller should handle it
    }
}

// calling async function
const user = await fetchUser(1)  // inside another async function

// outside async: use .then()
fetchUser(1)
    .then(user => console.log(user))
    .catch(err => console.error(err))
    .finally(() => setLoading(false))

// run multiple requests in parallel
const [users, posts] = await Promise.all([
    fetch('/api/users').then(r => r.json()),
    fetch('/api/posts').then(r => r.json())
])

// first one to resolve
const fastest = await Promise.race([request1, request2])

// all settle (even if some fail)
const results = await Promise.allSettled([req1, req2, req3])
```

---

## error handling

```javascript
try {
    const data = JSON.parse(invalidJson)   // throws SyntaxError
    const result = riskyOperation()
} catch (error) {
    console.error(error.message)
    console.error(error.stack)
} finally {
    cleanup()   // always runs
}

// throw custom errors
throw new Error("something went wrong")
throw new TypeError("expected a string")
throw new RangeError("value out of range")

// custom error class
class AppError extends Error {
    constructor(message, statusCode) {
        super(message)
        this.name = "AppError"
        this.statusCode = statusCode
    }
}

throw new AppError("user not found", 404)
```

---

## classes

```javascript
class User {
    // private fields (not accessible outside class)
    #password

    constructor(name, email, password) {
        this.name = name
        this.email = email
        this.#password = password
    }

    // method
    greet() {
        return `hello, i'm ${this.name}`
    }

    // getter
    get displayName() {
        return this.name.toUpperCase()
    }

    // setter
    set displayName(value) {
        this.name = value.toLowerCase()
    }

    // static method (called on class, not instance)
    static create(name, email) {
        return new User(name, email)
    }
}

// inheritance
class Student extends User {
    constructor(name, email, password, college) {
        super(name, email, password)  // call parent constructor
        this.college = college
    }

    // override parent method
    greet() {
        return `${super.greet()}, studying at ${this.college}`
    }
}

const s = new Student("abhishek", "a@b.com", "pass", "IIT")
s.greet()           // uses overridden method
s instanceof User   // true
s instanceof Student // true
```

---

## DOM manipulation

the DOM is the browser's live tree of HTML elements. JavaScript manipulates it to change the page.

```javascript
// select elements
const el = document.getElementById("id")
const el = document.querySelector(".class")       // first match
const els = document.querySelectorAll(".class")   // all matches (NodeList)
const els = document.getElementsByClassName("class")

// modify content
el.textContent = "new text"                       // text only (safe)
el.innerHTML = "<strong>bold</strong>"            // HTML (careful with XSS)

// modify styles
el.style.color = "red"
el.style.display = "none"

// modify classes
el.classList.add("active")
el.classList.remove("active")
el.classList.toggle("active")
el.classList.contains("active")   // true/false
el.classList.replace("old", "new")

// modify attributes
el.setAttribute("href", "/about")
el.getAttribute("href")
el.removeAttribute("hidden")
el.dataset.userId = "123"         // data-user-id attribute

// create and add elements
const div = document.createElement("div")
div.textContent = "hello"
div.classList.add("card")
parent.appendChild(div)           // add as last child
parent.prepend(div)               // add as first child
parent.insertBefore(div, ref)     // insert before reference element
el.remove()                       // remove element

// events
el.addEventListener("click", (event) => {
    console.log(event.target)     // element that was clicked
    console.log(event.currentTarget) // element with listener
})

el.addEventListener("input", (e) => {
    console.log(e.target.value)   // input value
})

el.addEventListener("submit", (e) => {
    e.preventDefault()            // prevent form from submitting
    const data = new FormData(e.target)
    data.get("email")
})

// remove event listener
const handler = (e) => {}
el.addEventListener("click", handler)
el.removeEventListener("click", handler)

// event delegation — one listener for many elements
document.querySelector(".list").addEventListener("click", (e) => {
    if (e.target.matches(".item")) {
        // handle click on any .item
    }
})
```

---

## modules

modules let you split code into files.

```javascript
// math.js — named exports
export const PI = 3.14
export function add(a, b) { return a + b }
export class Calculator { }

// app.js — default export
export default function App() { }

// importing
import App from './app.js'                // default
import { PI, add } from './math.js'       // named
import { PI as pi, add } from './math.js' // with alias
import * as math from './math.js'         // everything
import App, { PI } from './app.js'        // both

// dynamic import (lazy loading)
const module = await import('./heavy-module.js')
```

---

## TypeScript

TypeScript adds static types to JavaScript. it catches errors at compile time instead of runtime.

```typescript
// type annotations
let name: string = "abhishek"
let age: number = 20
let isActive: boolean = true
let id: string | number = "abc"   // union type
let data: any = "anything"        // avoid — defeats purpose
let unknown: unknown = getData()  // safer than any

// arrays
let nums: number[] = [1, 2, 3]
let strs: Array<string> = ["a", "b"]

// type alias
type User = {
    id: number
    name: string
    email: string
    age?: number              // optional
    readonly createdAt: Date  // cannot be changed
}

// interface (similar to type, but extensible)
interface User {
    id: number
    name: string
    greet(): string
}

interface Admin extends User {
    role: "admin"
    permissions: string[]
}

// function types
function add(a: number, b: number): number {
    return a + b
}

const greet = (name: string): string => `hello ${name}`

const fetchUser = async (id: number): Promise<User> => {
    const res = await fetch(`/api/users/${id}`)
    return res.json()
}

// generics
function identity<T>(value: T): T {
    return value
}

async function fetchData<T>(url: string): Promise<T> {
    const res = await fetch(url)
    return res.json()
}

const user = await fetchData<User>('/api/user')

// utility types
Partial<User>           // all fields optional
Required<User>          // all fields required
Readonly<User>          // all fields read-only
Pick<User, "name" | "email">   // only those fields
Omit<User, "password">  // everything except
Record<string, number>  // { [key: string]: number }
ReturnType<typeof fn>   // type of function return value

// enum
enum Direction {
    Up = "UP",
    Down = "DOWN",
    Left = "LEFT",
    Right = "RIGHT"
}

// type narrowing
function process(value: string | number) {
    if (typeof value === "string") {
        value.toUpperCase()   // TypeScript knows it's string here
    } else {
        value.toFixed(2)      // TypeScript knows it's number here
    }
}
```

---

## fetch API

```javascript
// GET request
const getUser = async (id) => {
    const response = await fetch(`/api/users/${id}`)
    
    if (!response.ok) {
        throw new Error(`Error: ${response.status}`)
    }
    
    return response.json()
}

// POST request
const createUser = async (userData) => {
    const response = await fetch('/api/users', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify(userData)
    })
    
    return response.json()
}

// with error handling
const apiCall = async (url, options = {}) => {
    try {
        const response = await fetch(url, {
            headers: { 'Content-Type': 'application/json' },
            ...options
        })
        
        const data = await response.json()
        
        if (!response.ok) {
            throw new Error(data.message || 'Request failed')
        }
        
        return data
    } catch (error) {
        console.error('API error:', error)
        throw error
    }
}
```

---

## useful built-ins

```javascript
// JSON
JSON.stringify({ name: "abhi", age: 20 })     // to string
JSON.stringify(data, null, 2)                  // pretty print
JSON.parse('{"name":"abhi"}')                  // to object

// localStorage (browser only)
localStorage.setItem("user", JSON.stringify(user))
JSON.parse(localStorage.getItem("user"))
localStorage.removeItem("user")
localStorage.clear()

// timers
const id = setTimeout(() => {}, 1000)   // run once after 1 sec
clearTimeout(id)
const id = setInterval(() => {}, 1000)  // run every 1 sec
clearInterval(id)

// Date
const now = new Date()
now.toISOString()                            // "2026-03-06T..."
now.toLocaleDateString('en-IN')             // "6/3/2026"
now.toLocaleString('en-IN')                 // full date and time
Date.now()                                   // milliseconds since epoch

// URL
const url = new URL("https://example.com/path?name=abhi&age=20")
url.hostname        // "example.com"
url.pathname        // "/path"
url.searchParams.get("name")  // "abhi"
```

---

```
=^._.^= javascript runs the internet
```
