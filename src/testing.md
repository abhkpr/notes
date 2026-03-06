# Testing

> ship with confidence. break it before users do.

---

## why test

testing is not about proving code works. it is about finding out when it breaks — before your users do.

**without tests:**
- you change one thing, three other things break silently
- you are afraid to refactor because something might break
- you manually click through the app after every change
- bugs reach production

**with tests:**
- change anything, run tests, immediately see what broke
- refactor freely — tests catch regressions
- document how code is supposed to work
- ship features faster (less manual checking)

**the testing pyramid:**
```
        /\
       /E2E\          few — slow, test whole app
      /──────\
     /Integr. \       some — test components together
    /──────────\
   /    Unit    \     many — fast, test single functions
  /______________\
```

---

## types of tests

**unit tests** — test a single function or component in isolation. fast, lots of them.

**integration tests** — test multiple units working together. component + API call, for example.

**end-to-end (E2E) tests** — test the whole app like a real user. open browser, click buttons, check result. slow but most realistic.

---

## testing JavaScript with Jest

Jest is the most popular JavaScript testing framework.

```bash
# install
npm install -D jest @types/jest

# for React
npm install -D jest @testing-library/react @testing-library/jest-dom @testing-library/user-event
```

---

## unit testing functions

```javascript
// utils.js — the function we want to test
export function add(a, b) {
    return a + b
}

export function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
}

export function formatDate(date) {
    return new Date(date).toLocaleDateString('en-IN')
}

export function truncate(str, maxLength) {
    if (str.length <= maxLength) return str
    return str.slice(0, maxLength) + '...'
}
```

```javascript
// utils.test.js — test file
import { add, isValidEmail, formatDate, truncate } from './utils'

// describe — group related tests
describe('add', () => {
    // test — single test case
    test('adds two positive numbers', () => {
        expect(add(1, 2)).toBe(3)
    })

    test('adds negative numbers', () => {
        expect(add(-1, -2)).toBe(-3)
    })

    test('adds zero', () => {
        expect(add(5, 0)).toBe(5)
    })
})

describe('isValidEmail', () => {
    test('returns true for valid email', () => {
        expect(isValidEmail('abhishek@example.com')).toBe(true)
    })

    test('returns false for missing @', () => {
        expect(isValidEmail('abhishekexample.com')).toBe(false)
    })

    test('returns false for empty string', () => {
        expect(isValidEmail('')).toBe(false)
    })
})

describe('truncate', () => {
    test('returns string unchanged if under limit', () => {
        expect(truncate('hello', 10)).toBe('hello')
    })

    test('truncates and adds ellipsis if over limit', () => {
        expect(truncate('hello world', 5)).toBe('hello...')
    })

    test('returns exact length string unchanged', () => {
        expect(truncate('hello', 5)).toBe('hello')
    })
})
```

---

## Jest matchers

```javascript
// equality
expect(value).toBe(3)              // strict equality (===)
expect(value).toEqual({a: 1})      // deep equality (objects/arrays)
expect(value).not.toBe(3)          // negation

// truthiness
expect(value).toBeTruthy()
expect(value).toBeFalsy()
expect(value).toBeNull()
expect(value).toBeUndefined()
expect(value).toBeDefined()

// numbers
expect(value).toBeGreaterThan(3)
expect(value).toBeLessThan(10)
expect(value).toBeCloseTo(0.3)     // floating point comparison

// strings
expect(str).toMatch(/pattern/)
expect(str).toContain('substring')
expect(str).toHaveLength(5)

// arrays
expect(arr).toContain(3)
expect(arr).toHaveLength(3)
expect(arr).toEqual([1, 2, 3])

// objects
expect(obj).toHaveProperty('name')
expect(obj).toHaveProperty('name', 'Abhishek')
expect(obj).toMatchObject({ name: 'Abhishek' })  // partial match

// functions/errors
expect(() => riskyFn()).toThrow()
expect(() => riskyFn()).toThrow('error message')
expect(() => riskyFn()).toThrow(TypeError)

// async
await expect(promise).resolves.toBe('value')
await expect(promise).rejects.toThrow('error')
```

---

## testing async code

```javascript
// function that fetches data
async function fetchUser(id) {
    const res = await fetch(`/api/users/${id}`)
    if (!res.ok) throw new Error('User not found')
    return res.json()
}

// test with mock fetch
global.fetch = jest.fn()

describe('fetchUser', () => {
    beforeEach(() => {
        fetch.mockClear()  // reset mock between tests
    })

    test('returns user data on success', async () => {
        const mockUser = { id: 1, name: 'Abhishek' }

        fetch.mockResolvedValueOnce({
            ok: true,
            json: async () => mockUser
        })

        const user = await fetchUser(1)
        expect(user).toEqual(mockUser)
        expect(fetch).toHaveBeenCalledWith('/api/users/1')
    })

    test('throws error when user not found', async () => {
        fetch.mockResolvedValueOnce({ ok: false })

        await expect(fetchUser(999)).rejects.toThrow('User not found')
    })
})
```

