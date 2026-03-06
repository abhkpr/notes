# Computer Science Fundamentals

> how computers actually work, from bottom to top.

---

## the big picture

a computer is a machine that processes information. here is the full stack from hardware to your app:

```
your code (Python, JavaScript, C++)
        ↓
compiler / interpreter
        ↓
machine code (binary instructions)
        ↓
operating system
        ↓
CPU + RAM + Storage (hardware)
        ↓
transistors (billions of tiny switches)
        ↓
electricity
```

understanding each layer makes you a better programmer.

---

## number systems

computers only understand 0 and 1 (binary). everything else is built on top.

### binary (base 2)

```
decimal  binary
0     =  0000
1     =  0001
2     =  0010
3     =  0011
4     =  0100
5     =  0101
6     =  0110
7     =  0111
8     =  1000
9     =  1001
10    =  1010
```

**converting decimal to binary:**
```
13 in binary:
13 / 2 = 6 remainder 1
6  / 2 = 3 remainder 0
3  / 2 = 1 remainder 1
1  / 2 = 0 remainder 1
read remainders bottom to top: 1101

1×8 + 1×4 + 0×2 + 1×1 = 8+4+0+1 = 13 ✓
```

### hexadecimal (base 16)

```
0-9 then A=10, B=11, C=12, D=13, E=14, F=15

#FF0000 (red in CSS):
FF = 255 (red)
00 = 0   (green)
00 = 0   (blue)

memory address: 0x1A2F3B
```

### bits and bytes

```
1 bit      = 0 or 1
8 bits     = 1 byte
1024 bytes = 1 KB
1024 KB    = 1 MB
1024 MB    = 1 GB
1024 GB    = 1 TB
```

---

## how hardware works

### transistors

the fundamental building block of modern computers. a transistor is a tiny switch:
- off = 0
- on = 1

a modern CPU has billions of transistors. the more transistors, the more powerful.

### logic gates

transistors are combined to make logic gates:

```
AND gate:  both inputs must be 1 → output is 1
  A=0, B=0 → 0
  A=1, B=0 → 0
  A=0, B=1 → 0
  A=1, B=1 → 1

OR gate:   at least one input must be 1
  A=0, B=0 → 0
  A=1, B=0 → 1
  A=0, B=1 → 1
  A=1, B=1 → 1

NOT gate:  flips the input
  A=0 → 1
  A=1 → 0

NAND, NOR, XOR, XNOR built from these
```

logic gates → arithmetic circuits (adders) → ALU → CPU

### CPU (Central Processing Unit)

the brain of the computer. executes instructions.

**main components:**
- **ALU** (Arithmetic Logic Unit) — does math and logic
- **Control Unit** — fetches and decodes instructions
- **Registers** — tiny fast storage inside CPU (8-64 bytes)
- **Cache** — fast memory close to CPU (L1, L2, L3)
- **Clock** — synchronizes everything (3GHz = 3 billion cycles/sec)

**fetch-decode-execute cycle:**
```
1. FETCH: get next instruction from memory
2. DECODE: figure out what instruction means
3. EXECUTE: do it (add, store, jump, etc.)
4. repeat billions of times per second
```

### CPU registers

```
PC  (Program Counter)    → address of next instruction
SP  (Stack Pointer)      → top of current stack
IR  (Instruction Register) → current instruction
ACC (Accumulator)        → result of last operation
general purpose: R0-R15  → temporary values
```

### memory hierarchy

from fastest/smallest to slowest/biggest:

```
CPU Registers     ~1ns       bytes
L1 Cache          ~2ns       32-64 KB
L2 Cache          ~5ns       256 KB - 1 MB
L3 Cache          ~20ns      4-32 MB
RAM               ~100ns     4-64 GB
SSD               ~0.1ms     500 GB - 4 TB
HDD               ~10ms      1-20 TB
Network           ~100ms     unlimited
```

rule: data moves up hierarchy when needed, stays if frequently used (locality of reference)

### RAM (Random Access Memory)

- temporary storage while computer is running
- every byte has an address
- CPU reads/writes via memory bus
- data lost when power off (volatile)

