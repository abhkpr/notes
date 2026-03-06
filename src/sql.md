# SQL and PostgreSQL

> the language of data. every serious app needs this.

---

## what is SQL

SQL (Structured Query Language) is the language used to talk to relational databases. you use it to create tables, insert data, read data, update it, and delete it.

**relational database** — data stored in tables with rows and columns, like a spreadsheet. tables can be related to each other through keys.

PostgreSQL (Postgres) is the most powerful open source relational database. Supabase runs on PostgreSQL under the hood, so every query you write in Supabase is PostgreSQL.

---

## core concepts

**table** — like a spreadsheet. has columns (fields) and rows (records).

**row / record** — one entry in a table. one user, one post, one goal.

**column / field** — one attribute of the data. name, email, created_at.

**primary key** — unique identifier for each row. usually `id`. no two rows can have the same primary key.

**foreign key** — column that references the primary key of another table. creates a relationship between tables.

**schema** — the structure/blueprint of your database. what tables exist, what columns they have, what types.

**query** — a request to the database. can read, write, update, or delete data.

---

## data types

```sql
-- text
TEXT              -- variable length text, any size
VARCHAR(255)      -- variable length, max 255 chars
CHAR(10)          -- fixed length, always 10 chars

-- numbers
INTEGER           -- whole numbers (-2B to 2B)
BIGINT            -- large whole numbers
SMALLINT          -- small whole numbers
NUMERIC(10, 2)    -- exact decimal, 10 digits, 2 after point (use for money)
REAL              -- floating point (imprecise)
DOUBLE PRECISION  -- larger floating point

-- boolean
BOOLEAN           -- true or false

-- date and time
DATE              -- 2026-03-06
TIME              -- 14:30:00
TIMESTAMP         -- 2026-03-06 14:30:00
TIMESTAMPTZ       -- timestamp with timezone (use this always)
INTERVAL          -- period of time (1 hour, 3 days)

-- special
UUID              -- universally unique identifier (good for IDs)
JSON              -- JSON data
JSONB             -- binary JSON (faster, use this over JSON)
ARRAY             -- array of values
SERIAL            -- auto-incrementing integer (old way)
```

---

## creating tables

```sql
-- basic table
CREATE TABLE users (
    id          BIGSERIAL PRIMARY KEY,
    name        TEXT NOT NULL,
    email       TEXT NOT NULL UNIQUE,
    created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- with foreign key
CREATE TABLE posts (
    id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id     BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title       TEXT NOT NULL,
    content     TEXT,
    published   BOOLEAN DEFAULT false,
    created_at  TIMESTAMPTZ DEFAULT NOW(),
    updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- with check constraint
CREATE TABLE goals (
    id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id     UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    title       TEXT NOT NULL CHECK (length(title) > 0),
    mood        INTEGER CHECK (mood BETWEEN 1 AND 5),
    date        DATE NOT NULL DEFAULT CURRENT_DATE,
    completed   BOOLEAN DEFAULT false,
    created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- modify existing table
ALTER TABLE users ADD COLUMN bio TEXT;
ALTER TABLE users DROP COLUMN bio;
ALTER TABLE users ALTER COLUMN name SET NOT NULL;
ALTER TABLE users RENAME COLUMN name TO full_name;

-- delete table
DROP TABLE users;
DROP TABLE IF EXISTS users;              -- no error if not exists
DROP TABLE users CASCADE;               -- also drops dependent objects
```

**constraints:**
- `NOT NULL` — column must have a value
- `UNIQUE` — no two rows can have same value
- `PRIMARY KEY` — unique + not null, identifies each row
- `REFERENCES` — foreign key, must exist in referenced table
- `DEFAULT` — value if none provided
- `CHECK` — custom condition that must be true

**ON DELETE CASCADE** — when parent row is deleted, automatically delete child rows too. when user is deleted, delete all their posts.

---

## inserting data

```sql
-- single row
INSERT INTO users (name, email)
VALUES ('Abhishek Kumar', 'abhishek@example.com');

-- multiple rows
INSERT INTO users (name, email) VALUES
    ('Rahul', 'rahul@example.com'),
    ('Priya', 'priya@example.com'),
    ('Amit', 'amit@example.com');

-- insert and return the created row
INSERT INTO users (name, email)
VALUES ('Abhishek', 'a@b.com')
RETURNING *;

-- insert or do nothing if conflict
INSERT INTO users (email, name)
VALUES ('a@b.com', 'Abhishek')
ON CONFLICT (email) DO NOTHING;

-- insert or update on conflict (upsert)
INSERT INTO users (email, name)
VALUES ('a@b.com', 'Abhishek Updated')
ON CONFLICT (email)
DO UPDATE SET name = EXCLUDED.name, updated_at = NOW();
```

