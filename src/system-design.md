# System Design

> how to build systems that scale to millions of users.

---

## what is system design

system design is the process of defining the architecture, components, and data flow of a system to satisfy given requirements. it's about making the right tradeoffs between performance, scalability, reliability, and cost.

**two types:**
- **high level design (HLD)** → architecture, components, how they connect
- **low level design (LLD)** → classes, databases, APIs, data structures

---

## key concepts before anything else

### latency vs throughput
- **latency** → time to complete one operation (ms)
- **throughput** → operations per unit time (req/sec)
- goal: low latency AND high throughput

### availability vs consistency
- **availability** → system is always responding
- **consistency** → all users see the same data at the same time
- you often can't have both perfectly — this is the CAP theorem

### scalability
- **vertical scaling (scale up)** → bigger machine, more RAM/CPU
- **horizontal scaling (scale out)** → more machines

---

## CAP theorem

a distributed system can only guarantee 2 of these 3:

```
         Consistency
              /\
             /  \
            /    \
           /      \
          /________\
    Availability  Partition
                  Tolerance
```

- **CA** → consistent + available (single node, no partitions)
- **CP** → consistent + partition tolerant (MongoDB, HBase)
- **AP** → available + partition tolerant (Cassandra, DynamoDB)

in real distributed systems, network partitions WILL happen, so you choose between CP or AP.

---

## ACID vs BASE

**ACID (relational databases)**
- **Atomicity** → transaction is all or nothing
- **Consistency** → data is always valid
- **Isolation** → transactions don't interfere
- **Durability** → committed data survives crashes

**BASE (NoSQL databases)**
- **Basically Available** → always responds
- **Soft state** → data may change over time
- **Eventually consistent** → all nodes will agree eventually

---

## DNS (Domain Name System)

how a URL becomes an IP address:

```
user types google.com
       ↓
browser checks local cache
       ↓
OS checks /etc/hosts
       ↓
recursive DNS resolver (your ISP)
       ↓
root nameserver → .com nameserver → google's nameserver
       ↓
returns IP: 142.250.80.46
       ↓
browser connects to IP
```

**DNS record types:**
- `A` → domain to IPv4
- `AAAA` → domain to IPv6
- `CNAME` → alias to another domain
- `MX` → mail server
- `TXT` → text (used for verification, SPF)
- `NS` → nameserver for domain

---

## load balancing

distributes traffic across multiple servers so no single server gets overwhelmed.

```
                    ┌─────────┐
                    │  Load   │
users ─────────────▶│Balancer │
                    └────┬────┘
              ┌──────────┼──────────┐
              ▼          ▼          ▼
         ┌─────────┐┌─────────┐┌─────────┐
         │Server 1 ││Server 2 ││Server 3 │
         └─────────┘└─────────┘└─────────┘
```

**algorithms:**
- **round robin** → requests go to each server in order
- **least connections** → send to server with fewest connections
- **IP hash** → same user always goes to same server
- **weighted round robin** → servers get different proportions
- **random** → random server each time

**types:**
- **L4 (transport layer)** → routes based on IP/TCP, fast
- **L7 (application layer)** → routes based on HTTP content, smarter

**tools:** Nginx, HAProxy, AWS ALB, Cloudflare

---

## caching

storing data in fast storage (memory) to avoid slow operations (database, network).

```
request comes in
      ↓
check cache → HIT → return cached data (fast)
      ↓ MISS
fetch from database
      ↓
store in cache
      ↓
return data
```

**cache strategies:**

**cache aside (lazy loading)**
```
app checks cache
if miss → app fetches DB → app writes to cache
```
good for read-heavy workloads

**write through**
```
app writes to cache → cache writes to DB
```
data is always consistent, but write latency is higher

**write back (write behind)**
```
app writes to cache → cache writes to DB asynchronously
```
fast writes, risk of data loss if cache fails

**read through**
```
app reads from cache → if miss, cache fetches DB automatically
```

