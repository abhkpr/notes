# Database, SQL & PostgreSQL

> where data lives. learn this well.

---

## what is a database

a database is an organized collection of data stored and accessed electronically. a DBMS (Database Management System) is the software that manages it.

**why not just use files?**
- files don't support concurrent access (two users writing = corruption)
- no way to query data efficiently
- no transactions (partial writes = corrupted data)
- no relationships between data
- no access control

---

## types of databases

**relational (SQL)**
data in tables with rows and columns, relationships via foreign keys
PostgreSQL, MySQL, SQLite, Oracle, SQL Server

**document**
data as JSON-like documents — MongoDB, CouchDB, Firestore

**key-value**
simple key to value store — Redis, DynamoDB

**column-family**
data stored by column, good for analytics — Cassandra, HBase

**graph**
nodes and edges — Neo4j, Amazon Neptune

**time-series**
optimized for time-stamped data — InfluxDB, TimescaleDB

---

## relational concepts

**table** stores data in rows and columns
**row** is one entry in a table
**column** is one property of a record
**schema** is the structure definition of the database
**primary key** uniquely identifies each row
**foreign key** references primary key of another table
**index** speeds up queries on a column
**view** is a virtual table based on a query
**trigger** is code that runs automatically on events

---

## SQL basics

SQL (Structured Query Language) is the language for relational databases.

### CREATE TABLE

```sql
CREATE TABLE users (
    id          SERIAL PRIMARY KEY,
    username    VARCHAR(50) UNIQUE NOT NULL,
    email       VARCHAR(255) UNIQUE NOT NULL,
    password    VARCHAR(255) NOT NULL,
    age         INT CHECK (age > 0),
    bio         TEXT,
    created_at  TIMESTAMP DEFAULT NOW()
);

CREATE TABLE posts (
    id          SERIAL PRIMARY KEY,
    user_id     INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title       VARCHAR(255) NOT NULL,
    content     TEXT,
    published   BOOLEAN DEFAULT FALSE,
    created_at  TIMESTAMP DEFAULT NOW()
);
```

### data types

```sql
-- numbers
INT / INTEGER          -- whole number
BIGINT                 -- large whole number
DECIMAL(10, 2)         -- exact decimal (money)
FLOAT / REAL           -- approximate decimal
SERIAL                 -- auto-incrementing integer

-- text
CHAR(n)                -- fixed length string
VARCHAR(n)             -- variable length, max n
TEXT                   -- unlimited length

-- date/time
DATE                   -- date only (2026-03-05)
TIME                   -- time only (14:30:00)
TIMESTAMP              -- date + time
TIMESTAMPTZ            -- timestamp with timezone
INTERVAL               -- time interval

-- other
BOOLEAN                -- true/false
UUID                   -- universally unique identifier
JSON / JSONB           -- JSON data (JSONB = binary, indexed)
```

### INSERT

```sql
INSERT INTO users (username, email, password)
VALUES ('abhishek', 'a@b.com', 'hashed_pw');

-- multiple rows
INSERT INTO users (username, email, password) VALUES
    ('user1', 'u1@b.com', 'pw1'),
    ('user2', 'u2@b.com', 'pw2');

-- insert and return
INSERT INTO users (username, email, password)
VALUES ('abhishek', 'a@b.com', 'pw')
RETURNING id, created_at;
```

### SELECT

```sql
SELECT * FROM users;
SELECT id, username, email FROM users;
SELECT username AS name FROM users;
SELECT DISTINCT country FROM users;

-- WHERE
SELECT * FROM users WHERE age > 18;
SELECT * FROM users WHERE age BETWEEN 18 AND 30;
SELECT * FROM users WHERE username IN ('a', 'b', 'c');
SELECT * FROM users WHERE bio IS NULL;
SELECT * FROM users WHERE username LIKE 'ab%';
SELECT * FROM users WHERE username ILIKE 'ab%';  -- case insensitive

-- AND / OR / NOT
SELECT * FROM users WHERE age > 18 AND country = 'India';
SELECT * FROM users WHERE age < 18 OR age > 60;

-- ORDER BY
SELECT * FROM users ORDER BY created_at DESC;
SELECT * FROM users ORDER BY age ASC, username DESC;

-- LIMIT and OFFSET (pagination)
SELECT * FROM users LIMIT 10;
SELECT * FROM users LIMIT 10 OFFSET 20;  -- page 3
```

### UPDATE

```sql
UPDATE users SET age = 21 WHERE id = 1;

UPDATE users
SET age = 21, bio = 'developer'
WHERE id = 1;

UPDATE users SET age = 21 WHERE id = 1 RETURNING *;
```

### DELETE

```sql
DELETE FROM users WHERE id = 1;
DELETE FROM users WHERE created_at < '2024-01-01';
TRUNCATE users;  -- delete all rows, faster than DELETE
```

---

## aggregate functions

