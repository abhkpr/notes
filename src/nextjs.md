# Next.js (App Router)

## What is Next.js?

Next.js is a React framework that gives you everything you need to build production-ready web applications. React alone is just a UI library — it renders components. Next.js adds routing, server-side rendering, API routes, optimized images, fonts, and more on top of React.

**Real-world analogy:** React is like having a powerful engine. Next.js is the complete car — engine already installed, plus steering wheel, brakes, GPS, and fuel system all pre-configured and optimized to work together. You could assemble all of this yourself, but why would you?

**Why App Router (not Pages Router)?**
Next.js has two routing systems. The older Pages Router (`/pages` directory) is still supported. The newer App Router (`/app` directory), introduced in Next.js 13, is the future — it uses React Server Components, streaming, and layouts built into the framework. This note covers the App Router exclusively.

---

## Part 1 — Installation and Project Structure

### Creating a Project

```bash
npx create-next-app@latest my-app
# or
pnpm create next-app my-app

# Prompts you'll see:
# ✓ TypeScript? Yes
# ✓ ESLint? Yes
# ✓ Tailwind CSS? Yes
# ✓ src/ directory? No (personal preference)
# ✓ App Router? Yes       ← this is what we want
# ✓ Import alias? Yes (@/*)

cd my-app
npm run dev   # starts on http://localhost:3000
```

### Project Structure

```
my-app/
├── app/                    ← App Router lives here
│   ├── layout.tsx          ← Root layout (wraps every page)
│   ├── page.tsx            ← Home page  (route: /)
│   ├── globals.css         ← Global styles
│   ├── about/
│   │   └── page.tsx        ← About page (route: /about)
│   ├── blog/
│   │   ├── page.tsx        ← Blog list  (route: /blog)
│   │   └── [slug]/
│   │       └── page.tsx    ← Blog post  (route: /blog/:slug)
│   └── api/
│       └── hello/
│           └── route.ts    ← API endpoint (route: /api/hello)
├── components/             ← Reusable components
├── lib/                    ← Utilities, helpers
├── public/                 ← Static files (images, fonts)
├── next.config.js
├── tailwind.config.ts
└── tsconfig.json
```

**Key rule:** Every folder in `app/` that has a `page.tsx` file becomes a route. That's it.

---

## Part 2 — Routing

### File-Based Routing

**Real-world analogy:** Think of the `app/` folder as a filing cabinet. Each drawer (folder) is a URL segment. To add a new page, you add a new drawer with a `page.tsx` file inside it. No configuration needed.

```
app/page.tsx                → /
app/about/page.tsx          → /about
app/blog/page.tsx           → /blog
app/blog/nextjs/page.tsx    → /blog/nextjs
app/dashboard/settings/page.tsx → /dashboard/settings
```

```tsx
// app/about/page.tsx
export default function AboutPage() {
  return (
    <main>
      <h1>About Us</h1>
      <p>We build great things.</p>
    </main>
  );
}
```

### Dynamic Routes

Use square brackets for URL parameters.

```
app/blog/[slug]/page.tsx    → /blog/anything
app/shop/[category]/[id]/page.tsx → /shop/electronics/42
app/[...slug]/page.tsx      → /a/b/c/d (catch-all)
app/[[...slug]]/page.tsx    → / AND /a/b/c (optional catch-all)
```

```tsx
// app/blog/[slug]/page.tsx
interface PageProps {
  params: { slug: string };
  searchParams: { [key: string]: string | string[] | undefined };
}

export default function BlogPost({ params, searchParams }: PageProps) {
  return (
    <article>
      <h1>Post: {params.slug}</h1>
      {/* URL: /blog/nextjs-guide → params.slug = "nextjs-guide" */}
    </article>
  );
}
```

### Route Groups

Group routes without affecting the URL. Use parentheses — they're invisible in the URL.

```
app/
├── (marketing)/            ← route group — URL not affected
│   ├── about/page.tsx      → /about
│   └── blog/page.tsx       → /blog
├── (dashboard)/            ← different layout for dashboard
│   ├── layout.tsx          ← dashboard-specific layout
│   └── settings/page.tsx   → /settings
```

**Use case:** Apply a different layout to a subset of pages (dashboard vs marketing pages) without the group name appearing in the URL.

### Parallel Routes

Render multiple pages simultaneously in the same layout.

```
app/
├── layout.tsx
├── page.tsx
├── @team/               ← slot named "team"
│   └── page.tsx
└── @analytics/          ← slot named "analytics"
    └── page.tsx
```

