# Python

> simple, powerful, everywhere.

---

## basics

```python
# variables
name = "abhishek"
age = 20
height = 5.9
is_student = True
nothing = None

# multiple assignment
x = y = z = 0
a, b, c = 1, 2, 3

# type checking
type(name)        # <class 'str'>
isinstance(age, int)  # True
```

---

## strings

```python
name = "abhishek"
greeting = f"hello {name}"     # f-string (preferred)
greeting = "hello " + name     # concatenation

# methods
name.upper()          # "ABHISHEK"
name.lower()          # "abhishek"
name.strip()          # remove whitespace
name.lstrip()         # left strip
name.rstrip()         # right strip
name.replace("abhi", "xyz")
name.split(" ")       # list of words
name.startswith("ab") # True
name.endswith("ek")   # True
name.find("sh")       # 4
name.count("a")       # 1
name.isdigit()        # False
name.isalpha()        # True
", ".join(["a","b","c"])  # "a, b, c"

# slicing
name[0]       # "a"
name[-1]      # "k"
name[0:4]     # "abhi"
name[::2]     # every 2nd char
name[::-1]    # reverse

# multiline
text = """
line one
line two
"""
```

---

## numbers

```python
x = 10
y = 3

x + y    # 13
x - y    # 7
x * y    # 30
x / y    # 3.333...
x // y   # 3 (floor division)
x % y    # 1 (modulo)
x ** y   # 1000 (power)

# built-ins
abs(-5)       # 5
round(3.14)   # 3
round(3.14, 1)# 3.1
min(1,2,3)    # 1
max(1,2,3)    # 3
sum([1,2,3])  # 6

import math
math.floor(3.7)  # 3
math.ceil(3.2)   # 4
math.sqrt(16)    # 4.0
math.pi          # 3.14159...
```

---

## lists

```python
arr = [1, 2, 3, 4, 5]

# access
arr[0]       # 1
arr[-1]      # 5
arr[1:3]     # [2, 3]

# modify
arr.append(6)        # add to end
arr.insert(0, 0)     # insert at index
arr.extend([7, 8])   # add multiple
arr.remove(3)        # remove by value
arr.pop()            # remove last
arr.pop(2)           # remove at index
del arr[0]           # delete at index

# search
3 in arr             # True
arr.index(3)         # find index
arr.count(3)         # count occurrences

# sort
arr.sort()                    # ascending (in place)
arr.sort(reverse=True)        # descending
sorted(arr)                   # returns new sorted list
arr.reverse()                 # reverse in place

# other
len(arr)             # length
arr.copy()           # shallow copy
arr.clear()          # empty list

# list comprehension
squares = [x**2 for x in range(10)]
evens = [x for x in arr if x % 2 == 0]
matrix = [[i*j for j in range(3)] for i in range(3)]
```

---

## tuples

```python
# immutable list
point = (10, 20)
x, y = point          # unpack

# single element tuple
single = (1,)

# named tuple
from collections import namedtuple
Point = namedtuple('Point', ['x', 'y'])
p = Point(10, 20)
p.x  # 10
```

---

## dictionaries

```python
user = {
    "name": "abhishek",
    "age": 20
}

# access
user["name"]          # "abhishek"
user.get("name")      # "abhishek"
user.get("email", "") # "" if not found

# modify
user["email"] = "a@b.com"
user.update({"age": 21, "city": "lucknow"})
del user["age"]
user.pop("age", None)  # safe delete

# check
"name" in user         # True
"email" not in user    # True

# iterate
for key in user:
    print(key)

for key, value in user.items():
    print(key, value)

user.keys()
user.values()
user.items()

# dict comprehension
squared = {x: x**2 for x in range(5)}

# merge (Python 3.9+)
merged = {**dict1, **dict2}
merged = dict1 | dict2
```

---

## sets

```python
s = {1, 2, 3}
s = set([1, 2, 2, 3])  # {1, 2, 3} - no duplicates

s.add(4)
s.remove(1)
s.discard(1)   # no error if not found

# set operations
a | b    # union
a & b    # intersection
a - b    # difference
a ^ b    # symmetric difference

1 in s   # True
```

