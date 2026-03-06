# CSS

> style everything. make it beautiful.

---

## what is CSS

CSS (Cascading Style Sheets) is the language that styles HTML. while HTML defines the structure and content, CSS controls how it looks — colors, fonts, spacing, layout, animations.

**Cascading** means styles flow down from parent to child elements, and multiple style rules can apply to the same element. when rules conflict, the browser uses specificity and order to decide which one wins.

without CSS, all web pages would look like plain text documents.

---

## how CSS works

CSS works by selecting HTML elements and applying properties to them:

```css
selector {
    property: value;
    property: value;
}
```

```css
/* this selects all p elements and makes text red */
p {
    color: red;
    font-size: 16px;
}
```

the browser reads your CSS and matches rules to elements. when multiple rules match, it determines which rule wins based on **specificity** and **order**.

---

## ways to add CSS

```html
<!-- 1. external stylesheet (best — keeps CSS separate) -->
<link rel="stylesheet" href="style.css">

<!-- 2. internal style block (okay for small pages) -->
<style>
    body { color: red; }
</style>

<!-- 3. inline style (avoid — hard to maintain) -->
<p style="color: red; font-size: 16px;">text</p>
```

always prefer external stylesheets. they can be cached by the browser, reused across pages, and are much easier to maintain.

---

## cascade, specificity and inheritance

these three concepts explain why CSS behaves the way it does.

**cascade** — when two rules have the same specificity, the one that appears LATER in the file wins:
```css
p { color: red; }
p { color: blue; }  /* this wins — blue */
```

**specificity** — more specific selectors beat less specific ones:
```
inline style       → 1000 points
id selector        → 100 points
class selector     → 10 points
element selector   → 1 point
```

```css
p              { color: red; }   /* 1 point */
.text          { color: blue; }  /* 10 points — wins */
#main          { color: green; } /* 100 points */
style=""       { color: pink; }  /* 1000 points */
```

**inheritance** — some properties automatically pass from parent to child:
```css
/* these inherit: color, font-size, font-family, line-height */
/* these don't inherit: margin, padding, border, background */

body {
    color: #333;           /* all text in body inherits this */
    font-family: Inter;    /* all text inherits this */
}
```

---

## selectors

selectors target which HTML elements to style.

```css
/* element */
p { }
h1 { }
button { }

/* class (.) */
.card { }
.btn-primary { }

/* id (#) — unique, only one per page */
#header { }
#main-content { }

/* multiple elements */
h1, h2, h3 { }

/* descendant — any p inside .card */
.card p { }

/* direct child — only p that is direct child of .card */
.card > p { }

/* adjacent sibling — p immediately after h1 */
h1 + p { }

/* all siblings — all p after h1 */
h1 ~ p { }

/* attribute */
input[type="email"] { }
a[href^="https"] { }   /* starts with */
a[href$=".pdf"] { }    /* ends with */
a[href*="google"] { }  /* contains */

/* pseudo-classes — state of element */
a:hover { }            /* mouse over */
a:active { }           /* being clicked */
a:visited { }          /* visited link */
input:focus { }        /* has keyboard focus */
input:disabled { }     /* disabled input */
input:checked { }      /* checked checkbox */
li:first-child { }     /* first child */
li:last-child { }      /* last child */
li:nth-child(2) { }    /* second child */
li:nth-child(odd) { }  /* odd children */
li:nth-child(even) { } /* even children */
p:not(.special) { }    /* not matching */

/* pseudo-elements — part of element */
p::first-line { }      /* first line of text */
p::first-letter { }    /* first letter */
.card::before { }      /* inserts content before */
.card::after { }       /* inserts content after */
```

---

## the box model

every HTML element is a rectangular box. understanding the box model is essential for controlling spacing and layout.

```
┌─────────────────────────────┐
│           margin            │  space outside the border
│  ┌───────────────────────┐  │
│  │        border         │  │  the visible border line
│  │  ┌─────────────────┐  │  │
│  │  │     padding     │  │  │  space inside the border
│  │  │  ┌───────────┐  │  │  │
│  │  │  │  content  │  │  │  │  actual content area
│  │  │  └───────────┘  │  │  │
│  │  └─────────────────┘  │  │
│  └───────────────────────┘  │
└─────────────────────────────┘
```

```css
/* always add this at the top of your CSS */
* {
    box-sizing: border-box;
}
```