```tsx
// app/layout.tsx
export default function Layout({
  children,
  team,
  analytics,
}: {
  children: React.ReactNode;
  team: React.ReactNode;
  analytics: React.ReactNode;
}) {
  return (
    <div>
      {children}
      <div className="grid grid-cols-2">
        {team}
        {analytics}
      </div>
    </div>
  );
}
```

---

## Part 3 — Layouts

Layouts wrap pages and persist across navigation — they don't re-render when navigating between pages that share the same layout.

**Real-world analogy:** A website's navbar and footer. When you click "About" from "Home", the navbar doesn't flicker or reload. It stays exactly as it is while only the page content changes. That's a persistent layout.

### Root Layout (Required)

```tsx
// app/layout.tsx
import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import './globals.css';

const inter = Inter({ subsets: ['latin'] });

// Metadata API — generates <head> tags
export const metadata: Metadata = {
  title: {
    default: 'My App',
    template: '%s | My App',   // "About | My App"
  },
  description: 'A great Next.js application',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <header>
          <nav>My App</nav>
        </header>
        <main>{children}</main>
        <footer>© 2025</footer>
      </body>
    </html>
  );
}
```

### Nested Layouts

```tsx
// app/dashboard/layout.tsx
// This layout wraps ALL pages inside /dashboard/**
export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="flex">
      <aside>
        <nav>
          <a href="/dashboard">Overview</a>
          <a href="/dashboard/settings">Settings</a>
          <a href="/dashboard/analytics">Analytics</a>
        </nav>
      </aside>
      <section className="flex-1">{children}</section>
    </div>
  );
}
```

Layout hierarchy:
```
RootLayout (app/layout.tsx)
  └─ DashboardLayout (app/dashboard/layout.tsx)
       └─ Page (app/dashboard/settings/page.tsx)
```

---

## Part 4 — Server vs Client Components

This is the most important concept in the App Router.

**Real-world analogy:** A restaurant menu vs a touchscreen kiosk.
- The printed menu (Server Component) is prepared in the kitchen, printed once, and handed to you. It's static and efficient.
- The touchscreen kiosk (Client Component) is interactive — you tap it, it responds, it tracks your order.

Most of your app can be menus (Server Components). Only interactive parts need to be kiosks (Client Components).

### Server Components (Default)

All components in the App Router are Server Components by default.

```tsx
// app/page.tsx
// NO "use client" directive = Server Component

// Can use: async/await, database calls, file system, env vars
// Cannot use: useState, useEffect, onClick, browser APIs

async function getPosts() {
  // This runs on the SERVER — no API call from browser!
  const res = await fetch('https://api.example.com/posts', {
    next: { revalidate: 3600 }, // cache for 1 hour
  });
  return res.json();
}

export default async function BlogPage() {
  const posts = await getPosts(); // await directly in component!

  return (
    <div>
      {posts.map((post: { id: number; title: string }) => (
        <article key={post.id}>
          <h2>{post.title}</h2>
        </article>
      ))}
    </div>
  );
}
```

**Benefits of Server Components:**
- Zero JavaScript sent to browser (just HTML)
- Can access backend resources directly (no API route needed)
- Secrets (API keys, DB passwords) stay on server
- Faster initial page load

### Client Components

Add `'use client'` at the top of the file.

```tsx
// components/Counter.tsx
'use client'; // This directive makes it a Client Component

import { useState } from 'react';

export default function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>
        Increment
      </button>
    </div>
  );
}
```

### Mixing Server and Client Components

```tsx
// app/page.tsx — Server Component
import Counter from '@/components/Counter'; // Client Component
import { db } from '@/lib/db';

export default async function Page() {
  const user = await db.user.findFirst(); // server-side DB query

  return (
    <div>
      {/* Server-rendered content */}
      <h1>Welcome, {user.name}</h1>

      {/* Client Component embedded in server component */}
      <Counter />
    </div>
  );
}
```

**Rules:**
- Server Components can import Client Components ✓
- Client Components cannot import Server Components ✗
- You can pass Server Component output as props/children to Client Components ✓

```tsx
// Pattern: pass server data as props to client component
// app/page.tsx (Server)
import InteractiveList from '@/components/InteractiveList';
import { getItems } from '@/lib/data';

export default async function Page() {
  const items = await getItems(); // server-side fetch
  return <InteractiveList items={items} />; // pass to client
}

// components/InteractiveList.tsx (Client)
'use client';
import { useState } from 'react';

export default function InteractiveList({
  items,
}: {
  items: { id: number; name: string }[];
}) {
  const [selected, setSelected] = useState<number | null>(null);
  return (
    <ul>
      {items.map((item) => (
        <li
          key={item.id}
          onClick={() => setSelected(item.id)}
          className={selected === item.id ? 'bg-blue-100' : ''}
        >
          {item.name}
        </li>
      ))}
    </ul>
  );
}
```