```sql
SELECT COUNT(*) FROM users;
SELECT SUM(price) FROM orders;
SELECT AVG(age) FROM users;
SELECT MIN(price), MAX(price) FROM products;
SELECT ROUND(AVG(age), 2) FROM users;

-- GROUP BY
SELECT country, COUNT(*) as user_count
FROM users
GROUP BY country
ORDER BY user_count DESC;

-- HAVING (filter groups — like WHERE but for groups)
SELECT country, COUNT(*) as user_count
FROM users
GROUP BY country
HAVING COUNT(*) > 100;

-- WHERE filters rows, HAVING filters groups
SELECT country, COUNT(*) as count
FROM users
WHERE age > 18
GROUP BY country
HAVING COUNT(*) > 10;
```

---

## JOINs

joins combine rows from multiple tables.

```
users:                posts:
id | name             id | user_id | title
1  | abhishek         1  | 1       | first post
2  | rahul            2  | 1       | second post
3  | priya            3  | 2       | rahul's post
```

### INNER JOIN — only matching rows

```sql
SELECT u.name, p.title
FROM users u
INNER JOIN posts p ON p.user_id = u.id;
-- priya not included (no posts)
```

### LEFT JOIN — all from left, matching from right

```sql
SELECT u.name, p.title
FROM users u
LEFT JOIN posts p ON p.user_id = u.id;
-- priya | NULL (included even with no posts)
```

### RIGHT JOIN — all from right, matching from left

```sql
SELECT u.name, p.title
FROM users u
RIGHT JOIN posts p ON p.user_id = u.id;
```

### FULL OUTER JOIN — all from both tables

```sql
SELECT u.name, p.title
FROM users u
FULL OUTER JOIN posts p ON p.user_id = u.id;
```

### multiple joins

```sql
SELECT u.username, p.title, c.content as comment
FROM users u
JOIN posts p ON p.user_id = u.id
JOIN comments c ON c.post_id = p.id
WHERE u.id = 1;
```

---

## subqueries

```sql
-- in WHERE
SELECT * FROM users
WHERE id IN (SELECT user_id FROM posts WHERE published = true);

-- in FROM
SELECT avg_age, country
FROM (
    SELECT country, AVG(age) as avg_age
    FROM users
    GROUP BY country
) AS country_stats
WHERE avg_age > 25;

-- EXISTS
SELECT * FROM users u
WHERE EXISTS (
    SELECT 1 FROM posts p WHERE p.user_id = u.id
);

SELECT * FROM users u
WHERE NOT EXISTS (
    SELECT 1 FROM posts p WHERE p.user_id = u.id
);
```

---

## CTEs (Common Table Expressions)

named temporary result sets — cleaner than nested subqueries

```sql
WITH active_users AS (
    SELECT * FROM users WHERE last_login > NOW() - INTERVAL '30 days'
)
SELECT * FROM active_users WHERE country = 'India';

-- multiple CTEs
WITH
active_users AS (
    SELECT id, username FROM users WHERE active = true
),
user_posts AS (
    SELECT user_id, COUNT(*) as post_count
    FROM posts
    GROUP BY user_id
)
SELECT u.username, COALESCE(p.post_count, 0) as posts
FROM active_users u
LEFT JOIN user_posts p ON p.user_id = u.id
ORDER BY posts DESC;
```

---

## window functions

like GROUP BY but doesn't collapse rows

```sql
-- ROW_NUMBER
SELECT username, age,
    ROW_NUMBER() OVER (ORDER BY age DESC) as rank
FROM users;

-- RANK (1,2,2,4 — skips) vs DENSE_RANK (1,2,2,3 — no skip)
SELECT username, score,
    RANK() OVER (ORDER BY score DESC) as rank,
    DENSE_RANK() OVER (ORDER BY score DESC) as dense_rank
FROM leaderboard;

-- PARTITION BY (rank within group)
SELECT username, country, age,
    RANK() OVER (PARTITION BY country ORDER BY age DESC) as rank_in_country
FROM users;

-- LAG and LEAD (previous/next row)
SELECT date, revenue,
    LAG(revenue) OVER (ORDER BY date) as prev_revenue,
    revenue - LAG(revenue) OVER (ORDER BY date) as change
FROM daily_revenue;

-- running total
SELECT date, revenue,
    SUM(revenue) OVER (ORDER BY date) as running_total
FROM daily_revenue;
```

---

## indexes

speed up queries by avoiding full table scans

```sql
CREATE INDEX idx_users_email ON users(email);
CREATE UNIQUE INDEX idx_users_username ON users(username);

-- composite index (order matters)
CREATE INDEX idx_orders_user_date ON orders(user_id, created_at);

-- partial index (only index subset)
CREATE INDEX idx_active_users ON users(email) WHERE active = true;

-- expression index
CREATE INDEX idx_lower_email ON users(LOWER(email));

DROP INDEX idx_users_email;

-- check what indexes exist
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'users';

-- analyze query
EXPLAIN SELECT * FROM users WHERE email = 'a@b.com';
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'a@b.com';
```

**when to index:**
- columns in WHERE, JOIN, ORDER BY, GROUP BY
- foreign keys
- columns frequently searched/filtered

**when NOT to:**
- small tables (full scan is fine)
- columns rarely used in queries
- tables with very heavy writes (indexes slow inserts)