---

## reading data (SELECT)

SELECT is the most important SQL command. you will write it constantly.

```sql
-- get everything
SELECT * FROM users;

-- get specific columns
SELECT id, name, email FROM users;

-- with alias
SELECT name AS full_name, email AS contact FROM users;

-- with condition
SELECT * FROM users WHERE email = 'a@b.com';
SELECT * FROM users WHERE age > 18;
SELECT * FROM users WHERE name LIKE 'Abhi%';    -- starts with Abhi
SELECT * FROM users WHERE name ILIKE 'abhi%';   -- case insensitive
SELECT * FROM users WHERE name LIKE '%kumar%';  -- contains kumar
SELECT * FROM users WHERE created_at > '2026-01-01';

-- multiple conditions
SELECT * FROM users WHERE age > 18 AND city = 'Lucknow';
SELECT * FROM users WHERE city = 'Lucknow' OR city = 'Delhi';
SELECT * FROM users WHERE city IN ('Lucknow', 'Delhi', 'Mumbai');
SELECT * FROM users WHERE city NOT IN ('Chennai', 'Kolkata');
SELECT * FROM users WHERE age BETWEEN 18 AND 25;
SELECT * FROM users WHERE bio IS NULL;
SELECT * FROM users WHERE bio IS NOT NULL;

-- order results
SELECT * FROM users ORDER BY name ASC;
SELECT * FROM users ORDER BY created_at DESC;
SELECT * FROM users ORDER BY city ASC, name ASC;  -- multiple columns

-- limit and offset (pagination)
SELECT * FROM users LIMIT 10;
SELECT * FROM users LIMIT 10 OFFSET 20;  -- skip 20, get next 10

-- distinct (remove duplicates)
SELECT DISTINCT city FROM users;

-- count
SELECT COUNT(*) FROM users;
SELECT COUNT(*) FROM users WHERE city = 'Lucknow';

-- aggregate functions
SELECT
    COUNT(*)            AS total_users,
    AVG(age)            AS average_age,
    MAX(age)            AS oldest,
    MIN(age)            AS youngest,
    SUM(purchases)      AS total_purchases
FROM users;
```

---

## updating data

```sql
-- update all rows (dangerous!)
UPDATE users SET verified = true;

-- update with condition
UPDATE users
SET name = 'Abhishek Kumar'
WHERE id = 1;

-- update multiple fields
UPDATE users
SET
    name = 'Abhishek Kumar',
    bio = 'Developer from Lucknow',
    updated_at = NOW()
WHERE id = 1;

-- update and return updated row
UPDATE users
SET name = 'New Name'
WHERE id = 1
RETURNING *;

-- update based on another table
UPDATE posts
SET published = true
WHERE user_id IN (SELECT id FROM users WHERE verified = true);
```

---

## deleting data

```sql
-- delete with condition (always use WHERE)
DELETE FROM users WHERE id = 1;

-- delete multiple
DELETE FROM users WHERE created_at < '2024-01-01';

-- delete and return deleted rows
DELETE FROM users WHERE id = 1 RETURNING *;

-- delete all rows (keeps table structure)
DELETE FROM users;

-- faster way to clear table
TRUNCATE TABLE users;
TRUNCATE TABLE users RESTART IDENTITY;  -- also resets auto-increment
```

**always use WHERE with DELETE and UPDATE.** without WHERE you affect every row.

---

## joins

joins combine data from multiple tables. this is the most powerful feature of relational databases.

```sql
-- sample tables
-- users:  id, name, email
-- posts:  id, user_id, title, content
-- comments: id, post_id, user_id, text

-- INNER JOIN — only rows that match in BOTH tables
SELECT
    users.name,
    posts.title,
    posts.created_at
FROM posts
INNER JOIN users ON posts.user_id = users.id;

-- LEFT JOIN — all rows from left table, matching from right (null if no match)
SELECT
    users.name,
    COUNT(posts.id) AS post_count
FROM users
LEFT JOIN posts ON posts.user_id = users.id
GROUP BY users.id, users.name;
-- users with no posts still appear with post_count = 0

-- multiple joins
SELECT
    posts.title,
    users.name AS author,
    COUNT(comments.id) AS comment_count
FROM posts
INNER JOIN users ON posts.user_id = users.id
LEFT JOIN comments ON comments.post_id = posts.id
GROUP BY posts.id, posts.title, users.name
ORDER BY comment_count DESC;

-- self join (table joined with itself)
-- find users in same city
SELECT
    a.name AS user1,
    b.name AS user2,
    a.city
FROM users a
INNER JOIN users b ON a.city = b.city AND a.id != b.id;
```

