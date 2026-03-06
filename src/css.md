# CSS

> style everything. make it beautiful.

---

## ways to add CSS

```html
<!-- external (best) -->
<link rel="stylesheet" href="style.css">

<!-- internal -->
<style>
    body { color: red; }
</style>

<!-- inline (avoid) -->
<p style="color: red;">text</p>
```

---

## selectors

```css
/* element */
p { color: red; }

/* class */
.card { background: white; }

/* id */
#header { height: 60px; }

/* multiple */
h1, h2, h3 { font-weight: bold; }

/* descendant */
.card p { font-size: 14px; }

/* direct child */
.nav > li { display: inline; }

/* adjacent sibling */
h1 + p { margin-top: 0; }

/* attribute */
input[type="email"] { border: 1px solid blue; }

/* pseudo-class */
a:hover { color: red; }
li:first-child { font-weight: bold; }
li:last-child { border: none; }
li:nth-child(2) { color: blue; }
input:focus { outline: 2px solid blue; }
button:disabled { opacity: 0.5; }

/* pseudo-element */
p::first-line { font-weight: bold; }
.card::before { content: "★"; }
.card::after { content: ""; }
```

---

## box model

```
┌─────────────────────────┐
│         margin          │
│  ┌───────────────────┐  │
│  │      border       │  │
│  │  ┌─────────────┐  │  │
│  │  │   padding   │  │  │
│  │  │  ┌───────┐  │  │  │
│  │  │  │content│  │  │  │
│  │  │  └───────┘  │  │  │
│  │  └─────────────┘  │  │
│  └───────────────────┘  │
└─────────────────────────┘
```

```css
/* box sizing — always add this */
* {
    box-sizing: border-box;
}

.box {
    width: 300px;
    height: 200px;
    padding: 20px;           /* all sides */
    padding: 10px 20px;      /* top/bottom left/right */
    padding: 5px 10px 15px 20px; /* top right bottom left */
    margin: 20px auto;       /* center horizontally */
    border: 1px solid black;
    border-radius: 8px;      /* rounded corners */
}
```

---

## colors

```css
color: red;                  /* named */
color: #ff0000;              /* hex */
color: #f00;                 /* shorthand hex */
color: rgb(255, 0, 0);       /* rgb */
color: rgba(255, 0, 0, 0.5); /* rgba with opacity */
color: hsl(0, 100%, 50%);    /* hsl */
color: hsla(0, 100%, 50%, 0.5); /* hsla */
```

---

## typography

```css
font-family: 'Inter', sans-serif;
font-size: 16px;
font-size: 1rem;        /* relative to root (16px) */
font-size: 1.5em;       /* relative to parent */
font-weight: 400;       /* normal */
font-weight: 700;       /* bold */
font-style: italic;
line-height: 1.6;
letter-spacing: 0.05em;
text-align: left | center | right | justify;
text-decoration: none | underline | line-through;
text-transform: uppercase | lowercase | capitalize;
white-space: nowrap;    /* no wrapping */
overflow: hidden;
text-overflow: ellipsis; /* truncate with ... */
```

---

## display

```css
display: block;         /* full width, new line */
display: inline;        /* inline, no width/height */
display: inline-block;  /* inline but has width/height */
display: none;          /* hidden, no space */
visibility: hidden;     /* hidden, keeps space */
display: flex;          /* flexbox */
display: grid;          /* grid */
```

---

## flexbox

```css
.container {
    display: flex;
    flex-direction: row | column | row-reverse | column-reverse;
    justify-content: flex-start | flex-end | center | space-between | space-around | space-evenly;
    align-items: stretch | flex-start | flex-end | center | baseline;
    flex-wrap: nowrap | wrap;
    gap: 16px;
    gap: 16px 8px; /* row-gap column-gap */
}

.item {
    flex: 1;           /* grow and fill space */
    flex: 0 0 200px;   /* fixed width */
    align-self: center; /* override parent align-items */
    order: 2;          /* change order */
}
```

**common flex patterns:**
```css
/* center everything */
.center {
    display: flex;
    justify-content: center;
    align-items: center;
}

/* space between navbar items */
.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* equal columns */
.columns {
    display: flex;
    gap: 20px;
}
.col { flex: 1; }
```

---

## grid