---

## transactions

operations that succeed or fail together (all or nothing)

```sql
BEGIN;
    UPDATE accounts SET balance = balance - 1000 WHERE id = 1;
    UPDATE accounts SET balance = balance + 1000 WHERE id = 2;
COMMIT;

-- rollback on error
BEGIN;
    UPDATE accounts SET balance = balance - 1000 WHERE id = 1;
    -- error here
ROLLBACK;

-- savepoints
BEGIN;
    INSERT INTO orders (user_id, total) VALUES (1, 500);
    SAVEPOINT order_created;
    INSERT INTO order_items (order_id, product_id) VALUES (1, 10);
    -- if error:
    ROLLBACK TO order_created;
COMMIT;
```

**ACID:**
- **Atomicity** — all or nothing
- **Consistency** — data always valid
- **Isolation** — transactions don't interfere
- **Durability** — committed data survives crashes

---

## normalization

organizing tables to reduce redundancy.

**1NF** — each column has single values, no repeating groups
**2NF** — 1NF + every column depends on whole primary key
**3NF** — 2NF + no column depends on another non-key column

**example of 3NF violation:**
```
orders: order_id | customer_id | customer_city
```
customer_city depends on customer_id, not order_id

**fixed:**
```
orders: order_id | customer_id
customers: customer_id | customer_city
```

---

## PostgreSQL specific

### connect

```bash
psql -U postgres -d mydb
psql "postgresql://user:password@host:5432/dbname"
```

### psql commands

```
\l          list databases
\c dbname   connect to database
\dt         list tables
\d table    describe table
\du         list users
\timing     toggle timing
\q          quit
```

### PostgreSQL extras

```sql
-- UUID
id UUID DEFAULT gen_random_uuid()

-- Arrays
tags TEXT[] DEFAULT '{}'
SELECT * FROM posts WHERE 'tech' = ANY(tags);
SELECT * FROM posts WHERE tags @> ARRAY['tech', 'python'];

-- JSONB
data JSONB
SELECT data->>'name' FROM users;
SELECT data->'address'->>'city' FROM users;
SELECT * FROM users WHERE data @> '{"role":"admin"}';
CREATE INDEX idx_data ON users USING GIN(data);

-- upsert
INSERT INTO users (email, name)
VALUES ('a@b.com', 'abhishek')
ON CONFLICT (email)
DO UPDATE SET name = EXCLUDED.name, updated_at = NOW();

ON CONFLICT DO NOTHING;

-- date functions
NOW()
CURRENT_DATE
DATE_TRUNC('month', created_at)
EXTRACT(YEAR FROM created_at)
created_at + INTERVAL '7 days'
AGE(created_at)
created_at AT TIME ZONE 'Asia/Kolkata'

-- conditional
CASE
    WHEN age < 18 THEN 'minor'
    WHEN age < 60 THEN 'adult'
    ELSE 'senior'
END

COALESCE(bio, 'no bio')   -- first non-null value
NULLIF(value, 0)          -- return null if equal to second arg

-- full text search
SELECT * FROM posts
WHERE to_tsvector('english', content) @@ to_tsquery('python & django');

CREATE INDEX idx_fts ON posts USING GIN(to_tsvector('english', content));
```

### backup and restore

```bash
pg_dump mydb > backup.sql
pg_dump -Fc mydb > backup.dump

psql mydb < backup.sql
pg_restore -d mydb backup.dump
```

---

## query optimization tips

```sql
-- see query plan
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'a@b.com';

-- look for:
-- Seq Scan      full table scan (slow on big tables)
-- Index Scan    using index (good)
-- Index Only    only reads index (best)

-- update stats so planner makes better decisions
ANALYZE users;
VACUUM ANALYZE users;

-- check table size
SELECT pg_size_pretty(pg_total_relation_size('users'));

-- find slow queries
SELECT query, mean_exec_time, calls
FROM pg_stat_statements
ORDER BY mean_exec_time DESC
LIMIT 10;
```

---

## common design patterns

### soft delete

```sql
ALTER TABLE users ADD COLUMN deleted_at TIMESTAMP;

-- soft delete
UPDATE users SET deleted_at = NOW() WHERE id = 1;

-- query active only
SELECT * FROM users WHERE deleted_at IS NULL;

-- partial index for performance
CREATE INDEX idx_active ON users(id) WHERE deleted_at IS NULL;
```

### audit trail

```sql
CREATE TABLE users_audit (
    id          SERIAL PRIMARY KEY,
    user_id     INT,
    operation   CHAR(1),  -- I/U/D
    changed_at  TIMESTAMP DEFAULT NOW(),
    old_data    JSONB,
    new_data    JSONB
);
```

### pagination patterns

```sql
-- offset pagination (simple but slow on large offsets)
SELECT * FROM posts ORDER BY created_at DESC LIMIT 20 OFFSET 100;

-- cursor pagination (fast, consistent)
SELECT * FROM posts
WHERE created_at < '2026-03-01T10:00:00'
ORDER BY created_at DESC
LIMIT 20;
```

---

```
=^._.^= the database is the source of truth
```