---

## testing React components

```jsx
// Button.jsx
function Button({ label, onClick, disabled = false }) {
    return (
        <button onClick={onClick} disabled={disabled}>
            {label}
        </button>
    )
}

// GoalItem.jsx
function GoalItem({ goal, onToggle, onDelete }) {
    return (
        <div data-testid="goal-item">
            <input
                type="checkbox"
                checked={goal.completed}
                onChange={() => onToggle(goal.id)}
                aria-label={goal.title}
            />
            <span>{goal.title}</span>
            <button onClick={() => onDelete(goal.id)}>Delete</button>
        </div>
    )
}
```

```javascript
// Button.test.jsx
import { render, screen, fireEvent } from '@testing-library/react'
import userEvent from '@testing-library/user-event'
import Button from './Button'

describe('Button', () => {
    test('renders with label', () => {
        render(<Button label="Click me" onClick={() => {}} />)
        expect(screen.getByText('Click me')).toBeInTheDocument()
    })

    test('calls onClick when clicked', async () => {
        const user = userEvent.setup()
        const handleClick = jest.fn()

        render(<Button label="Click me" onClick={handleClick} />)
        await user.click(screen.getByText('Click me'))

        expect(handleClick).toHaveBeenCalledTimes(1)
    })

    test('does not call onClick when disabled', async () => {
        const user = userEvent.setup()
        const handleClick = jest.fn()

        render(<Button label="Click me" onClick={handleClick} disabled />)
        await user.click(screen.getByText('Click me'))

        expect(handleClick).not.toHaveBeenCalled()
    })
})

// GoalItem.test.jsx
describe('GoalItem', () => {
    const mockGoal = { id: '1', title: 'Study React', completed: false }

    test('renders goal title', () => {
        render(<GoalItem goal={mockGoal} onToggle={() => {}} onDelete={() => {}} />)
        expect(screen.getByText('Study React')).toBeInTheDocument()
    })

    test('shows unchecked checkbox for incomplete goal', () => {
        render(<GoalItem goal={mockGoal} onToggle={() => {}} onDelete={() => {}} />)
        expect(screen.getByRole('checkbox')).not.toBeChecked()
    })

    test('calls onToggle when checkbox clicked', async () => {
        const user = userEvent.setup()
        const onToggle = jest.fn()

        render(<GoalItem goal={mockGoal} onToggle={onToggle} onDelete={() => {}} />)
        await user.click(screen.getByRole('checkbox'))

        expect(onToggle).toHaveBeenCalledWith('1')
    })

    test('calls onDelete when delete button clicked', async () => {
        const user = userEvent.setup()
        const onDelete = jest.fn()

        render(<GoalItem goal={mockGoal} onToggle={() => {}} onDelete={onDelete} />)
        await user.click(screen.getByText('Delete'))

        expect(onDelete).toHaveBeenCalledWith('1')
    })
})
```

---

## testing Library queries

```javascript
// find elements
screen.getByText('Hello')           // by text content — throws if not found
screen.getByRole('button')          // by ARIA role
screen.getByRole('button', { name: 'Submit' })
screen.getByLabelText('Email')      // by label
screen.getByPlaceholderText('Search')
screen.getByTestId('goal-item')     // by data-testid
screen.getByAltText('Profile photo')

// find multiple
screen.getAllByText('Item')

// won't throw if not found
screen.queryByText('Hello')         // null if not found
screen.queryAllByText('Item')       // [] if not found

// async — wait for element to appear
await screen.findByText('Loaded!')  // waits up to 1 second
await screen.findByRole('button')

// queries by priority (use in this order):
// getByRole → getByLabelText → getByText → getByTestId
```

---

## mocking

mocking replaces real dependencies with fake ones so tests run fast and predictably.