**why box-sizing: border-box?** by default (content-box), if you set `width: 300px` and add `padding: 20px`, the element becomes 340px wide. with border-box, padding is included in the width — element stays 300px. much more predictable.

```css
.box {
    width: 300px;
    height: 200px;
    padding: 20px;               /* all sides */
    padding: 10px 20px;          /* top/bottom  left/right */
    padding: 5px 10px 15px 20px; /* top right bottom left */
    margin: 20px auto;           /* center horizontally */
    border: 2px solid #333;
    border-radius: 8px;          /* rounded corners */
}
```

**margin auto trick** — `margin: 0 auto` centers a block element horizontally (element must have a width).

**margin collapse** — vertical margins between elements collapse into one. if one element has `margin-bottom: 20px` and the next has `margin-top: 30px`, the space between them is 30px (not 50px).

---

## colors

```css
color: red;                      /* named color */
color: #ff0000;                  /* hex */
color: #f00;                     /* shorthand hex */
color: rgb(255, 0, 0);           /* rgb */
color: rgba(255, 0, 0, 0.5);     /* rgba with opacity */
color: hsl(0, 100%, 50%);        /* hsl */
color: hsla(0, 100%, 50%, 0.5);  /* hsla */
color: oklch(0.7 0.2 30);        /* oklch — modern, perceptually uniform */
```

**HSL is great for theming** — Hue (0-360 color wheel), Saturation (0-100%), Lightness (0-100%). easy to create variations:
```css
--primary-light: hsl(210, 100%, 70%);
--primary:       hsl(210, 100%, 50%);
--primary-dark:  hsl(210, 100%, 30%);
```

---

## typography

```css
font-family: 'Inter', sans-serif;
font-size: 16px;
font-size: 1rem;           /* relative to root font size (default 16px) */
font-size: 1.5em;          /* relative to parent font size */
font-size: clamp(1rem, 2vw, 1.5rem);  /* responsive font size */

font-weight: 400;          /* normal */
font-weight: 700;          /* bold */
font-style: italic;
font-style: normal;

line-height: 1.6;          /* unitless — relative to font size (best practice) */
letter-spacing: 0.05em;
word-spacing: 0.1em;

text-align: left | center | right | justify;
text-decoration: none | underline | line-through;
text-transform: uppercase | lowercase | capitalize;
text-indent: 2em;

/* truncate with ellipsis */
white-space: nowrap;
overflow: hidden;
text-overflow: ellipsis;

/* multi-line clamp */
display: -webkit-box;
-webkit-line-clamp: 3;
-webkit-box-orient: vertical;
overflow: hidden;
```

**rem vs em vs px:**
- px: fixed, not affected by user preferences
- em: relative to parent element (compounds in nested elements)
- rem: relative to root (html) font size — best for most use cases

---

## display

display controls how an element is laid out in the flow of the page.

```css
display: block;        /* full width, starts on new line (div, p, h1) */
display: inline;       /* flows with text, no width/height control (span, a) */
display: inline-block; /* inline but you can set width/height */
display: none;         /* completely hidden, takes no space */
display: flex;         /* flexbox container */
display: grid;         /* grid container */
display: contents;     /* element disappears, children stay */
```

**visibility: hidden** hides element but keeps its space. **display: none** removes it entirely.

---

## flexbox

flexbox is a one-dimensional layout system — it works along either a row OR a column. great for components, navigation bars, centering things.

the key concept: you define a **flex container** and its children become **flex items**.

```css
.container {
    display: flex;

    /* direction of main axis */
    flex-direction: row;            /* left to right (default) */
    flex-direction: column;         /* top to bottom */
    flex-direction: row-reverse;    /* right to left */

    /* alignment along main axis */
    justify-content: flex-start;    /* pack to start (default) */
    justify-content: flex-end;      /* pack to end */
    justify-content: center;        /* center */
    justify-content: space-between; /* space between items */
    justify-content: space-around;  /* equal space around items */
    justify-content: space-evenly;  /* equal space everywhere */

    /* alignment along cross axis */
    align-items: stretch;           /* fill container height (default) */
    align-items: flex-start;        /* align to start */
    align-items: flex-end;          /* align to end */
    align-items: center;            /* center vertically */
    align-items: baseline;          /* align text baselines */

    /* wrapping */
    flex-wrap: nowrap;              /* don't wrap (default) */
    flex-wrap: wrap;                /* wrap to next line */

    /* gap between items */
    gap: 16px;
    gap: 16px 8px;                  /* row-gap column-gap */
}

.item {
    flex: 1;                        /* grow to fill available space */
    flex: 0 0 200px;                /* fixed 200px, don't grow or shrink */
    flex-grow: 1;                   /* allow growing */
    flex-shrink: 0;                 /* prevent shrinking */
    flex-basis: 200px;              /* initial size */
    align-self: center;             /* override container's align-items */
    order: 2;                       /* change visual order */
}
```