**types of joins:**
- `INNER JOIN` — only matching rows from both tables
- `LEFT JOIN` — all rows from left, matching from right (nulls for no match)
- `RIGHT JOIN` — all rows from right, matching from left
- `FULL OUTER JOIN` — all rows from both, nulls where no match

use LEFT JOIN most of the time when you want to include rows even if there is no matching row in the other table.

---

## grouping and aggregating

```sql
-- GROUP BY — group rows and aggregate
SELECT
    city,
    COUNT(*) AS user_count,
    AVG(age) AS avg_age
FROM users
GROUP BY city;

-- HAVING — filter after grouping (like WHERE but for groups)
SELECT
    city,
    COUNT(*) AS user_count
FROM users
GROUP BY city
HAVING COUNT(*) > 10;  -- only cities with more than 10 users

-- order of clauses
SELECT city, COUNT(*) AS count
FROM users
WHERE age > 18          -- filter rows first
GROUP BY city           -- then group
HAVING COUNT(*) > 5     -- then filter groups
ORDER BY count DESC     -- then order
LIMIT 10;               -- then limit
```

---

## subqueries

a query inside another query.

```sql
-- find users who have posted at least once
SELECT * FROM users
WHERE id IN (
    SELECT DISTINCT user_id FROM posts
);

-- find users who have never posted
SELECT * FROM users
WHERE id NOT IN (
    SELECT DISTINCT user_id FROM posts WHERE user_id IS NOT NULL
);

-- subquery in SELECT
SELECT
    name,
    (SELECT COUNT(*) FROM posts WHERE posts.user_id = users.id) AS post_count
FROM users;

-- EXISTS (faster than IN for large datasets)
SELECT * FROM users u
WHERE EXISTS (
    SELECT 1 FROM posts p WHERE p.user_id = u.id
);
```

---

## indexes

indexes make queries faster by creating a separate data structure for quick lookup. without an index, the database scans every row.

```sql
-- create index
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_posts_user_id ON posts(user_id);

-- unique index (also enforces uniqueness)
CREATE UNIQUE INDEX idx_users_email ON users(email);

-- composite index (multiple columns)
CREATE INDEX idx_posts_user_date ON posts(user_id, created_at DESC);

-- partial index (only index rows matching condition)
CREATE INDEX idx_published_posts ON posts(created_at)
WHERE published = true;

-- drop index
DROP INDEX idx_users_email;

-- see query plan (how database executes query)
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'a@b.com';
```

**when to add indexes:**
- columns used in WHERE clauses often
- foreign key columns (user_id, post_id)
- columns used in ORDER BY
- columns used in JOIN conditions

**cost of indexes:** they speed up reads but slow down writes (index must be updated). don't index everything.

---

## views

a view is a saved query you can treat like a table.

```sql
-- create view
CREATE VIEW active_users AS
SELECT id, name, email, created_at
FROM users
WHERE active = true AND deleted_at IS NULL;

-- use view
SELECT * FROM active_users WHERE name LIKE 'A%';

-- update view
CREATE OR REPLACE VIEW active_users AS ...;

-- drop view
DROP VIEW active_users;
```

---

## functions and useful expressions

```sql
-- string functions
UPPER('hello')              -- 'HELLO'
LOWER('HELLO')              -- 'hello'
LENGTH('hello')             -- 5
TRIM('  hello  ')           -- 'hello'
SUBSTRING('hello' FROM 2 FOR 3)  -- 'ell'
CONCAT('hello', ' ', 'world')    -- 'hello world'
REPLACE('hello', 'l', 'r')       -- 'herro'
SPLIT_PART('a,b,c', ',', 2)      -- 'b'

-- number functions
ROUND(3.14159, 2)           -- 3.14
CEIL(3.2)                   -- 4
FLOOR(3.9)                  -- 3
ABS(-5)                     -- 5
MOD(10, 3)                  -- 1

-- date functions
NOW()                       -- current timestamp with timezone
CURRENT_DATE                -- current date
CURRENT_TIME                -- current time
DATE_TRUNC('month', NOW())  -- first day of current month
EXTRACT(YEAR FROM NOW())    -- 2026
EXTRACT(MONTH FROM NOW())   -- 3
AGE(birthdate)              -- interval from birthdate to now
created_at + INTERVAL '7 days'  -- add 7 days

-- conditional
CASE
    WHEN age < 13 THEN 'child'
    WHEN age < 18 THEN 'teen'
    ELSE 'adult'
END AS age_group

COALESCE(bio, 'No bio yet')  -- first non-null value
NULLIF(value, 0)             -- null if value equals 0
```

