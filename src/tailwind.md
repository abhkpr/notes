# Tailwind CSS

## What is Tailwind?

Tailwind CSS is a utility-first CSS framework. Instead of writing CSS classes like `.card`, `.button`, or `.hero`, you compose designs directly in your HTML using small, single-purpose utility classes like `flex`, `p-4`, `text-blue-500`, and `rounded-lg`.

**Real-world analogy:** Traditional CSS is like buying pre-made furniture — you get a chair that looks a certain way, and customizing it is hard work. Tailwind is like having a workshop full of tools and raw materials. You build exactly the chair you want, piece by piece. More work upfront to learn the tools, but infinite flexibility once you know them.

**Why Tailwind?**
- No switching between HTML and CSS files — everything in one place
- No naming things (the hardest problem in CSS)
- No dead CSS — only classes you use are in the final bundle
- Consistent design system built in (spacing, colors, type scale)
- Rapid prototyping and iteration

---

## Part 1 — Installation

### In a Next.js project (automatic)

```bash
# When creating a Next.js app, choose Yes for Tailwind CSS
npx create-next-app@latest my-app
# ✓ Would you like to use Tailwind CSS? Yes
```

### Manual installation

```bash
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

# tailwind.config.ts is created
```

```ts
// tailwind.config.ts
import type { Config } from 'tailwindcss';

const config: Config = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
export default config;
```

```css
/* app/globals.css */
@tailwind base;       /* Normalize/reset styles */
@tailwind components; /* Component classes (rare) */
@tailwind utilities;  /* All utility classes */
```

---

## Part 2 — Core Concepts

### Utility-First Mindset

```html
<!-- Traditional CSS approach -->
<div class="card">
  <h2 class="card-title">Hello</h2>
</div>

<style>
  .card {
    background: white;
    padding: 1rem;
    border-radius: 0.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  }
  .card-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #111;
  }
</style>
```

```html
<!-- Tailwind approach — no separate CSS file -->
<div class="bg-white p-4 rounded-lg shadow">
  <h2 class="text-xl font-semibold text-gray-900">Hello</h2>
</div>
```

### The Design System

Tailwind uses consistent scales. Numbers mean the same thing everywhere:

```
Spacing scale:
  p-0  = padding: 0
  p-1  = padding: 0.25rem (4px)
  p-2  = padding: 0.5rem  (8px)
  p-4  = padding: 1rem    (16px)
  p-8  = padding: 2rem    (32px)
  p-16 = padding: 4rem    (64px)

Same scale for:
  m-4   (margin)
  gap-4 (flex/grid gap)
  space-x-4 (horizontal spacing between children)
  w-4   (width: 1rem)
  h-4   (height: 1rem)
  top-4 (top: 1rem)
```

---

## Part 3 — Layout

### Flexbox

```tsx
// Center content
<div className="flex items-center justify-center h-screen">
  <p>Centered!</p>
</div>

// Horizontal navbar
<nav className="flex items-center justify-between px-6 py-4">
  <span className="font-bold text-xl">Logo</span>
  <div className="flex gap-6">
    <a href="/">Home</a>
    <a href="/about">About</a>
    <a href="/blog">Blog</a>
  </div>
</nav>

// Card row that wraps
<div className="flex flex-wrap gap-4">
  <div className="flex-1 min-w-64">Card 1</div>
  <div className="flex-1 min-w-64">Card 2</div>
  <div className="flex-1 min-w-64">Card 3</div>
</div>

// Sidebar layout
<div className="flex min-h-screen">
  <aside className="w-64 shrink-0 bg-gray-900">Sidebar</aside>
  <main className="flex-1 p-8">Content</main>
</div>
```