**cache eviction policies:**
- **LRU** (Least Recently Used) → remove least recently accessed
- **LFU** (Least Frequently Used) → remove least accessed overall
- **TTL** → expire after time period
- **FIFO** → remove oldest entry

**where to cache:**
- browser cache
- CDN
- reverse proxy (Nginx)
- application cache (in memory)
- distributed cache (Redis, Memcached)

**Redis vs Memcached:**
- Redis → persistent, data structures, pub/sub, more features
- Memcached → simpler, pure caching, multi-threaded

---

## CDN (Content Delivery Network)

network of servers around the world that serve static content from the nearest location to the user.

```
user in India
      ↓
CDN edge server in Mumbai (200ms away)
instead of
origin server in USA (300ms away)
```

**what to put on CDN:**
- images, videos, audio
- CSS, JavaScript files
- HTML pages (static sites)
- fonts

**CDN providers:** Cloudflare, AWS CloudFront, Fastly, Akamai

**push vs pull CDN:**
- **push** → you upload files to CDN manually
- **pull** → CDN fetches from origin on first request, caches it

---

## databases

### relational (SQL)
structured data, ACID, joins, schema required

```sql
-- good for: financial data, user accounts, inventory
-- PostgreSQL, MySQL, SQLite

-- normalized tables
users (id, name, email)
posts (id, user_id, title, content)
```

### NoSQL types

**document (MongoDB)**
```json
{
  "_id": "123",
  "name": "abhishek",
  "posts": [
    {"title": "first post", "likes": 100}
  ]
}
```
good for: flexible schema, nested data, content management

**key-value (Redis, DynamoDB)**
```
"user:123" → { name: "abhishek" }
"session:abc" → { userId: 123, expires: ... }
```
good for: caching, sessions, leaderboards, real-time features

**column-family (Cassandra, HBase)**
```
row_key → column_family → column → value
```
good for: time-series data, analytics, write-heavy workloads

**graph (Neo4j)**
```
(Abhishek) -[FOLLOWS]-> (Rahul)
(Abhishek) -[LIKES]-> (Post)
```
good for: social networks, recommendation engines, fraud detection

### when to use what
| use case | database |
|---|---|
| user accounts, orders | PostgreSQL |
| caching, sessions | Redis |
| product catalog | MongoDB |
| social graph | Neo4j |
| analytics, logs | Cassandra |
| search | Elasticsearch |

---

## database scaling

### replication
copies of database on multiple machines

```
           ┌──────────┐
writes ───▶│  Master  │
           └────┬─────┘
                │ replicates
       ┌────────┼────────┐
       ▼        ▼        ▼
  ┌────────┐┌────────┐┌────────┐
  │Replica ││Replica ││Replica │
  └────────┘└────────┘└────────┘
       reads go to replicas
```

- **master-slave** → one write node, multiple read nodes
- **multi-master** → multiple write nodes (complex, conflict resolution needed)

### sharding (partitioning)
split data across multiple databases

```
users with id 1-1000    → shard 1
users with id 1001-2000 → shard 2
users with id 2001-3000 → shard 3
```

**shard strategies:**
- **range based** → by value range (easy but hot spots)
- **hash based** → hash(key) % num_shards (even distribution)
- **directory based** → lookup table for shard location

**problems with sharding:**
- joins across shards are hard
- re-sharding is painful
- hot shards (one shard gets all traffic)

### indexing
speeds up reads by creating a sorted data structure

```sql
-- without index: scan every row
SELECT * FROM users WHERE email = 'a@b.com';

-- with index: jump directly to row
CREATE INDEX idx_email ON users(email);
```

- **B-tree index** → good for range queries, equality
- **Hash index** → only equality queries, very fast
- **Composite index** → multiple columns, order matters
- indexes slow down writes, speed up reads

---

## message queues

decouple services so they don't need to talk directly.

```
producer → [queue] → consumer

instead of:
service A calls service B directly (tight coupling)
```