---

## Part 5 — Data Fetching

### fetch() in Server Components

Next.js extends the native `fetch` API with caching options.

```tsx
// Default: cached (like SSG — generated once)
const data = await fetch('https://api.example.com/data');

// Revalidate every 60 seconds (like ISR)
const data = await fetch('https://api.example.com/data', {
  next: { revalidate: 60 },
});

// Never cache (like SSR — fresh on every request)
const data = await fetch('https://api.example.com/data', {
  cache: 'no-store',
});

// Tag-based revalidation (revalidate on demand)
const data = await fetch('https://api.example.com/posts', {
  next: { tags: ['posts'] },
});
```

### Parallel Data Fetching

```tsx
// BAD: sequential (each waits for previous)
const user = await fetchUser(id);           // 100ms
const posts = await fetchPosts(user.id);    // 100ms
const comments = await fetchComments();     // 100ms
// Total: 300ms

// GOOD: parallel
const [user, posts, comments] = await Promise.all([
  fetchUser(id),
  fetchPosts(),
  fetchComments(),
]);
// Total: ~100ms (all run at same time)
```

### Loading States with Suspense

```tsx
// app/dashboard/page.tsx
import { Suspense } from 'react';
import UserProfile from './UserProfile';
import RecentPosts from './RecentPosts';

export default function DashboardPage() {
  return (
    <div>
      <h1>Dashboard</h1>

      {/* Each Suspense boundary shows its own loading state */}
      <Suspense fallback={<div>Loading profile...</div>}>
        <UserProfile />  {/* Async Server Component */}
      </Suspense>

      <Suspense fallback={<div>Loading posts...</div>}>
        <RecentPosts />  {/* Async Server Component */}
      </Suspense>
    </div>
  );
}
```

```tsx
// app/dashboard/UserProfile.tsx
async function UserProfile() {
  const user = await fetchUser(); // This component streams independently
  return <div>{user.name}</div>;
}
```

### Loading File (Automatic Suspense)

Create `loading.tsx` in any folder — it automatically wraps the page in Suspense.

```tsx
// app/dashboard/loading.tsx
export default function Loading() {
  return (
    <div className="animate-pulse">
      <div className="h-8 bg-gray-200 rounded w-1/4 mb-4" />
      <div className="h-4 bg-gray-200 rounded w-full mb-2" />
      <div className="h-4 bg-gray-200 rounded w-3/4" />
    </div>
  );
}
```

### Error Handling

```tsx
// app/dashboard/error.tsx
'use client'; // Error boundaries must be Client Components

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  return (
    <div className="text-center p-8">
      <h2>Something went wrong!</h2>
      <p className="text-gray-600">{error.message}</p>
      <button
        onClick={reset}
        className="mt-4 px-4 py-2 bg-blue-500 text-white rounded"
      >
        Try again
      </button>
    </div>
  );
}
```

---

## Part 6 — Server Actions

Server Actions let you run server-side code directly from form submissions or button clicks — no API route needed.

**Real-world analogy:** Instead of writing a letter (API route), mailing it (HTTP request), and waiting for a reply letter, it's like having a direct phone line to the server. Click a button on your screen, server code runs immediately.

```tsx
// app/contact/page.tsx
async function sendEmail(formData: FormData) {
  'use server'; // This function runs on the SERVER

  const name = formData.get('name') as string;
  const email = formData.get('email') as string;
  const message = formData.get('message') as string;

  // Direct DB call, email service, etc.
  await emailService.send({
    to: 'admin@mysite.com',
    subject: `Message from ${name}`,
    body: message,
  });

  // revalidate cached data if needed
  // revalidatePath('/contact');
}

export default function ContactPage() {
  return (
    <form action={sendEmail}>
      <input name="name" placeholder="Your name" required />
      <input name="email" type="email" required />
      <textarea name="message" required />
      <button type="submit">Send</button>
    </form>
  );
}
```

**Server Actions with feedback:**