**Flex utilities:**
```
Flexbox classes:
  flex             display: flex
  flex-col         flex-direction: column
  flex-row         flex-direction: row (default)
  flex-wrap        flex-wrap: wrap
  flex-1           flex: 1 1 0% (grow and shrink)
  shrink-0         flex-shrink: 0 (don't shrink)
  grow             flex-grow: 1

Alignment:
  items-start      align-items: flex-start
  items-center     align-items: center
  items-end        align-items: flex-end

Justification:
  justify-start    justify-content: flex-start
  justify-center   justify-content: center
  justify-end      justify-content: flex-end
  justify-between  justify-content: space-between
  justify-around   justify-content: space-around
```

### Grid

```tsx
// Basic grid
<div className="grid grid-cols-3 gap-6">
  <div>Column 1</div>
  <div>Column 2</div>
  <div>Column 3</div>
</div>

// Auto-fill responsive grid (cards)
<div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
  {items.map(item => <Card key={item.id} {...item} />)}
</div>

// Named grid areas
<div className="grid grid-cols-[250px_1fr] grid-rows-[auto_1fr_auto] min-h-screen">
  <header className="col-span-2 bg-white border-b px-6 py-4">Header</header>
  <aside className="bg-gray-50 p-4">Sidebar</aside>
  <main className="p-8">Main content</main>
  <footer className="col-span-2 bg-gray-800 text-white px-6 py-4">Footer</footer>
</div>

// Spanning columns
<div className="grid grid-cols-4 gap-4">
  <div className="col-span-3">Wide</div>  {/* spans 3 columns */}
  <div className="col-span-1">Narrow</div>
  <div className="col-span-4">Full width</div>
</div>
```

---

## Part 4 — Typography

```tsx
// Font sizes
<h1 className="text-5xl">Huge heading</h1>
<h2 className="text-3xl">Large heading</h2>
<h3 className="text-xl">Medium heading</h3>
<p  className="text-base">Normal text (16px)</p>
<p  className="text-sm">Small text (14px)</p>
<p  className="text-xs">Tiny text (12px)</p>

// Font weight
<p className="font-thin">100</p>
<p className="font-light">300</p>
<p className="font-normal">400</p>
<p className="font-medium">500</p>
<p className="font-semibold">600</p>
<p className="font-bold">700</p>
<p className="font-extrabold">800</p>

// Text colors
<p className="text-gray-900">Almost black</p>
<p className="text-gray-600">Medium gray</p>
<p className="text-gray-400">Light gray</p>
<p className="text-blue-600">Blue</p>
<p className="text-red-500">Error red</p>
<p className="text-green-600">Success green</p>

// Text alignment and decoration
<p className="text-center">Centered</p>
<p className="text-right">Right aligned</p>
<p className="underline">Underlined</p>
<p className="line-through">Strikethrough</p>
<p className="uppercase tracking-widest">SPACED CAPS</p>
<p className="capitalize">capitalizes first letter</p>

// Line height and letter spacing
<p className="leading-tight">Tight line height</p>
<p className="leading-relaxed">Relaxed line height</p>
<p className="tracking-tight">Tight letter spacing</p>
<p className="tracking-wide">Wide letter spacing</p>

// Truncate long text
<p className="truncate w-48">Very long text that gets cut off...</p>
<p className="line-clamp-3">Text that shows max 3 lines...</p>
```

---

## Part 5 — Colors

### Color Palette

Tailwind ships with a full color palette. Every color has shades 50–950.

```
Color families:
  slate, gray, zinc, neutral, stone (grays)
  red, orange, amber, yellow
  lime, green, emerald, teal
  cyan, sky, blue, indigo, violet
  purple, fuchsia, pink, rose

Shade scale (lighter → darker):
  50 → 100 → 200 → 300 → 400 → 500 → 600 → 700 → 800 → 900 → 950
```