**use cases:**
- send email after signup (async)
- process payment in background
- handle traffic spikes (queue absorbs burst)
- ensure message delivery even if consumer is down

**tools:** RabbitMQ, Apache Kafka, AWS SQS, Redis Streams

**Kafka vs RabbitMQ:**
- Kafka → high throughput, event streaming, replay messages, log
- RabbitMQ → traditional queue, complex routing, lower throughput

**patterns:**
- **pub/sub** → one producer, many consumers get the message
- **point to point** → one producer, one consumer gets the message
- **fan out** → one message goes to multiple queues

---

## microservices vs monolith

**monolith**
```
┌─────────────────────────────┐
│   Single Application        │
│  ┌──────┐ ┌──────┐ ┌──────┐│
│  │Users ││Posts ││Notify ││
│  └──────┘ └──────┘ └──────┘│
│      Single Database        │
└─────────────────────────────┘
```
pros: simple, easy to develop initially, easy to test
cons: hard to scale specific parts, one bug can crash everything

**microservices**
```
┌────────┐  ┌────────┐  ┌────────┐
│ Users  │  │ Posts  │  │Notify  │
│Service │  │Service │  │Service │
└────┬───┘  └────┬───┘  └────┬───┘
     │            │            │
  ┌──┴──┐     ┌──┴──┐     ┌──┴──┐
  │ DB  │     │ DB  │     │ DB  │
  └─────┘     └─────┘     └─────┘
```
pros: scale each service independently, independent deployments, different tech stacks
cons: complex, network latency, harder to test, distributed system problems

**when to use what:**
- start with monolith, split when you have clear boundaries and scale needs
- microservices if you have large team, clear domain boundaries, different scaling needs

---

## API design

### REST
```
GET    /users          → get all users
GET    /users/:id      → get user by id
POST   /users          → create user
PUT    /users/:id      → replace user
PATCH  /users/:id      → update fields
DELETE /users/:id      → delete user

GET    /users/:id/posts → nested resource
```

**HTTP status codes:**
- 200 OK, 201 Created, 204 No Content
- 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found
- 429 Too Many Requests, 500 Server Error, 503 Service Unavailable

### GraphQL
client requests exactly what it needs

```graphql
query {
  user(id: "123") {
    name
    email
    posts {
      title
      likes
    }
  }
}
```
pros: no over/under fetching, one endpoint, strongly typed
cons: complex caching, harder to optimize on server

### gRPC
binary protocol, uses protocol buffers, very fast

```protobuf
service UserService {
  rpc GetUser (UserRequest) returns (UserResponse);
}
```
pros: very fast, strongly typed, streaming support
cons: not human readable, harder to debug

**when to use:**
- REST → public APIs, web apps, simple CRUD
- GraphQL → complex data requirements, multiple clients
- gRPC → internal microservices, low latency needed

---

## rate limiting

prevent abuse and ensure fair usage

**algorithms:**

**token bucket**
```
bucket has N tokens
each request uses 1 token
tokens refill at rate R per second
if no tokens → reject request
```
allows bursts up to bucket size

**leaky bucket**
```
requests enter bucket at any rate
bucket leaks at constant rate
if full → reject
```
smooth output, no bursts

**fixed window**
```
count requests in current window (e.g. per minute)
if count > limit → reject
reset count each window
```
simple but has edge case at window boundaries

**sliding window log**
```
store timestamp of each request
count requests in last 60 seconds
```
accurate but memory intensive

**where to implement:**
- API gateway
- reverse proxy (Nginx)
- application code
- Redis (distributed rate limiting)

---

## consistent hashing

used in distributed caches and load balancers to minimize re-distribution when nodes are added/removed.

```
servers and keys are placed on a "ring"
each key is served by the next server clockwise

ring: 0 ──────────────────────── 360

   server A (at 90)
   server B (at 180)
   server C (at 270)

key1 hashes to 50  → served by server A (next clockwise)
key2 hashes to 140 → served by server B
key3 hashes to 220 → served by server C
```