```javascript
// mock a module
jest.mock('../lib/api', () => ({
    goalsApi: {
        list: jest.fn(),
        create: jest.fn(),
        update: jest.fn(),
        delete: jest.fn()
    }
}))

import { goalsApi } from '../lib/api'

test('loads and displays goals', async () => {
    goalsApi.list.mockResolvedValueOnce({
        data: [
            { id: '1', title: 'Study React', completed: false },
            { id: '2', title: 'Read docs', completed: true }
        ]
    })

    render(<GoalsList />)

    // wait for data to load
    await screen.findByText('Study React')

    expect(screen.getByText('Study React')).toBeInTheDocument()
    expect(screen.getByText('Read docs')).toBeInTheDocument()
})

// mock individual function
const mockFn = jest.fn()
mockFn.mockReturnValue(42)
mockFn.mockResolvedValue({ data: [] })     // async
mockFn.mockRejectedValue(new Error('fail')) // async error
mockFn.mockImplementation((x) => x * 2)

// spy on existing function
const spy = jest.spyOn(console, 'error')
spy.mockImplementation(() => {})  // silence console.error in tests
```

---

## testing Python with pytest

```bash
pip install pytest pytest-asyncio httpx
```

```python
# utils.py
def add(a, b):
    return a + b

def is_valid_email(email):
    import re
    return bool(re.match(r'^[^\s@]+@[^\s@]+\.[^\s@]+$', email))

def truncate(text, max_length):
    if len(text) <= max_length:
        return text
    return text[:max_length] + '...'
```

```python
# test_utils.py
import pytest
from utils import add, is_valid_email, truncate

# basic test
def test_add():
    assert add(1, 2) == 3
    assert add(-1, -2) == -3
    assert add(5, 0) == 5

# parametrize — run same test with different inputs
@pytest.mark.parametrize("email, expected", [
    ("abhishek@example.com", True),
    ("abhishekexample.com", False),
    ("", False),
    ("a@b.c", True),
])
def test_is_valid_email(email, expected):
    assert is_valid_email(email) == expected

# test exceptions
def test_divide_by_zero():
    with pytest.raises(ZeroDivisionError):
        result = 10 / 0

# fixtures — shared setup
@pytest.fixture
def sample_user():
    return { "id": 1, "name": "Abhishek", "email": "a@b.com" }

def test_user_name(sample_user):
    assert sample_user["name"] == "Abhishek"
```

---

## testing FastAPI endpoints

```python
# test_api.py
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_get_goals_unauthorized():
    response = client.get("/api/goals")
    assert response.status_code == 401

def test_create_goal():
    # login first
    login_res = client.post("/api/auth/login", json={
        "email": "test@test.com",
        "password": "password123"
    })
    token = login_res.json()["token"]

    # create goal
    response = client.post("/api/goals",
        json={"title": "Study Testing", "date": "2026-03-06"},
        headers={"Authorization": f"Bearer {token}"}
    )

    assert response.status_code == 201
    data = response.json()["data"]
    assert data["title"] == "Study Testing"
    assert data["completed"] == False

def test_create_goal_empty_title():
    response = client.post("/api/goals",
        json={"title": "", "date": "2026-03-06"},
        headers={"Authorization": f"Bearer test_token"}
    )
    assert response.status_code == 422  # validation error
```

---

## test setup and teardown

```javascript
// Jest lifecycle hooks
beforeAll(() => {
    // runs once before all tests in file
    // setup database connection
})

afterAll(() => {
    // runs once after all tests
    // close database connection
})

beforeEach(() => {
    // runs before each test
    // reset mocks
    jest.clearAllMocks()
})

afterEach(() => {
    // runs after each test
    // cleanup DOM
})
```

```python
# pytest fixtures with scope
@pytest.fixture(scope="session")
def db():
    # runs once for whole test session
    connection = create_test_db()
    yield connection
    connection.close()

@pytest.fixture(scope="function")  # default
def user(db):
    # runs for each test function
    user = db.create_user(name="Test", email="test@test.com")
    yield user
    db.delete_user(user.id)  # cleanup after test
```

---

## what to test and what not to

```
DO test:
  pure functions with complex logic
  components: renders correctly, handles user interaction
  API endpoints: correct status codes, response format
  error cases: what happens when things go wrong
  edge cases: empty arrays, null values, long strings

DON'T test:
  third-party libraries (they have their own tests)
  implementation details (test behavior, not how)
  trivial code (getters/setters, simple assignments)
  everything — 80% coverage is fine, 100% is wasteful
```

---

## running tests

```bash
# run all tests
npx jest

# watch mode (re-run on file change)
npx jest --watch

# run specific file
npx jest Button.test.jsx

# run tests matching pattern
npx jest --testNamePattern="login"

# coverage report
npx jest --coverage

# Python
pytest
pytest -v                    # verbose
pytest test_utils.py         # specific file
pytest -k "email"            # tests matching pattern
pytest --cov=.               # coverage
```

---

```
=^._.^= untested code is broken code you haven't found yet
```