```tsx
// Background colors
<div className="bg-white">White</div>
<div className="bg-gray-50">Off-white</div>
<div className="bg-gray-900">Dark</div>
<div className="bg-blue-500">Blue</div>
<div className="bg-blue-600">Darker blue</div>
<div className="bg-gradient-to-r from-blue-500 to-purple-600">Gradient</div>

// Text colors
<p className="text-blue-600">Blue text</p>
<p className="text-emerald-600">Green text</p>

// Border colors
<div className="border border-gray-200">Light border</div>
<div className="border-2 border-blue-500">Blue border</div>

// Opacity
<div className="bg-blue-500/50">50% opacity blue background</div>
<p className="text-gray-900/70">70% opacity text</p>
```

---

## Part 6 — Spacing

```tsx
// Padding
<div className="p-4">All sides: 1rem</div>
<div className="px-6 py-3">Horizontal 1.5rem, vertical 0.75rem</div>
<div className="pt-8 pb-4 pl-6 pr-6">Individual sides</div>
<div className="p-[18px]">Arbitrary: 18px</div>

// Margin
<div className="m-4">All sides</div>
<div className="mx-auto">Center horizontally</div>
<div className="mt-8 mb-4">Top/bottom only</div>
<div className="ml-auto">Push to right</div>

// Gap (flex/grid)
<div className="flex gap-4">Uniform gap: 1rem</div>
<div className="flex gap-x-6 gap-y-2">Different horizontal/vertical</div>

// Space between (adds margin to children)
<div className="flex flex-col space-y-4">
  <div>Item 1</div>
  <div>Item 2</div>
  <div>Item 3</div>
</div>
```

---

## Part 7 — Responsive Design

Tailwind is mobile-first. Classes apply at the given breakpoint AND ABOVE.

```
Breakpoints:
  sm:   640px+   (small tablets)
  md:   768px+   (tablets)
  lg:   1024px+  (laptops)
  xl:   1280px+  (desktops)
  2xl:  1536px+  (large desktops)
```

```tsx
// Mobile-first responsive layout
<div className="
  grid
  grid-cols-1      // mobile: 1 column
  sm:grid-cols-2   // tablet: 2 columns
  lg:grid-cols-4   // desktop: 4 columns
  gap-4
">
  ...
</div>

// Hide/show at different breakpoints
<div className="hidden md:block">Only visible on desktop+</div>
<div className="block md:hidden">Only visible on mobile</div>

// Responsive typography
<h1 className="text-2xl sm:text-4xl lg:text-6xl font-bold">
  Big Heading
</h1>

// Responsive spacing
<div className="p-4 md:p-8 lg:p-12">
  Padding grows with screen size
</div>

// Complete responsive card grid example
<section className="px-4 sm:px-6 lg:px-8 py-12">
  <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 max-w-7xl mx-auto">
    {cards.map(card => (
      <div key={card.id} className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
        <img src={card.image} className="w-full h-48 object-cover rounded-lg mb-4" />
        <h3 className="text-lg font-semibold text-gray-900">{card.title}</h3>
        <p className="text-gray-600 mt-2 text-sm">{card.description}</p>
      </div>
    ))}
  </div>
</section>
```

---

## Part 8 — States and Variants

```tsx
// Hover
<button className="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded">
  Hover me
</button>

// Focus
<input className="border border-gray-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 focus:outline-none rounded px-3 py-2" />

// Active (while clicked)
<button className="bg-blue-500 active:bg-blue-700 text-white px-4 py-2 rounded">
  Click me
</button>

// Disabled
<button className="bg-blue-500 disabled:opacity-50 disabled:cursor-not-allowed text-white px-4 py-2 rounded" disabled>
  Disabled
</button>

// Dark mode
<div className="bg-white dark:bg-gray-900 text-gray-900 dark:text-white">
  Adapts to system dark mode
</div>

// Group (parent state affects children)
<div className="group flex items-center gap-3 p-4 hover:bg-gray-50 rounded-lg cursor-pointer">
  <div className="w-10 h-10 rounded-full bg-gray-200 group-hover:bg-blue-100" />
  <span className="font-medium group-hover:text-blue-600">Hover the row</span>
  <svg className="ml-auto opacity-0 group-hover:opacity-100" />
</div>

// Peer (sibling state)
<input type="checkbox" className="peer" id="toggle" />
<label
  htmlFor="toggle"
  className="peer-checked:text-blue-600 peer-checked:font-bold"
>
  Check the checkbox to bold me
</label>

// First, last, odd, even
<ul>
  {items.map((item, i) => (
    <li
      key={i}
      className="p-4 first:rounded-t-lg last:rounded-b-lg odd:bg-gray-50 even:bg-white border-b last:border-b-0"
    >
      {item}
    </li>
  ))}
</ul>
```