when a server is added/removed, only keys on that segment are remapped, not all keys.

**virtual nodes:** each server has multiple points on the ring for better distribution.

---

## real-time communication

**polling**
```
client asks server every N seconds: "any updates?"
simple but wasteful, high latency
```

**long polling**
```
client asks server, server holds connection open
server responds when data is available
client immediately makes new request
less wasteful, but still has latency
```

**WebSockets**
```
persistent bidirectional connection
server can push to client anytime
great for: chat, live feeds, games, notifications
```

**Server-Sent Events (SSE)**
```
one-way: server pushes to client
client can't send back on same connection
good for: notifications, live scores, stock prices
```

---

## proxies

**forward proxy**
```
client → forward proxy → internet
```
hides client, used for: VPN, bypass restrictions, caching

**reverse proxy**
```
internet → reverse proxy → servers
```
hides servers, used for: load balancing, SSL termination, caching, security

**API gateway**
```
clients → API gateway → microservices
```
single entry point, handles: auth, rate limiting, routing, logging, protocol translation

tools: Nginx, Kong, AWS API Gateway

---

## storage types

**block storage**
raw storage, like a hard drive
use for: databases, VMs, OS
example: AWS EBS

**file storage**
files in directories (NFS, SMB)
use for: shared files, home directories
example: AWS EFS

**object storage**
stores objects with metadata and URL
infinite scale, cheap
use for: images, videos, backups, static files
example: AWS S3, MinIO

---

## numbers every engineer should know

| operation | latency |
|---|---|
| L1 cache reference | 1 ns |
| L2 cache reference | 4 ns |
| RAM access | 100 ns |
| SSD read | 100 μs |
| HDD seek | 10 ms |
| Same datacenter | 500 μs |
| Cross-continent | 150 ms |

**scale intuition:**
- 1 million seconds ≈ 11.5 days
- 1 billion seconds ≈ 31.7 years
- 1 server handles ≈ 1000 req/sec
- MySQL ≈ 1000 writes/sec, 10000 reads/sec
- Redis ≈ 100,000 ops/sec
- Kafka ≈ millions of messages/sec

---

## system design interview framework

when asked to design a system, follow this order:

**1. clarify requirements (5 min)**
- what features are needed?
- how many users? (read/write ratio)
- what scale? (requests per second, data size)
- consistency or availability?

**2. estimate scale (5 min)**
- daily active users
- requests per second = DAU × requests/day / 86400
- storage = users × data per user × time
- bandwidth = requests/sec × data per request

**3. high level design (15 min)**
- draw main components: clients, servers, DB, cache, CDN
- explain data flow

**4. deep dive (20 min)**
- focus on most important parts
- discuss tradeoffs
- handle edge cases

**5. wrap up (5 min)**
- bottlenecks
- future improvements
- monitoring

---

## example: design URL shortener

**requirements:**
- shorten long URL to short URL (bit.ly/xyz)
- redirect short URL to long URL
- 100M URLs/day, read heavy (100:1 read to write)

**estimation:**
- writes: 100M/day = 1200/sec
- reads: 12000/sec
- storage: 100M × 500 bytes = 50GB/day

**design:**
```
client → API gateway → app servers → cache (Redis)
                                   → database (PostgreSQL)
```

**short URL generation:**
- base62 encoding (a-z, A-Z, 0-9) = 62 chars
- 7 characters = 62^7 = 3.5 trillion URLs
- hash long URL → take first 7 chars
- or: auto increment ID → base62 encode

**database schema:**
```sql
urls (
  id          bigint primary key,
  short_code  varchar(10) unique,
  long_url    text,
  user_id     bigint,
  created_at  timestamp,
  expires_at  timestamp
)
```

**caching:**
- cache short_code → long_url in Redis
- 80/20 rule: 20% of URLs get 80% of traffic
- cache those 20% (hot URLs)

---

```
=^._.^= design for failure. everything fails.
```