```
address  value
0x0000   10100101
0x0001   11001010
0x0002   00110011
...
```

---

## how software works

### machine code

the only thing CPU actually understands — binary instructions

```
10110000 01100001   -- MOV AL, 97 (put 97 in register AL)
11101000 00000101   -- ADD AL, 5  (add 5 to AL)
```

nobody writes machine code directly.

### assembly language

human-readable machine code, one-to-one mapping

```asm
MOV AX, 5      ; put 5 in register AX
MOV BX, 3      ; put 3 in register BX
ADD AX, BX     ; AX = AX + BX = 8
```

### compiled languages (C, C++, Rust)

```
source code (.c)
      ↓ compiler (gcc, clang)
machine code (.exe, binary)
      ↓ run directly
CPU executes
```

very fast because code is already in machine language at runtime.

### interpreted languages (Python, JavaScript)

```
source code (.py)
      ↓ interpreter reads line by line
      ↓ translates to machine code on the fly
CPU executes
```

more flexible but slower (unless JIT compiled).

### JIT (Just-in-Time) compilation

JVM (Java), V8 (JavaScript/Node.js), PyPy (Python):
- starts as interpreter
- profiles which code runs most
- compiles hot paths to machine code
- gets close to compiled performance

---

## operating system

the OS manages hardware resources and provides services to programs.

### what an OS does

```
programs
    ↓ system calls
OS kernel
    ↓
hardware (CPU, RAM, disk, network)
```

- **process management** — run multiple programs, schedule CPU time
- **memory management** — give each program its own memory space
- **file system** — organize data on disk
- **device drivers** — talk to hardware
- **networking** — TCP/IP stack
- **security** — permissions, isolation

### process vs thread

**process:**
- independent program running in memory
- has its own memory space
- isolated from other processes
- more overhead to create
- if one crashes, others unaffected

**thread:**
- unit of execution inside a process
- shares memory with other threads in same process
- lighter weight than process
- if one thread crashes, whole process can crash

```
Process A                    Process B
┌─────────────────────┐      ┌──────────────┐
│  Thread 1           │      │  Thread 1    │
│  Thread 2           │      └──────────────┘
│  Shared memory      │
└─────────────────────┘
```

### CPU scheduling

OS decides which process runs when:

- **Round Robin** — each process gets a time slice (default)
- **Priority** — higher priority runs first
- **Shortest Job First** — shortest task runs first
- **Multi-level Queue** — different queues for different types

**context switch:** saving one process state, loading another. has overhead.

### virtual memory

each process thinks it has its own address space:

```
Process A sees:    Process B sees:
0x0000 - 0xFFFF   0x0000 - 0xFFFF
     ↓                  ↓
OS maps to different physical RAM addresses
```

**benefits:**
- isolation between processes
- can run more processes than RAM allows (swapping to disk)
- shared libraries loaded once, mapped to multiple processes

**page fault:** process accesses memory not in RAM → OS loads it from disk (slow)

### system calls

how programs talk to the OS:

```c
// in your Python/C code:
open("file.txt")

// becomes a system call to OS kernel:
sys_open(filename, flags, mode)

// kernel does the work, returns result
```

common syscalls: open, read, write, close, fork, exec, kill, socket, connect

---

## data structures

the building blocks of algorithms. choosing the right one is everything.

### array

```
[10, 20, 30, 40, 50]
  ↑   ↑   ↑   ↑   ↑
  0   1   2   3   4   (indices)

fixed size, elements stored contiguously in memory
```

```
access by index: O(1) ← constant time, any element
insert at end:   O(1)
insert at middle: O(n) ← shift all elements after
delete at middle: O(n)
search:           O(n) ← scan each element
```

### linked list

```
[10] → [20] → [30] → [40] → null
head                   tail
```

each node stores data + pointer to next node. not contiguous in memory.

```
access by index:  O(n) ← must traverse from head
insert at head:   O(1)
insert at tail:   O(1) if we track tail
insert at middle: O(n) to find it, then O(1) to insert
delete:           O(n) to find it
```