---

## Part 9 — Borders, Shadows, Effects

```tsx
// Borders
<div className="border">1px border (gray)</div>
<div className="border-2 border-blue-500">2px blue border</div>
<div className="border-t border-gray-200">Top border only</div>
<div className="border border-dashed border-gray-300">Dashed</div>
<div className="divide-y divide-gray-100">   {/* divides children */}
  <div className="py-3">Item 1</div>
  <div className="py-3">Item 2</div>
</div>

// Border radius
<div className="rounded">Small radius (4px)</div>
<div className="rounded-lg">Large radius (8px)</div>
<div className="rounded-xl">Extra large (12px)</div>
<div className="rounded-2xl">2xl (16px)</div>
<div className="rounded-full">Circle/pill</div>
<div className="rounded-t-xl rounded-b-none">Top only</div>

// Shadows
<div className="shadow-sm">Subtle</div>
<div className="shadow">Small</div>
<div className="shadow-md">Medium</div>
<div className="shadow-lg">Large</div>
<div className="shadow-xl">Extra large</div>
<div className="shadow-2xl">2xl</div>
<div className="shadow-none">None</div>
<div className="shadow-blue-500/20 shadow-lg">Colored shadow</div>

// Opacity and blur
<div className="opacity-50">50% transparent</div>
<div className="blur-sm">Blurred</div>
<div className="backdrop-blur-md bg-white/80">Glass effect</div>
```

---

## Part 10 — Custom Configuration

```ts
// tailwind.config.ts
import type { Config } from 'tailwindcss';

const config: Config = {
  content: ['./app/**/*.{ts,tsx}', './components/**/*.{ts,tsx}'],
  theme: {
    extend: {
      // Custom colors
      colors: {
        brand: {
          50:  '#eff6ff',
          100: '#dbeafe',
          500: '#3b82f6',
          900: '#1e3a8a',
        },
        accent: '#ff6b6b',
      },

      // Custom fonts
      fontFamily: {
        sans: ['var(--font-inter)', 'system-ui', 'sans-serif'],
        mono: ['var(--font-fira-code)', 'monospace'],
      },

      // Custom spacing
      spacing: {
        '18': '4.5rem',
        '88': '22rem',
        '128': '32rem',
      },

      // Custom breakpoints
      screens: {
        'xs': '475px',
        '3xl': '1800px',
      },

      // Custom animations
      animation: {
        'fade-in': 'fadeIn 0.5s ease-out',
        'slide-up': 'slideUp 0.3s ease-out',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        slideUp: {
          '0%': { transform: 'translateY(20px)', opacity: '0' },
          '100%': { transform: 'translateY(0)', opacity: '1' },
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),  // prose class for markdown
    require('@tailwindcss/forms'),       // better form styles
  ],
};

export default config;
```

**Using custom values:**
```tsx
<div className="bg-brand-500">Custom brand color</div>
<p className="font-sans">Custom font</p>
<div className="w-88">Custom 22rem width</div>
<div className="animate-fade-in">Fades in!</div>
```

---

## Part 11 — @apply Directive

Extract repeated utility combinations into reusable classes (use sparingly).