```tsx
// app/todos/page.tsx
'use client';

import { useFormState, useFormStatus } from 'react-dom';
import { addTodo } from './actions';

function SubmitButton() {
  const { pending } = useFormStatus();
  return (
    <button type="submit" disabled={pending}>
      {pending ? 'Adding...' : 'Add Todo'}
    </button>
  );
}

export default function TodoPage() {
  const [state, action] = useFormState(addTodo, { message: '' });

  return (
    <form action={action}>
      <input name="title" placeholder="New todo..." />
      <SubmitButton />
      {state.message && <p>{state.message}</p>}
    </form>
  );
}
```

```ts
// app/todos/actions.ts
'use server';

import { revalidatePath } from 'next/cache';

export async function addTodo(
  prevState: { message: string },
  formData: FormData
) {
  const title = formData.get('title') as string;

  if (!title.trim()) {
    return { message: 'Title is required' };
  }

  await db.todo.create({ data: { title } });
  revalidatePath('/todos');
  return { message: 'Todo added!' };
}
```

---

## Part 7 — API Routes

For REST APIs or webhooks, use Route Handlers.

```ts
// app/api/posts/route.ts
import { NextRequest, NextResponse } from 'next/server';

// GET /api/posts
export async function GET(request: NextRequest) {
  const searchParams = request.nextUrl.searchParams;
  const page = searchParams.get('page') ?? '1';

  const posts = await db.post.findMany({
    skip: (parseInt(page) - 1) * 10,
    take: 10,
  });

  return NextResponse.json(posts);
}

// POST /api/posts
export async function POST(request: NextRequest) {
  const body = await request.json();

  const post = await db.post.create({
    data: {
      title: body.title,
      content: body.content,
    },
  });

  return NextResponse.json(post, { status: 201 });
}
```

**Dynamic API routes:**
```ts
// app/api/posts/[id]/route.ts
export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  const post = await db.post.findUnique({
    where: { id: parseInt(params.id) },
  });

  if (!post) {
    return NextResponse.json({ error: 'Not found' }, { status: 404 });
  }

  return NextResponse.json(post);
}

export async function DELETE(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  await db.post.delete({ where: { id: parseInt(params.id) } });
  return new NextResponse(null, { status: 204 });
}
```

---

## Part 8 — Navigation

### Link Component

```tsx
import Link from 'next/link';

// Basic link
<Link href="/about">About</Link>

// Dynamic link
<Link href={`/blog/${post.slug}`}>{post.title}</Link>

// With query params
<Link href={{ pathname: '/search', query: { q: 'nextjs' } }}>
  Search
</Link>

// Prefetch disabled (default is to prefetch in viewport)
<Link href="/heavy-page" prefetch={false}>
  Heavy Page
</Link>

// Replace (go back won't return to current page)
<Link href="/login" replace>Login</Link>
```

### useRouter (Programmatic Navigation)

```tsx
'use client';

import { useRouter, usePathname, useSearchParams } from 'next/navigation';

export default function Navigation() {
  const router = useRouter();
  const pathname = usePathname();   // current path: "/dashboard"
  const searchParams = useSearchParams(); // URLSearchParams object

  const handleLogin = async () => {
    await login();
    router.push('/dashboard');        // navigate programmatically
    // router.replace('/dashboard'); // replace history entry
    // router.back();                // go back
    // router.refresh();             // refresh server components
  };

  return (
    <div>
      <p>Current path: {pathname}</p>
      <button onClick={handleLogin}>Login</button>
    </div>
  );
}
```

---

## Part 9 — Metadata and SEO

```tsx
// Static metadata
export const metadata = {
  title: 'About Us',
  description: 'Learn more about our team',
  openGraph: {
    title: 'About Us',
    description: 'Learn more about our team',
    images: ['/og-image.jpg'],
  },
  twitter: {
    card: 'summary_large_image',
  },
};

// Dynamic metadata (for dynamic routes)
export async function generateMetadata({
  params,
}: {
  params: { slug: string };
}) {
  const post = await getPost(params.slug);

  return {
    title: post.title,
    description: post.excerpt,
    openGraph: {
      title: post.title,
      images: [post.coverImage],
    },
  };
}
```

---

## Part 10 — Image Optimization

```tsx
import Image from 'next/image';

// Automatic optimization: WebP conversion, lazy loading, blur placeholder
<Image
  src="/hero.jpg"
  alt="Hero image"
  width={1200}
  height={630}
  priority        // load immediately (above the fold)
/>

// Fill container (responsive)
<div className="relative h-64">
  <Image
    src="/banner.jpg"
    alt="Banner"
    fill
    className="object-cover"
  />
</div>

// Remote images (must configure next.config.js)
<Image
  src="https://images.unsplash.com/photo-..."
  alt="Remote image"
  width={400}
  height={300}
/>
```