---

## control flow

```python
# if/elif/else
if age > 18:
    print("adult")
elif age > 13:
    print("teen")
else:
    print("child")

# one liner
label = "adult" if age > 18 else "minor"

# match (Python 3.10+, like switch)
match status:
    case "active":
        print("active")
    case "inactive":
        print("inactive")
    case _:
        print("unknown")
```

---

## loops

```python
# for
for i in range(5):          # 0, 1, 2, 3, 4
    print(i)

for i in range(1, 6):       # 1, 2, 3, 4, 5
    print(i)

for i in range(0, 10, 2):   # 0, 2, 4, 6, 8
    print(i)

for item in arr:
    print(item)

for i, item in enumerate(arr):
    print(i, item)

for a, b in zip(arr1, arr2):
    print(a, b)

# while
while condition:
    pass

# loop control
break       # exit loop
continue    # skip to next iteration
pass        # do nothing

# for/else
for x in arr:
    if x == target:
        break
else:
    print("not found")  # runs if no break
```

---

## functions

```python
# basic
def greet(name):
    return f"hello {name}"

# default params
def greet(name="stranger"):
    return f"hello {name}"

# *args (variable positional)
def add(*numbers):
    return sum(numbers)

add(1, 2, 3)  # 6

# **kwargs (variable keyword)
def create_user(**data):
    return data

create_user(name="abhi", age=20)

# type hints
def add(a: int, b: int) -> int:
    return a + b

# lambda
double = lambda x: x * 2
add = lambda a, b: a + b

# first class functions
def apply(func, value):
    return func(value)

apply(double, 5)  # 10
```

---

## classes

```python
class User:
    # class variable
    count = 0

    def __init__(self, name, email):
        self.name = name
        self.email = email
        User.count += 1

    def greet(self):
        return f"hello, i'm {self.name}"

    def __str__(self):
        return f"User({self.name})"

    def __repr__(self):
        return f"User(name={self.name!r})"

    @classmethod
    def from_dict(cls, data):
        return cls(data["name"], data["email"])

    @staticmethod
    def validate_email(email):
        return "@" in email

    @property
    def display_name(self):
        return self.name.title()


# inheritance
class Student(User):
    def __init__(self, name, email, college):
        super().__init__(name, email)
        self.college = college

    def study(self):
        return f"{self.name} is studying"


# usage
u = User("abhishek", "a@b.com")
u.greet()
str(u)
User.count
User.validate_email("a@b.com")
u.display_name
```

---

## error handling

```python
try:
    result = 10 / 0
except ZeroDivisionError:
    print("can't divide by zero")
except (TypeError, ValueError) as e:
    print(f"error: {e}")
except Exception as e:
    print(f"unexpected error: {e}")
else:
    print("no error")   # runs if no exception
finally:
    print("always runs")

# raise
raise ValueError("invalid input")
raise

# custom exception
class AppError(Exception):
    def __init__(self, message, code=None):
        super().__init__(message)
        self.code = code
```

---

## file handling

```python
# read
with open("file.txt", "r") as f:
    content = f.read()
    lines = f.readlines()

# write
with open("file.txt", "w") as f:
    f.write("hello\n")

# append
with open("file.txt", "a") as f:
    f.write("new line\n")

# json
import json

# read json
with open("data.json") as f:
    data = json.load(f)

# write json
with open("data.json", "w") as f:
    json.dump(data, f, indent=2)

# string to/from json
json_str = json.dumps(data)
data = json.loads(json_str)
```

---

## modules and packages