```css
/* app/globals.css */

/* Don't overuse @apply — it defeats the purpose of utility-first */
/* Best for: base elements, not components (use React components instead) */

@layer base {
  h1 { @apply text-4xl font-bold tracking-tight text-gray-900; }
  h2 { @apply text-3xl font-semibold text-gray-800; }
  a  { @apply text-blue-600 hover:text-blue-800 underline; }
}

@layer components {
  .btn {
    @apply inline-flex items-center px-4 py-2 rounded-lg font-medium
           transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed;
  }
  .btn-primary {
    @apply btn bg-blue-600 text-white hover:bg-blue-700 focus:ring-2 focus:ring-blue-500;
  }
  .btn-ghost {
    @apply btn text-gray-700 hover:bg-gray-100;
  }
  .input {
    @apply w-full px-3 py-2 border border-gray-300 rounded-lg text-sm
           focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent;
  }
}
```

```tsx
// Now use them like regular classes
<button className="btn-primary">Submit</button>
<button className="btn-ghost">Cancel</button>
<input className="input" placeholder="Email..." />
```

---

## Part 12 — Animations and Transitions

```tsx
// Built-in transitions
<div className="transition-all duration-300 ease-in-out">Smooth all</div>
<div className="transition-colors duration-200">Color only</div>
<div className="transition-transform duration-300">Transform only</div>

// Transform utilities
<div className="hover:scale-105 transition-transform">Scale on hover</div>
<div className="hover:-translate-y-1 transition-transform">Lift on hover</div>
<div className="hover:rotate-3 transition-transform">Rotate on hover</div>

// Built-in animations
<div className="animate-spin">Spinning loader icon</div>
<div className="animate-ping">Pinging dot (notification)</div>
<div className="animate-pulse">Skeleton loading pulse</div>
<div className="animate-bounce">Bouncing arrow</div>

// Skeleton loading pattern
function Skeleton() {
  return (
    <div className="animate-pulse">
      <div className="h-6 bg-gray-200 rounded w-3/4 mb-3" />
      <div className="h-4 bg-gray-200 rounded w-full mb-2" />
      <div className="h-4 bg-gray-200 rounded w-5/6" />
    </div>
  );
}
```

---

## Part 13 — Complete UI Components

### Button Variants

```tsx
interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'secondary' | 'ghost' | 'danger';
  size?: 'sm' | 'md' | 'lg';
  loading?: boolean;
}

export function Button({
  variant = 'primary',
  size = 'md',
  loading,
  children,
  className = '',
  ...props
}: ButtonProps) {
  const base = 'inline-flex items-center justify-center font-medium rounded-lg transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed focus:outline-none focus:ring-2 focus:ring-offset-2';

  const variants = {
    primary:   'bg-blue-600 text-white hover:bg-blue-700 focus:ring-blue-500',
    secondary: 'bg-gray-100 text-gray-900 hover:bg-gray-200 focus:ring-gray-500',
    ghost:     'text-gray-700 hover:bg-gray-100 focus:ring-gray-500',
    danger:    'bg-red-600 text-white hover:bg-red-700 focus:ring-red-500',
  };

  const sizes = {
    sm: 'text-sm px-3 py-1.5',
    md: 'text-sm px-4 py-2',
    lg: 'text-base px-6 py-3',
  };

  return (
    <button
      className={`${base} ${variants[variant]} ${sizes[size]} ${className}`}
      disabled={loading || props.disabled}
      {...props}
    >
      {loading && (
        <svg className="animate-spin -ml-1 mr-2 h-4 w-4" viewBox="0 0 24 24">
          <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" fill="none" />
          <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z" />
        </svg>
      )}
      {children}
    </button>
  );
}
```

### Card Component