**doubly linked list** — each node has next AND previous pointer

### stack

```
push 10  push 20  push 30  pop
[]    →  [10] →  [10,20] → [10,20,30] → [10,20]
                             top=30
```

LIFO — Last In First Out

```
push: O(1)
pop:  O(1)
peek: O(1)
```

uses: function call stack, undo operations, parsing expressions, DFS

### queue

```
enqueue 10  enqueue 20  enqueue 30  dequeue
[]    →     [10]   →   [10,20]  →  [10,20,30]  →  [20,30]
front=back=10            front=10                   front=20
```

FIFO — First In First Out

```
enqueue: O(1)
dequeue: O(1)
```

uses: BFS, task queues, print queues, request handling

### hash table (dictionary/map)

```
key → hash function → index → value

"name" → hash("name") = 42 → arr[42] = "abhishek"
"age"  → hash("age")  = 17 → arr[17] = 20
```

```
insert: O(1) average
lookup: O(1) average
delete: O(1) average
worst case O(n) when many collisions
```

**collision handling:**
- **chaining** — linked list at each slot
- **open addressing** — probe next slot

uses: caches, databases, counting, grouping

### tree

```
          root
         /    \
      node    node
      /  \
   leaf  leaf
```

**binary tree** — each node has max 2 children

**binary search tree (BST):**
```
left child < parent < right child

       10
      /  \
     5    15
    / \     \
   3   7    20
```

```
search: O(log n) average, O(n) worst (unbalanced)
insert: O(log n) average
delete: O(log n) average
```

**balanced BST (AVL, Red-Black):**
auto-balances to ensure O(log n) always

**heap:**
```
max-heap: parent always ≥ children
       50
      /  \
    30    40
   /  \
  10  20
```

```
insert: O(log n)
get max/min: O(1)
extract max/min: O(log n)
```

uses: priority queues, scheduling, heap sort

### graph

```
vertices (nodes) connected by edges

undirected:    directed:
A - B          A → B
|   |          ↓   ↓
C - D          C → D
```

**representation:**

adjacency matrix:
```
  A B C D
A 0 1 1 0
B 1 0 0 1
C 1 0 0 1
D 0 1 1 0
```

adjacency list (more common):
```
A: [B, C]
B: [A, D]
C: [A, D]
D: [B, C]
```

uses: social networks, maps, dependencies, web links

---

## algorithms

### Big O notation

measures how runtime/space scales with input size n.

```
O(1)       constant  — doesn't depend on n (hash lookup)
O(log n)   logarithmic — halves problem each step (binary search)
O(n)       linear — proportional to n (linear search)
O(n log n) — sorting algorithms (merge sort, quick sort)
O(n²)      quadratic — nested loops (bubble sort)
O(2ⁿ)      exponential — recursive combinations
O(n!)      factorial — all permutations
```

```
n=10:   O(n²)=100      O(n log n)=33    O(n)=10
n=100:  O(n²)=10,000   O(n log n)=664   O(n)=100
n=1000: O(n²)=1M       O(n log n)=9966  O(n)=1000
```

### sorting algorithms

**bubble sort O(n²)** — compare adjacent, swap if wrong order. slow. don't use.

**selection sort O(n²)** — find min, put at front, repeat.

**insertion sort O(n²)** — good for nearly sorted data, simple.

**merge sort O(n log n)** — divide in half, sort each half, merge.
```
[5,2,8,1,9,3]
[5,2,8] [1,9,3]
[5,2] [8] [1,9] [3]
[5] [2] [8] [1] [9] [3]
[2,5] [8] [1,9] [3]
[2,5,8] [1,3,9]
[1,2,3,5,8,9]
```

**quick sort O(n log n) avg** — pick pivot, partition, recurse. fast in practice.

**heap sort O(n log n)** — build heap, extract max repeatedly.

**language built-in sorts** (timsort) are almost always good enough — use them.

### searching algorithms

**linear search O(n)** — check each element. works on any array.