```css
.container {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;       /* 3 equal columns */
    grid-template-columns: repeat(3, 1fr);    /* same */
    grid-template-columns: 200px 1fr;         /* fixed + flexible */
    grid-template-rows: auto;
    gap: 20px;
}

.item {
    grid-column: 1 / 3;   /* span 2 columns */
    grid-row: 1 / 2;
    grid-column: span 2;  /* span 2 from current position */
}
```

**common grid patterns:**
```css
/* responsive card grid */
.cards {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 20px;
}

/* layout with sidebar */
.layout {
    display: grid;
    grid-template-columns: 250px 1fr;
    gap: 24px;
}
```

---

## positioning

```css
position: static;    /* default, normal flow */
position: relative;  /* offset from normal position */
position: absolute;  /* relative to nearest positioned parent */
position: fixed;     /* fixed to viewport */
position: sticky;    /* sticks when scrolling */

/* used with position (not static) */
top: 0;
right: 0;
bottom: 0;
left: 0;
z-index: 100;        /* stacking order */
```

---

## responsive design

```css
/* mobile first approach */
.container {
    width: 100%;
    padding: 0 16px;
}

/* tablet */
@media (min-width: 768px) {
    .container {
        max-width: 768px;
        margin: 0 auto;
    }
}

/* desktop */
@media (min-width: 1024px) {
    .container {
        max-width: 1200px;
    }
}

/* common breakpoints */
/* sm: 640px, md: 768px, lg: 1024px, xl: 1280px */
```

---

## CSS variables

```css
:root {
    --primary: #10b981;
    --bg: #111111;
    --text: #e0e0e0;
    --border: #222222;
    --radius: 8px;
    --font: 'Inter', sans-serif;
}

.button {
    background: var(--primary);
    border-radius: var(--radius);
    font-family: var(--font);
}

/* override in component */
.dark-card {
    --bg: #000000;
    background: var(--bg);
}
```

---

## transitions and animations

```css
/* transition */
.button {
    background: blue;
    transition: background 0.3s ease;
    transition: all 0.2s ease-in-out;
}

.button:hover {
    background: darkblue;
}

/* animation */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to   { opacity: 1; transform: translateY(0); }
}

.card {
    animation: fadeIn 0.3s ease forwards;
}

/* spin */
@keyframes spin {
    to { transform: rotate(360deg); }
}

.loader {
    animation: spin 1s linear infinite;
}
```

---

## transforms

```css
transform: translateX(20px);
transform: translateY(-10px);
transform: translate(20px, -10px);
transform: scale(1.1);
transform: rotate(45deg);
transform: skew(10deg);

/* combine */
transform: translateY(-2px) scale(1.02);
```

---

## shadows

```css
/* box shadow */
box-shadow: 0 1px 3px rgba(0,0,0,0.1);
box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
box-shadow: inset 0 2px 4px rgba(0,0,0,0.1); /* inset */

/* text shadow */
text-shadow: 0 1px 2px rgba(0,0,0,0.5);
```

---

## backgrounds

```css
background-color: #111;
background-image: url('image.jpg');
background-size: cover | contain | 100%;
background-position: center;
background-repeat: no-repeat;

/* gradient */
background: linear-gradient(to right, #000, #fff);
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
background: radial-gradient(circle, #000, #fff);

/* shorthand */
background: #111 url('bg.jpg') center/cover no-repeat;
```

---

## overflow

```css
overflow: visible | hidden | scroll | auto;
overflow-x: hidden;
overflow-y: auto;

/* truncate text */
.truncate {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

/* multi line truncate */
.clamp {
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
}
```

---

## useful utilities

```css
/* full screen section */
.hero {
    min-height: 100vh;
    display: flex;
    align-items: center;
}

/* aspect ratio */
.thumbnail {
    aspect-ratio: 16 / 9;
    object-fit: cover;
}

/* smooth scroll */
html {
    scroll-behavior: smooth;
}

/* custom scrollbar */
::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: #111; }
::-webkit-scrollbar-thumb { background: #333; border-radius: 3px; }

/* select text color */
::selection { background: #10b981; color: white; }

/* disable text selection */
.no-select { user-select: none; }

/* cursor */
.clickable { cursor: pointer; }
```

---

```
=^._.^= style with purpose
```