---

## transactions

a transaction groups multiple operations. either ALL succeed or ALL fail. essential for data integrity.

```sql
BEGIN;

    UPDATE accounts SET balance = balance - 500 WHERE id = 1;
    UPDATE accounts SET balance = balance + 500 WHERE id = 2;

COMMIT;  -- both updates are saved

-- if something goes wrong
BEGIN;

    UPDATE accounts SET balance = balance - 500 WHERE id = 1;
    -- error happens here

ROLLBACK;  -- neither update is saved, data is safe
```

**ACID properties of transactions:**
- **Atomicity** — all or nothing
- **Consistency** — database stays valid
- **Isolation** — transactions don't interfere
- **Durability** — committed data survives crashes

---

## PostgreSQL specific features

```sql
-- UUID generation
SELECT gen_random_uuid();

-- JSONB operations
SELECT data->'name' FROM users;            -- get JSON field
SELECT data->>'name' FROM users;           -- as text
SELECT * FROM users WHERE data ? 'email';  -- has key
UPDATE users SET data = data || '{"active": true}';  -- merge

-- array operations
SELECT ARRAY[1, 2, 3];
SELECT '{1,2,3}'::int[];
SELECT * FROM users WHERE 'tag' = ANY(tags);
SELECT array_agg(name) FROM users;         -- aggregate into array

-- full text search
SELECT * FROM posts
WHERE to_tsvector('english', title || ' ' || content)
    @@ to_tsquery('english', 'database & sql');

-- window functions
SELECT
    name,
    salary,
    AVG(salary) OVER (PARTITION BY department) AS dept_avg,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
FROM employees;

-- common table expressions (CTE) — cleaner than subqueries
WITH top_users AS (
    SELECT user_id, COUNT(*) AS post_count
    FROM posts
    GROUP BY user_id
    ORDER BY post_count DESC
    LIMIT 10
)
SELECT users.name, top_users.post_count
FROM top_users
JOIN users ON users.id = top_users.user_id;
```

---

## row level security (Supabase)

RLS ensures users can only access their own data. essential for Supabase apps.

```sql
-- enable RLS on table
ALTER TABLE goals ENABLE ROW LEVEL SECURITY;

-- policy: users can only see their own goals
CREATE POLICY "users can view own goals"
ON goals FOR SELECT
USING (auth.uid() = user_id);

-- policy: users can only insert their own goals
CREATE POLICY "users can insert own goals"
ON goals FOR INSERT
WITH CHECK (auth.uid() = user_id);

-- policy: users can only update their own goals
CREATE POLICY "users can update own goals"
ON goals FOR UPDATE
USING (auth.uid() = user_id);

-- policy: users can only delete their own goals
CREATE POLICY "users can delete own goals"
ON goals FOR DELETE
USING (auth.uid() = user_id);

-- policy: public read (anyone can read)
CREATE POLICY "anyone can view published posts"
ON posts FOR SELECT
USING (published = true);
```

---

## database design principles

**normalization** — organize tables to reduce redundancy.

**1NF** — each column has one value. no arrays of values in a cell.

**2NF** — non-key columns depend on the whole primary key.

**3NF** — non-key columns depend only on the primary key, not on each other.

```sql
-- bad design (unnormalized)
users: id, name, city, city_population
-- city_population depends on city, not on user

-- good design (normalized)
users: id, name, city_id
cities: id, name, population
```

**denormalization** — sometimes intentionally break normalization for performance. store computed values to avoid expensive joins.

**naming conventions:**
```sql
-- tables: lowercase, plural, snake_case
users, blog_posts, daily_logs

-- columns: lowercase, snake_case
user_id, created_at, full_name

-- primary keys: id
-- foreign keys: referenced_table_id (user_id, post_id)
-- booleans: is_ or has_ prefix (is_active, has_verified)
-- timestamps: _at suffix (created_at, deleted_at, published_at)
```

---

```
=^._.^= data is everything. model it carefully.
```