```tsx
export function Card({
  children,
  className = '',
  hover = false,
}: {
  children: React.ReactNode;
  className?: string;
  hover?: boolean;
}) {
  return (
    <div
      className={`
        bg-white rounded-xl border border-gray-200 shadow-sm
        ${hover ? 'hover:shadow-md hover:-translate-y-0.5 transition-all duration-200 cursor-pointer' : ''}
        ${className}
      `}
    >
      {children}
    </div>
  );
}

// Usage
<Card hover>
  <div className="p-6">
    <h3 className="text-lg font-semibold text-gray-900">Card Title</h3>
    <p className="text-gray-600 mt-1 text-sm">Card description here</p>
  </div>
</Card>
```

### Input Component

```tsx
interface InputProps extends React.InputHTMLAttributes<HTMLInputElement> {
  label?: string;
  error?: string;
  hint?: string;
}

export function Input({ label, error, hint, className = '', id, ...props }: InputProps) {
  const inputId = id || label?.toLowerCase().replace(/\s+/g, '-');

  return (
    <div className="space-y-1">
      {label && (
        <label htmlFor={inputId} className="block text-sm font-medium text-gray-700">
          {label}
        </label>
      )}
      <input
        id={inputId}
        className={`
          block w-full px-3 py-2 text-sm rounded-lg border
          transition-colors duration-200
          placeholder:text-gray-400
          focus:outline-none focus:ring-2 focus:ring-offset-0
          ${error
            ? 'border-red-300 focus:border-red-500 focus:ring-red-200 bg-red-50'
            : 'border-gray-300 focus:border-blue-500 focus:ring-blue-200'
          }
          disabled:bg-gray-50 disabled:text-gray-500 disabled:cursor-not-allowed
          ${className}
        `}
        {...props}
      />
      {error && <p className="text-xs text-red-600">{error}</p>}
      {hint && !error && <p className="text-xs text-gray-500">{hint}</p>}
    </div>
  );
}
```

### Badge/Tag Component

```tsx
type BadgeVariant = 'default' | 'success' | 'warning' | 'error' | 'info';

export function Badge({
  children,
  variant = 'default',
}: {
  children: React.ReactNode;
  variant?: BadgeVariant;
}) {
  const styles: Record<BadgeVariant, string> = {
    default: 'bg-gray-100 text-gray-700',
    success: 'bg-green-100 text-green-700',
    warning: 'bg-yellow-100 text-yellow-700',
    error:   'bg-red-100 text-red-700',
    info:    'bg-blue-100 text-blue-700',
  };

  return (
    <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${styles[variant]}`}>
      {children}
    </span>
  );
}

// Usage
<Badge variant="success">Active</Badge>
<Badge variant="error">Failed</Badge>
<Badge variant="warning">Pending</Badge>
```

### Navigation Bar

```tsx
'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';

const navLinks = [
  { href: '/', label: 'Home' },
  { href: '/about', label: 'About' },
  { href: '/blog', label: 'Blog' },
  { href: '/contact', label: 'Contact' },
];

export function Navbar() {
  const pathname = usePathname();

  return (
    <header className="sticky top-0 z-50 bg-white/80 backdrop-blur-sm border-b border-gray-200">
      <nav className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between h-16">
          {/* Logo */}
          <Link href="/" className="font-bold text-xl text-gray-900">
            MyBrand
          </Link>

          {/* Desktop links */}
          <div className="hidden md:flex items-center gap-1">
            {navLinks.map(({ href, label }) => (
              <Link
                key={href}
                href={href}
                className={`
                  px-3 py-2 rounded-md text-sm font-medium transition-colors
                  ${pathname === href
                    ? 'bg-gray-100 text-gray-900'
                    : 'text-gray-600 hover:text-gray-900 hover:bg-gray-50'
                  }
                `}
              >
                {label}
              </Link>
            ))}
          </div>

          {/* CTA */}
          <div className="flex items-center gap-3">
            <Link href="/login" className="text-sm font-medium text-gray-600 hover:text-gray-900">
              Sign in
            </Link>
            <Link
              href="/signup"
              className="bg-blue-600 text-white text-sm font-medium px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors"
            >
              Get started
            </Link>
          </div>
        </div>
      </nav>
    </header>
  );
}
```

---

## Part 14 — Dark Mode

```tsx
// tailwind.config.ts
const config: Config = {
  darkMode: 'class',  // toggle with class on <html>
  // or: 'media'      // follows system preference automatically
};
```

```tsx
// Toggle dark mode
'use client';
import { useEffect, useState } from 'react';