```python
# import
import os
import sys
from pathlib import Path
from datetime import datetime, date

# useful standard library
import os
os.path.exists("file.txt")
os.path.join("folder", "file.txt")
os.getcwd()
os.listdir(".")
os.makedirs("folder", exist_ok=True)

import sys
sys.argv         # command line args
sys.exit(0)

from pathlib import Path
p = Path("folder/file.txt")
p.exists()
p.read_text()
p.write_text("content")
p.parent
p.stem          # filename without extension
p.suffix        # extension

from datetime import datetime
now = datetime.now()
now.strftime("%Y-%m-%d")
datetime.strptime("2026-03-05", "%Y-%m-%d")
```

---

## useful built-ins

```python
# map, filter, zip
list(map(lambda x: x*2, [1,2,3]))   # [2,4,6]
list(filter(lambda x: x>2, [1,2,3])) # [3]
list(zip([1,2], ["a","b"]))          # [(1,"a"),(2,"b")]

# all, any
all([True, True, False])  # False
any([False, False, True]) # True

# sorted with key
users = [{"name": "b"}, {"name": "a"}]
sorted(users, key=lambda u: u["name"])

# enumerate
for i, item in enumerate(arr, start=1):
    print(i, item)

# reversed
for item in reversed(arr):
    print(item)

# range
list(range(5))          # [0,1,2,3,4]
list(range(1,6))        # [1,2,3,4,5]
list(range(0,10,2))     # [0,2,4,6,8]
```

---

## virtual environment

```bash
# create
python3 -m venv venv

# activate
source venv/bin/activate      # linux/mac
venv\Scripts\activate         # windows

# install packages
pip install requests fastapi

# save dependencies
pip freeze > requirements.txt

# install from file
pip install -r requirements.txt

# deactivate
deactivate
```

---

## useful packages

```python
# requests - HTTP
import requests
res = requests.get("https://api.example.com/data")
res.status_code   # 200
res.json()
res.text

res = requests.post("https://api.example.com/users",
    json={"name": "abhishek"},
    headers={"Authorization": "Bearer token"}
)

# dotenv - environment variables
from dotenv import load_dotenv
import os
load_dotenv()
os.getenv("API_KEY")

# pydantic - data validation
from pydantic import BaseModel

class User(BaseModel):
    name: str
    age: int
    email: str | None = None

user = User(name="abhishek", age=20)
user.model_dump()
```

---

## FastAPI basics

```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

class User(BaseModel):
    name: str
    email: str

@app.get("/")
def root():
    return {"message": "hello world"}

@app.get("/users/{user_id}")
def get_user(user_id: int):
    return {"id": user_id}

@app.post("/users")
def create_user(user: User):
    return user

@app.get("/items")
def get_items(skip: int = 0, limit: int = 10):
    return {"skip": skip, "limit": limit}

# run: uvicorn main:app --reload
```

---

## numpy basics (for ML)

```python
import numpy as np

arr = np.array([1, 2, 3])
matrix = np.array([[1,2],[3,4]])

# operations
arr + 2          # [3,4,5]
arr * 2          # [2,4,6]
arr.mean()       # 2.0
arr.sum()        # 6
arr.max()        # 3
arr.reshape(3,1) # column vector

# create arrays
np.zeros((3,3))
np.ones((3,3))
np.eye(3)        # identity matrix
np.arange(0, 10, 2)
np.linspace(0, 1, 100)
np.random.rand(3, 3)
```

---

## pandas basics (for ML)

```python
import pandas as pd

# create dataframe
df = pd.DataFrame({
    "name": ["a", "b", "c"],
    "age": [20, 21, 22]
})

# read data
df = pd.read_csv("data.csv")
df = pd.read_json("data.json")

# explore
df.head()
df.tail()
df.shape       # (rows, cols)
df.info()
df.describe()

# access
df["name"]           # column
df[["name","age"]]   # multiple columns
df.iloc[0]           # row by index
df.loc[0]            # row by label
df[df["age"] > 20]   # filter

# modify
df["salary"] = 50000
df.rename(columns={"name": "full_name"})
df.drop("age", axis=1)
df.fillna(0)
df.dropna()

# aggregate
df.groupby("city")["age"].mean()
df.sort_values("age", ascending=False)
```

---

```
=^._.^= python is the swiss army knife
```