**binary search O(log n)** — only on sorted array. halve search space each step.
```
find 7 in [1,3,5,7,9,11,13]
             ↑ mid = 7 → found!

find 5 in [1,3,5,7,9,11,13]
              ↑ mid = 7
             left half: [1,3,5]
                          ↑ mid = 3
                         right: [5]
                                 ↑ found!
```

### graph algorithms

**BFS (Breadth First Search)** — explore level by level using queue
```
find shortest path
explore neighbors before going deeper

uses: shortest path, web crawling, social connections
```

**DFS (Depth First Search)** — go deep using stack/recursion
```
explore one path completely before backtracking

uses: cycle detection, topological sort, maze solving
```

**Dijkstra's algorithm** — shortest path in weighted graph (no negative weights)

**dynamic programming** — solve by breaking into subproblems, cache results
```
fibonacci without DP: O(2ⁿ)
with DP (memoization): O(n)

fib(5) = fib(4) + fib(3)
fib(4) = fib(3) + fib(2)    ← fib(3) computed twice without DP
with cache: compute fib(3) once, reuse
```

---

## memory management

### stack vs heap (in programs)

**stack memory:**
```
fast, automatically managed
stores: local variables, function parameters, return addresses
limited size (~1-8 MB)
allocated/freed automatically when function enters/exits
```

**heap memory:**
```
slower, manually managed (or garbage collected)
stores: dynamically allocated objects
limited by available RAM
in C: malloc/free manually
in Python/Java/JavaScript: garbage collector frees automatically
```

**stack overflow:** too many nested function calls, stack runs out

```python
def infinite():
    return infinite()  # recursion with no base case

infinite()  # RecursionError: maximum recursion depth exceeded
```

### garbage collection

automatically frees memory that's no longer referenced.

**reference counting:**
```
each object counts how many references point to it
when count reaches 0 → free it

problem: circular references
A points to B, B points to A
both have count=1 even if nothing else references them
```

**mark and sweep:**
```
1. mark all reachable objects (starting from roots)
2. sweep — free everything not marked
solves circular reference problem
causes occasional pauses
```

**generational GC:**
```
most objects die young
young generation: collected frequently, fast
old generation: collected rarely, slow

Python, Java, JavaScript all use this
```

---

## compilation process

how C code becomes machine code:

```
source.c
   ↓ preprocessor (handle #include, #define)
preprocessed.c
   ↓ compiler (check syntax, generate assembly)
source.asm
   ↓ assembler (convert to machine code)
source.o (object file)
   ↓ linker (combine object files + libraries)
executable binary
```

**static linking:** libraries copied into executable (bigger file, no dependencies)
**dynamic linking:** libraries loaded at runtime (smaller file, needs .so/.dll)

---

## computer encoding

### ASCII

maps numbers 0-127 to characters:
```
65 = A, 66 = B, 67 = C...
97 = a, 98 = b, 99 = c...
48 = 0, 49 = 1, 50 = 2...
32 = space, 10 = newline, 0 = null
```

### Unicode

universal standard for all writing systems:
- over 140,000 characters
- every character has a code point: U+0041 = A, U+1F600 = 😀

**UTF-8:**
- variable length encoding (1-4 bytes per character)
- ASCII characters use 1 byte (backward compatible)
- most common encoding on the web
- Hindi: 3 bytes per character, emojis: 4 bytes

**UTF-16:** 2 or 4 bytes per character (used internally in Java, JavaScript)

---

## networking fundamentals (CS perspective)

### how data travels

```
you type: GET /users HTTP/1.1

1. browser creates HTTP request (text)
2. TLS encrypts it
3. TCP breaks into segments, adds port numbers
4. IP adds source/destination addresses
5. ethernet adds MAC addresses
6. converted to electrical/light signals
7. travels through cables, routers, switches
8. unwrapped in reverse at server
```

### TCP reliability mechanism

```
client sends: [segment 1] [segment 2] [segment 3]
server replies: [ACK 1] [ACK 2] [ACK 3]

if segment 2 lost:
server sends: [ACK 1] [NAK 2]
client resends: [segment 2]
```