export function ThemeToggle() {
  const [dark, setDark] = useState(false);

  useEffect(() => {
    document.documentElement.classList.toggle('dark', dark);
  }, [dark]);

  return (
    <button
      onClick={() => setDark(!dark)}
      className="p-2 rounded-lg bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-200"
    >
      {dark ? '☀️' : '🌙'}
    </button>
  );
}
```

```tsx
// Components that support dark mode
<div className="bg-white dark:bg-gray-900">
  <h1 className="text-gray-900 dark:text-white">Heading</h1>
  <p className="text-gray-600 dark:text-gray-400">Body text</p>
  <div className="border border-gray-200 dark:border-gray-700 rounded-lg p-4">
    <span className="text-blue-600 dark:text-blue-400">Link</span>
  </div>
</div>
```

---

## Part 15 — Arbitrary Values

When you need a value not in Tailwind's scale, use square brackets.

```tsx
// Arbitrary sizes
<div className="w-[340px]">Exactly 340px wide</div>
<div className="h-[calc(100vh-64px)]">Full height minus navbar</div>
<div className="mt-[3.5rem]">Exactly 3.5rem margin</div>

// Arbitrary colors
<div className="bg-[#ff6b6b]">Custom hex color</div>
<div className="text-[rgb(100,200,50)]">Custom RGB</div>
<div className="border-[hsl(220,90%,56%)]">Custom HSL</div>

// Arbitrary grid
<div className="grid-cols-[1fr_300px_1fr]">Custom column sizes</div>
<div className="grid-rows-[auto_1fr_auto]">Custom row sizes</div>

// CSS variables
<div className="bg-[var(--brand-color)]">CSS variable</div>

// Complex values
<div className="shadow-[0_4px_20px_rgba(0,0,0,0.15)]">Custom shadow</div>
```

---

## Quick Reference

```
Layout:
  flex, grid, block, hidden, inline-flex
  flex-col, flex-row, flex-wrap
  items-center, justify-between
  grid-cols-3, gap-4, col-span-2

Sizing:
  w-full, w-screen, w-1/2, w-64, w-[340px]
  h-full, h-screen, h-16, h-px
  max-w-7xl, max-w-prose, min-h-screen

Spacing:
  p-4, px-6, py-3, pt-8
  m-4, mx-auto, mt-8, -mt-4
  gap-4, space-x-4, space-y-2

Typography:
  text-sm, text-xl, text-4xl
  font-medium, font-bold, font-mono
  text-gray-900, text-blue-600
  leading-relaxed, tracking-wide
  truncate, line-clamp-2

Visual:
  rounded-lg, rounded-full
  border, border-2, border-gray-200
  shadow-sm, shadow-lg
  bg-white, bg-blue-500
  opacity-75

States:
  hover:bg-blue-600
  focus:ring-2 focus:ring-blue-500 focus:outline-none
  dark:bg-gray-900
  disabled:opacity-50
  group, group-hover:text-blue-600

Responsive:
  sm:flex, md:grid-cols-2, lg:text-xl
  hidden md:block
```

---

## References

- Tailwind Docs — [tailwindcss.com/docs](https://tailwindcss.com/docs)
- Tailwind Play — [play.tailwindcss.com](https://play.tailwindcss.com)
- Tailwind UI (paid components) — [tailwindui.com](https://tailwindui.com)
- Headless UI (accessible components) — [headlessui.com](https://headlessui.com)
- shadcn/ui (copy-paste components) — [ui.shadcn.com](https://ui.shadcn.com)