```js
// next.config.js
module.exports = {
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'images.unsplash.com',
      },
    ],
  },
};
```

---

## Part 11 — Middleware

Runs before a request is completed. Use for auth, redirects, A/B testing.

```ts
// middleware.ts (at project root, not inside app/)
import { NextResponse } from 'next/server';
import type { NextRequest } from 'next/server';

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;

  // Check authentication for dashboard routes
  if (pathname.startsWith('/dashboard')) {
    const token = request.cookies.get('auth-token');

    if (!token) {
      return NextResponse.redirect(new URL('/login', request.url));
    }
  }

  // Add custom headers to every response
  const response = NextResponse.next();
  response.headers.set('X-Frame-Options', 'DENY');
  return response;
}

// Only run on these paths (not static files)
export const config = {
  matcher: ['/((?!_next/static|_next/image|favicon.ico).*)'],
};
```

---

## Part 12 — Environment Variables

```bash
# .env.local (never commit this)
DATABASE_URL=postgres://...
STRIPE_SECRET_KEY=sk_live_...

# .env (commit this — non-secrets only)
NEXT_PUBLIC_API_URL=https://api.myapp.com
NEXT_PUBLIC_SITE_NAME=My App
```

```ts
// Server-only (no NEXT_PUBLIC_ prefix)
const dbUrl = process.env.DATABASE_URL;  // only works in server code

// Client-accessible (must have NEXT_PUBLIC_ prefix)
const apiUrl = process.env.NEXT_PUBLIC_API_URL;  // works everywhere
```

---

## Complete Example — Blog Application

```
app/
├── layout.tsx
├── page.tsx                   ← Home page with recent posts
├── blog/
│   ├── page.tsx               ← All posts
│   └── [slug]/
│       └── page.tsx           ← Individual post
└── api/
    └── posts/
        └── route.ts           ← REST API
```

```tsx
// app/blog/page.tsx
import Link from 'next/link';

interface Post {
  id: number;
  slug: string;
  title: string;
  excerpt: string;
  date: string;
}

async function getPosts(): Promise<Post[]> {
  const res = await fetch('https://api.example.com/posts', {
    next: { revalidate: 3600 },
  });
  return res.json();
}

export const metadata = {
  title: 'Blog',
  description: 'Read our latest articles',
};

export default async function BlogPage() {
  const posts = await getPosts();

  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <h1 className="text-4xl font-bold mb-8">Blog</h1>
      <div className="grid gap-8">
        {posts.map((post) => (
          <article key={post.id} className="border rounded-lg p-6">
            <time className="text-sm text-gray-500">{post.date}</time>
            <h2 className="text-2xl font-semibold mt-1 mb-2">
              <Link
                href={`/blog/${post.slug}`}
                className="hover:text-blue-600"
              >
                {post.title}
              </Link>
            </h2>
            <p className="text-gray-600">{post.excerpt}</p>
            <Link
              href={`/blog/${post.slug}`}
              className="inline-block mt-4 text-blue-600 font-medium"
            >
              Read more →
            </Link>
          </article>
        ))}
      </div>
    </div>
  );
}
```

---

## Key Concepts Summary

```
File                Purpose
─────────────────────────────────────────────────────
page.tsx            Route page
layout.tsx          Persistent layout wrapper
loading.tsx         Automatic Suspense fallback
error.tsx           Error boundary (must be 'use client')
not-found.tsx       404 page
route.ts            API endpoint (GET, POST, PUT, DELETE)
middleware.ts       Runs before every request

Directive           Meaning
─────────────────────────────────────────────────────
(none)              Server Component (default)
'use client'        Client Component (useState, events)
'use server'        Server Action (form actions, mutations)

fetch options       Behavior
─────────────────────────────────────────────────────
(default)           Cache forever (SSG)
revalidate: N       Cache for N seconds (ISR)
cache: 'no-store'   No cache (SSR, always fresh)
tags: ['x']         Tag for on-demand revalidation
```

---

## References

- Next.js Docs — [nextjs.org/docs](https://nextjs.org/docs)
- App Router Tutorial — [nextjs.org/learn](https://nextjs.org/learn)
- React Server Components — [react.dev/blog](https://react.dev/blog/2023/03/22/react-labs-what-we-have-been-working-on-march-2023)
- Vercel Blog — [vercel.com/blog](https://vercel.com/blog)
