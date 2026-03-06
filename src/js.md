# JavaScript & TypeScript

> make it interactive. make it work.

---

## variables

```javascript
var x = 1;      // old, avoid
let x = 1;      // block scoped, can reassign
const x = 1;    // block scoped, cannot reassign

// always use const by default
// use let only when you need to reassign
```

---

## data types

```javascript
// primitives
let name = "abhishek"       // string
let age = 20                // number
let isStudent = true        // boolean
let nothing = null          // null
let notDefined = undefined  // undefined
let id = Symbol('id')       // symbol

// reference types
let arr = [1, 2, 3]         // array
let obj = { name: "abhi" }  // object
let fn = () => {}           // function

// check type
typeof "hello"   // "string"
typeof 42        // "number"
typeof true      // "boolean"
typeof null      // "object" (bug in JS)
typeof undefined // "undefined"
typeof []        // "object"
typeof {}        // "object"
Array.isArray([]) // true
```

---

## strings

```javascript
let name = "abhishek"
let greeting = `hello ${name}`   // template literal

// methods
name.length           // 8
name.toUpperCase()    // "ABHISHEK"
name.toLowerCase()    // "abhishek"
name.trim()           // remove whitespace
name.includes("abhi") // true
name.startsWith("ab") // true
name.endsWith("ek")   // true
name.replace("abhi", "xyz")  // "xyzshek"
name.replaceAll("a", "x")
name.split("")        // ["a","b","h","i","s","h","e","k"]
name.slice(0, 4)      // "abhi"
name.indexOf("sh")    // 4
name.padStart(10, "0") // "00abhishek"
name.repeat(2)         // "abhishekabhishek"

// string to number
Number("42")    // 42
parseInt("42px") // 42
parseFloat("3.14") // 3.14

// number to string
(42).toString() // "42"
String(42)      // "42"
```

---

## arrays

```javascript
let arr = [1, 2, 3, 4, 5]

// add/remove
arr.push(6)          // add to end
arr.pop()            // remove from end
arr.unshift(0)       // add to start
arr.shift()          // remove from start
arr.splice(2, 1)     // remove 1 element at index 2
arr.splice(2, 0, 99) // insert 99 at index 2

// access
arr[0]               // first element
arr[arr.length - 1]  // last element
arr.at(-1)           // last element (modern)

// find
arr.indexOf(3)       // 2
arr.includes(3)      // true
arr.find(x => x > 3) // 4 (first match)
arr.findIndex(x => x > 3) // 3

// transform
arr.map(x => x * 2)        // [2,4,6,8,10]
arr.filter(x => x > 2)     // [3,4,5]
arr.reduce((acc, x) => acc + x, 0) // 15
arr.forEach(x => console.log(x))

// sort
arr.sort((a, b) => a - b)  // ascending
arr.sort((a, b) => b - a)  // descending
arr.sort()                 // alphabetical

// other
arr.slice(1, 3)    // [2,3] (no mutation)
arr.reverse()      // reverses in place
arr.flat()         // flatten nested arrays
arr.join(", ")     // "1, 2, 3, 4, 5"
arr.every(x => x > 0) // true if all match
arr.some(x => x > 4)  // true if any match

// spread
let arr2 = [...arr, 6, 7]
let combined = [...arr, ...arr2]

// destructuring
let [first, second, ...rest] = arr
let [a, , b] = [1, 2, 3] // skip elements
```

---

## objects

```javascript
let user = {
    name: "abhishek",
    age: 20,
    address: {
        city: "lucknow"
    }
}

// access
user.name           // "abhishek"
user["name"]        // "abhishek"
user.address.city   // "lucknow"

// add/update/delete
user.email = "a@b.com"
user.age = 21
delete user.age

// check key exists
"name" in user      // true
user.hasOwnProperty("name") // true

// methods
Object.keys(user)   // ["name", "age", ...]
Object.values(user) // ["abhishek", 20, ...]
Object.entries(user)// [["name","abhishek"], ...]
Object.assign({}, user, { age: 21 }) // merge

// spread
let updated = { ...user, age: 21 }
let merged = { ...obj1, ...obj2 }

// destructuring
let { name, age } = user
let { name: userName } = user  // rename
let { name, ...rest } = user   // rest

// shorthand
let name = "abhishek"
let obj = { name }  // same as { name: name }
```

---

## functions

```javascript
// declaration
function add(a, b) {
    return a + b
}

// expression
const add = function(a, b) {
    return a + b
}

// arrow function
const add = (a, b) => a + b
const add = (a, b) => {
    return a + b
}
const double = x => x * 2      // single param, no parens

// default params
function greet(name = "stranger") {
    return `hello ${name}`
}

// rest params
function sum(...numbers) {
    return numbers.reduce((a, b) => a + b, 0)
}

// spread in call
Math.max(...[1, 2, 3])
```

---

## control flow

```javascript
// if/else
if (age > 18) {
    console.log("adult")
} else if (age > 13) {
    console.log("teen")
} else {
    console.log("child")
}

// ternary
const label = age > 18 ? "adult" : "minor"

// optional chaining
user?.address?.city   // undefined instead of error

// nullish coalescing
const name = user.name ?? "anonymous"  // if null/undefined

// logical or (falsy check)
const name = user.name || "anonymous"  // if falsy

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
// for
for (let i = 0; i < 5; i++) {}

// for of (arrays)
for (const item of arr) {}

// for in (objects)
for (const key in obj) {}

// while
while (condition) {}

// do while
do {} while (condition)

// array methods (prefer these)
arr.forEach(item => {})
arr.map(item => item * 2)
arr.filter(item => item > 0)
```