**sliding window:** send multiple segments without waiting for each ACK — improves throughput

---

## concurrency and parallelism

**concurrency:** multiple tasks making progress (not necessarily at same time)
**parallelism:** multiple tasks literally running at the same time (multiple cores)

```
concurrency on 1 core:
task A ──── task B ──── task A ──── task B
(switching rapidly, appears simultaneous)

parallelism on 2 cores:
core 1: task A ────────────────
core 2: task B ────────────────
```

### problems with concurrency

**race condition:**
```
thread 1: x = x + 1   (x=0, reads 0, adds 1, writes 1)
thread 2: x = x + 1   (x=0, reads 0, adds 1, writes 1)
result: x=1 (expected x=2)
```

**deadlock:**
```
thread 1 holds lock A, waiting for lock B
thread 2 holds lock B, waiting for lock A
both wait forever
```

**solutions:**
- **mutex (lock)** — only one thread can hold it at a time
- **semaphore** — allows N threads at once
- **atomic operations** — operations that complete without interruption
- **immutable data** — data that never changes has no race conditions

---

## boolean logic and logic design

### boolean algebra

```
AND: A AND B = A × B
OR:  A OR B  = A + B
NOT: NOT A   = A'

De Morgan's laws:
NOT(A AND B) = NOT(A) OR NOT(B)
NOT(A OR B)  = NOT(A) AND NOT(B)
```

### half adder (1-bit addition)

```
inputs: A, B
outputs: SUM, CARRY

truth table:
A B | SUM CARRY
0 0 |  0    0
0 1 |  1    0
1 0 |  1    0
1 1 |  0    1     ← 1+1=10 in binary (sum=0, carry=1)

SUM   = A XOR B
CARRY = A AND B
```

chain multiple half adders → full adder → ripple carry adder → add any number

this is literally how your CPU does math.

---

## programming paradigms

### imperative / procedural

how to do something, step by step
```c
int sum = 0;
for (int i = 0; i < 10; i++) {
    sum = sum + i;
}
```

### object-oriented (OOP)

organize code around objects with state and behavior
```python
class BankAccount:
    def __init__(self, balance):
        self.balance = balance

    def deposit(self, amount):
        self.balance += amount
```

**four pillars:**
- **encapsulation** — hide internal state, expose interface
- **abstraction** — hide complexity, show only what's needed
- **inheritance** — child class gets parent's properties/methods
- **polymorphism** — same interface, different behavior

### functional

functions are first-class, avoid state and mutation
```javascript
const nums = [1,2,3,4,5]
const result = nums
    .filter(x => x % 2 === 0)
    .map(x => x * 2)
    .reduce((a, b) => a + b, 0)
```

**pure function** — same input always gives same output, no side effects

### declarative

describe WHAT you want, not HOW to do it
```sql
SELECT * FROM users WHERE age > 18;
```
```html
<button>Click me</button>
```

---

## key computer science concepts

### recursion

function that calls itself. needs a base case to stop.

```python
def factorial(n):
    if n == 0:           # base case
        return 1
    return n * factorial(n - 1)  # recursive case

factorial(5)
= 5 * factorial(4)
= 5 * 4 * factorial(3)
= 5 * 4 * 3 * factorial(2)
= 5 * 4 * 3 * 2 * factorial(1)
= 5 * 4 * 3 * 2 * 1 * factorial(0)
= 5 * 4 * 3 * 2 * 1 * 1
= 120
```

### divide and conquer

split problem in half, solve each half, combine
binary search, merge sort, quicksort all use this

### greedy algorithms

make locally optimal choice at each step, hope it leads to global optimum
works for: minimum spanning tree, Huffman encoding, scheduling
doesn't always work — sometimes need DP instead

### abstraction layers

hiding complexity behind simple interfaces:
```
you write: print("hello")
Python calls: sys.write()
OS calls: write() syscall
kernel calls: device driver
driver talks to: screen hardware
```

each layer hides the complexity below it. this is how all software is built.

---

```
=^._.^= understanding the fundamentals makes everything else easier
```