**common patterns:**

```css
/* center anything */
.center {
    display: flex;
    justify-content: center;
    align-items: center;
}

/* navbar with logo left, links right */
.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

/* equal width columns */
.columns { display: flex; gap: 20px; }
.col { flex: 1; }

/* push last item to end */
.menu { display: flex; }
.menu .last { margin-left: auto; }
```

---

## grid

CSS Grid is a two-dimensional layout system — it works with rows AND columns simultaneously. great for full page layouts.

```css
.container {
    display: grid;

    /* define columns */
    grid-template-columns: 200px 1fr 1fr;        /* fixed + two flexible */
    grid-template-columns: repeat(3, 1fr);        /* three equal columns */
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); /* responsive */

    /* define rows */
    grid-template-rows: 60px 1fr auto;

    /* gap */
    gap: 20px;
    row-gap: 10px;
    column-gap: 20px;
}

.item {
    grid-column: 1 / 3;     /* start at column 1, end at column 3 */
    grid-column: span 2;    /* span 2 columns */
    grid-row: 1 / 2;
    grid-area: header;      /* named area */
}

/* named grid areas */
.layout {
    display: grid;
    grid-template-areas:
        "header header header"
        "sidebar main main"
        "footer footer footer";
    grid-template-columns: 250px 1fr 1fr;
}

.header  { grid-area: header; }
.sidebar { grid-area: sidebar; }
.main    { grid-area: main; }
.footer  { grid-area: footer; }
```

**fr unit** — fraction of available space. `1fr 2fr` means first column gets 1/3, second gets 2/3.

**auto-fill vs auto-fit:**
- auto-fill: creates as many columns as fit, empty columns still exist
- auto-fit: creates as many columns as fit, empty columns collapse

---

## positioning

```css
position: static;    /* default, follows normal document flow */
position: relative;  /* offset from where it would normally be */
position: absolute;  /* positioned relative to nearest positioned ancestor */
position: fixed;     /* fixed to viewport, stays when scrolling */
position: sticky;    /* relative until scroll threshold, then fixed */

/* used with non-static positioning */
top: 0;
right: 0;
bottom: 0;
left: 0;
z-index: 100;        /* stacking order — higher is on top */
```

**absolute positioning** — the element is removed from normal flow and positioned relative to nearest ancestor that has `position: relative` (or the page if none). great for overlays, badges, tooltips.

```css
/* badge on a card */
.card { position: relative; }
.badge {
    position: absolute;
    top: 8px;
    right: 8px;
}
```

**sticky** — acts relative until you scroll to it, then becomes fixed:
```css
.sticky-header {
    position: sticky;
    top: 0;              /* sticks when reaching top of viewport */
    z-index: 100;
}
```

---

## responsive design

making your site look good on all screen sizes — phones, tablets, desktops.

**mobile-first approach** — design for mobile first, then add styles for larger screens:

```css
/* base styles (mobile) */
.container {
    padding: 0 16px;
}

/* tablet and up */
@media (min-width: 768px) {
    .container {
        max-width: 768px;
        margin: 0 auto;
        padding: 0 24px;
    }
}

/* desktop and up */
@media (min-width: 1024px) {
    .container {
        max-width: 1200px;
    }
}
```

**common breakpoints:**
```css
/* small phones */
@media (max-width: 480px) { }

/* tablets */
@media (min-width: 768px) { }

/* laptops */
@media (min-width: 1024px) { }

/* large screens */
@media (min-width: 1280px) { }

/* dark mode */
@media (prefers-color-scheme: dark) { }

/* reduced motion */
@media (prefers-reduced-motion: reduce) { }
```

---

## CSS variables (custom properties)

store values you reuse throughout your CSS:

```css
:root {
    --primary: #3b82f6;
    --primary-dark: #1d4ed8;
    --bg: #0f172a;
    --text: #e2e8f0;
    --border: #1e293b;
    --radius: 8px;
    --shadow: 0 4px 6px rgba(0,0,0,0.1);
    --font: 'Inter', sans-serif;
    --font-mono: 'Fira Code', monospace;
}

.button {
    background: var(--primary);
    border-radius: var(--radius);
    box-shadow: var(--shadow);
}

.button:hover {
    background: var(--primary-dark);
}

/* override for dark theme */
[data-theme="dark"] {
    --bg: #000;
    --text: #fff;
}
```

---

## transitions and animations

```css
/* transition — smooth change between two states */
.button {
    background: blue;
    transform: scale(1);
    transition: background 0.3s ease, transform 0.2s ease;
    /* property  duration  easing */
}

.button:hover {
    background: darkblue;
    transform: scale(1.05);
}

/* transition all properties */
.card {
    transition: all 0.2s ease-in-out;
}

/* easing functions */
transition: ... ease;          /* slow start and end */
transition: ... linear;        /* constant speed */
transition: ... ease-in;       /* slow start */
transition: ... ease-out;      /* slow end */
transition: ... ease-in-out;   /* slow start and end */
transition: ... cubic-bezier(0.4, 0, 0.2, 1); /* custom */

/* keyframe animations */
@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

@keyframes spin {
    to { transform: rotate(360deg); }
}

@keyframes pulse {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.5; }
}

.card {
    animation: fadeIn 0.3s ease forwards;
}

.loader {
    animation: spin 1s linear infinite;
}

.skeleton {
    animation: pulse 1.5s ease-in-out infinite;
}
```

---

## transforms

move, scale, rotate or skew elements:

```css
transform: translateX(20px);       /* move right */
transform: translateY(-10px);      /* move up */
transform: translate(20px, -10px); /* move right and up */
transform: scale(1.1);             /* scale up 10% */
transform: scaleX(2);              /* double width */
transform: rotate(45deg);          /* rotate 45 degrees */
transform: skewX(10deg);           /* skew */

/* combine multiple transforms */
transform: translateY(-4px) scale(1.02) rotate(2deg);

/* 3D transforms */
transform: rotateX(10deg);
transform: perspective(1000px) rotateY(15deg);
```

---

## shadows

```css
/* box shadow */
box-shadow: 0 1px 3px rgba(0,0,0,0.12);
box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
box-shadow: inset 0 2px 4px rgba(0,0,0,0.1);  /* inset shadow */

/* text shadow */
text-shadow: 0 1px 2px rgba(0,0,0,0.5);
text-shadow: 2px 2px 0 #000;  /* hard shadow */

/* drop shadow filter (works on transparent PNGs) */
filter: drop-shadow(0 4px 6px rgba(0,0,0,0.3));
```

---

## backgrounds

```css
background-color: #111;
background-image: url('image.jpg');
background-size: cover;       /* cover entire element */
background-size: contain;     /* fit within element */
background-position: center;
background-repeat: no-repeat;
background-attachment: fixed; /* parallax effect */

/* gradients */
background: linear-gradient(to right, #000, #fff);
background: linear-gradient(135deg, #667eea, #764ba2);
background: radial-gradient(circle at center, #000, #fff);

/* multiple backgrounds */
background:
    url('top.png') top center no-repeat,
    url('bottom.png') bottom center no-repeat,
    #111;

/* shorthand */
background: #111 url('bg.jpg') center/cover no-repeat;
```

---

## useful utilities

```css
/* prevent text selection */
user-select: none;

/* pointer cursor */
cursor: pointer;
cursor: not-allowed;
cursor: grab;

/* smooth scroll */
html { scroll-behavior: smooth; }

/* aspect ratio */
.thumbnail {
    aspect-ratio: 16 / 9;
    object-fit: cover;
}

/* custom scrollbar */
::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: #111; }
::-webkit-scrollbar-thumb { background: #333; border-radius: 3px; }

/* selection color */
::selection { background: #3b82f6; color: white; }

/* filter effects */
filter: blur(4px);
filter: brightness(0.8);
filter: grayscale(100%);
filter: opacity(0.5);
filter: contrast(1.2);

/* mix blend mode */
mix-blend-mode: multiply;
mix-blend-mode: screen;
mix-blend-mode: overlay;

/* clip path */
clip-path: circle(50%);
clip-path: polygon(0 0, 100% 0, 100% 80%, 0 100%);
```

---

```
=^._.^= style with purpose
```