---

## async / await

```javascript
// async function always returns a promise
async function fetchUser(id) {
    try {
        const response = await fetch(`/api/users/${id}`)
        const data = await response.json()
        return data
    } catch (error) {
        console.error(error)
    }
}

// call it
const user = await fetchUser(1)

// parallel requests
const [users, posts] = await Promise.all([
    fetch('/api/users').then(r => r.json()),
    fetch('/api/posts').then(r => r.json())
])

// promise chain (old way)
fetch('/api/users')
    .then(res => res.json())
    .then(data => console.log(data))
    .catch(err => console.error(err))
    .finally(() => setLoading(false))
```

---

## error handling

```javascript
try {
    const data = JSON.parse(invalidJson)
} catch (error) {
    console.error(error.message)
} finally {
    // always runs
}

// custom error
throw new Error("something went wrong")
throw new TypeError("expected a string")
```

---

## classes

```javascript
class User {
    constructor(name, email) {
        this.name = name
        this.email = email
    }

    greet() {
        return `hello, i'm ${this.name}`
    }

    static create(name, email) {
        return new User(name, email)
    }
}

// extend
class Student extends User {
    constructor(name, email, college) {
        super(name, email)
        this.college = college
    }

    study() {
        return `${this.name} is studying`
    }
}

const s = new Student("abhishek", "a@b.com", "IIT")
s.greet()   // from parent
s.study()   // from child
```

---

## modules

```javascript
// export
export const PI = 3.14
export function add(a, b) { return a + b }
export default function App() {}  // default export

// import
import App from './App'           // default
import { PI, add } from './math'  // named
import * as math from './math'    // all
import App, { PI } from './App'   // both
```

---

## useful built-ins

```javascript
// JSON
JSON.stringify({ name: "abhi" })  // to string
JSON.parse('{"name":"abhi"}')     // to object

// localStorage
localStorage.setItem("key", JSON.stringify(data))
JSON.parse(localStorage.getItem("key"))
localStorage.removeItem("key")
localStorage.clear()

// setTimeout / setInterval
const id = setTimeout(() => {}, 1000)
clearTimeout(id)
const id = setInterval(() => {}, 1000)
clearInterval(id)

// Math
Math.max(1, 2, 3)    // 3
Math.min(1, 2, 3)    // 1
Math.floor(3.7)      // 3
Math.ceil(3.2)       // 4
Math.round(3.5)      // 4
Math.abs(-5)         // 5
Math.random()        // 0 to 1
Math.random() * 100  // 0 to 100

// Date
const now = new Date()
now.toISOString()           // "2026-03-05T..."
now.toLocaleDateString()    // "3/5/2026"
now.getFullYear()           // 2026
now.getMonth()              // 0-11
now.getDate()               // day of month
```

---

## DOM manipulation

```javascript
// select elements
document.getElementById("id")
document.querySelector(".class")      // first match
document.querySelectorAll(".class")   // all matches

// modify
el.textContent = "new text"
el.innerHTML = "<strong>bold</strong>"
el.style.color = "red"
el.classList.add("active")
el.classList.remove("active")
el.classList.toggle("active")
el.classList.contains("active")
el.setAttribute("href", "/about")
el.getAttribute("href")

// create/remove
const div = document.createElement("div")
div.textContent = "hello"
parent.appendChild(div)
parent.removeChild(child)
el.remove()

// events
el.addEventListener("click", (e) => {})
el.addEventListener("input", (e) => {})
el.addEventListener("submit", (e) => {
    e.preventDefault()
})
el.removeEventListener("click", handler)

// event delegation
document.addEventListener("click", (e) => {
    if (e.target.matches(".btn")) {
        // handle button click
    }
})
```

---

## TypeScript basics

```typescript
// types
let name: string = "abhishek"
let age: number = 20
let isActive: boolean = true
let nothing: null = null
let data: any = "anything"      // avoid
let id: string | number = "123" // union

// arrays
let arr: number[] = [1, 2, 3]
let arr: Array<number> = [1, 2, 3]

// object type
type User = {
    name: string
    age: number
    email?: string  // optional
}

// interface
interface User {
    name: string
    age: number
    greet(): string
}

// function types
function add(a: number, b: number): number {
    return a + b
}

const greet = (name: string): string => `hello ${name}`

// generics
function identity<T>(value: T): T {
    return value
}

const arr = identity<number[]>([1, 2, 3])

// enum
enum Status {
    Active = "active",
    Inactive = "inactive"
}

// type assertion
const input = document.getElementById("email") as HTMLInputElement
input.value

// utility types
Partial<User>       // all fields optional
Required<User>      // all fields required
Readonly<User>      // all fields readonly
Pick<User, "name">  // only name field
Omit<User, "age">   // everything except age
Record<string, number> // object with string keys, number values
```

---

## fetch API patterns

```javascript
// GET
const getData = async () => {
    const res = await fetch('/api/data')
    if (!res.ok) throw new Error(`HTTP error ${res.status}`)
    return res.json()
}

// POST
const postData = async (data) => {
    const res = await fetch('/api/data', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    })
    return res.json()
}

// with auth token
const authFetch = async (url) => {
    const res = await fetch(url, {
        headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
        }
    })
    return res.json()
}
```

---

```
=^._.^= javascript runs the internet
```
