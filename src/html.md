# HTML

> the skeleton of the web. structure everything.

---

## what is HTML

HTML (HyperText Markup Language) is the standard language for creating web pages. it is not a programming language — it is a markup language, meaning you use tags to annotate content and tell the browser what things *are*.

**HyperText** means text that links to other text (hyperlinks). **Markup** means tags that wrap content to give it meaning.

every website you visit is built on HTML. even complex React or Angular apps ultimately produce HTML that the browser renders.

the browser reads your HTML file top to bottom and builds a visual representation — this is called **rendering**.

---

## how the browser works

when you type a URL:

```
1. DNS resolves domain to IP address
2. browser sends HTTP GET request to server
3. server sends back HTML file
4. browser parses HTML and builds DOM tree
5. browser downloads CSS and applies styles
6. browser downloads JS and executes scripts
7. page is displayed to user
```

**DOM (Document Object Model)** is the browser's in-memory tree representation of your HTML. JavaScript manipulates the DOM to change the page dynamically without reloading.

```
document
└── html
    ├── head
    │   ├── title
    │   └── link
    └── body
        ├── header
        │   └── nav
        ├── main
        │   ├── h1
        │   └── p
        └── footer
```

---

## document structure

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Title</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <!-- visible content here -->
    <script src="app.js"></script>
</body>
</html>
```

`<!DOCTYPE html>` tells browser this is HTML5. always required, always first line.

`<html lang="en">` is the root element. the lang attribute helps screen readers pronounce words correctly and helps search engines.

`<head>` is the metadata container — nothing in here is visible:
- `<title>` is the text in browser tab, used by search engines
- `<meta charset="UTF-8">` is character encoding, supports all languages
- `<meta name="viewport">` tells mobile browsers how to scale the page
- `<link rel="stylesheet">` links external CSS file
- `<script>` links JavaScript file

`<body>` contains everything the user sees.

**why put script at bottom?** HTML loads top to bottom. script in head blocks page rendering. at bottom of body, page renders first, then JS loads.

---

## elements and tags

an element is made of: opening tag + content + closing tag:

```html
<tagname attribute="value">content</tagname>
```

**void elements** have no content and no closing tag:

```html
<br>     line break
<hr>     horizontal divider
<img>    image
<input>  input field
<link>   external resource
<meta>   metadata
```

**nesting rule** — always close inner elements before outer:

```html
<!-- correct -->
<div><p><strong>text</strong></p></div>

<!-- wrong -->
<div><p><strong>text</div></p></strong>
```

---

## semantic HTML

semantic elements tell the browser AND developers what content means, not just how it looks.

**why it matters:**
- accessibility: screen readers understand page structure
- SEO: search engines rank pages better
- readability: code is easier to understand

```html
<!-- bad — no meaning, just boxes -->
<div class="header">
    <div class="nav">
        <div class="nav-item">Home</div>
    </div>
</div>

<!-- good — meaningful -->
<header>
    <nav>
        <a href="/">Home</a>
    </nav>
</header>
```

**semantic elements and what they mean:**

`<header>` — top section of page or article

`<nav>` — navigation links

`<main>` — primary content (only ONE per page)

`<article>` — self-contained content like a blog post or product card

`<section>` — thematic grouping within a page

`<aside>` — secondary related content like a sidebar

`<footer>` — bottom section of page or article

`<figure>` — self-contained media like an image or diagram

`<figcaption>` — caption for a figure

`<time>` — date or time value

use `<div>` only when no semantic element fits. div is a generic container with zero meaning.

---

## headings

headings define the document outline. screen readers let users jump between headings. search engines use them for ranking.

```html
<h1>Main Title of Page</h1>
<h2>Section Title</h2>
<h3>Subsection</h3>
<h4>Sub-subsection</h4>
<h5>Rarely needed</h5>
<h6>Almost never used</h6>
```

rules:
- only ONE h1 per page
- do not skip levels (h1 to h3 without h2 is wrong)
- use headings for structure, not to make text big (use CSS for that)

---

## text elements

```html
<p>a paragraph of text</p>

<strong>important text</strong>
<em>emphasized text</em>
<code>inline code snippet</code>

<pre><code>
    multiline
    code block
</code></pre>

<blockquote cite="https://source.com">
    a long quotation from another source
</blockquote>

<abbr title="HyperText Markup Language">HTML</abbr>

<del>deleted text</del>
<ins>inserted text</ins>
<mark>highlighted text</mark>

<sup>superscript like x squared</sup>
<sub>subscript like H2O</sub>
```

---

## links

```html
<!-- external link -->
<a href="https://google.com">Google</a>

<!-- internal link -->
<a href="/about">About Page</a>

<!-- jump to section on same page -->
<a href="#projects">See Projects</a>
<section id="projects">...</section>

<!-- email -->
<a href="mailto:you@email.com">Email me</a>

<!-- phone -->
<a href="tel:+919876543210">Call me</a>

<!-- open in new tab — always add rel for security -->
<a href="https://google.com" target="_blank" rel="noopener noreferrer">
    Google
</a>

<!-- download -->
<a href="/resume.pdf" download="Abhishek_Resume.pdf">Download Resume</a>
```

`rel="noopener noreferrer"` is important security: without it, the new tab can access your page via window.opener and potentially redirect it.

---

## images

```html
<!-- basic -->
<img src="photo.jpg" alt="description of image">

<!-- with dimensions prevents layout shift -->
<img src="photo.jpg" alt="description" width="800" height="600">

<!-- with caption -->
<figure>
    <img src="chart.png" alt="bar chart showing 40% sales growth">
    <figcaption>Sales grew 40% in Q3 2026</figcaption>
</figure>

<!-- lazy loading -->
<img src="image.jpg" alt="..." loading="lazy">
```

**alt attribute rules:**
- required for accessibility (screen readers read it)
- shown if image fails to load
- used by search engines
- for purely decorative images use empty alt=""

**image formats:**
- JPEG: photos, complex images, smaller file size, lossy
- PNG: logos, icons, transparency support, lossless
- WebP: modern format, 30% smaller than JPEG/PNG, use when possible
- SVG: vector graphics, scales to any size, perfect for icons/logos
- AVIF: newest format, even smaller than WebP

---

## lists

```html
<!-- unordered (bullets) -->
<ul>
    <li>React</li>
    <li>Vue</li>
</ul>

<!-- ordered (numbers) -->
<ol>
    <li>Install Node.js</li>
    <li>Create project</li>
</ol>

<!-- description list -->
<dl>
    <dt>API</dt>
    <dd>Application Programming Interface</dd>
    <dt>DOM</dt>
    <dd>Document Object Model</dd>
</dl>

<!-- nested -->
<ul>
    <li>Frontend
        <ul>
            <li>HTML</li>
            <li>CSS</li>
        </ul>
    </li>
</ul>
```

---

## tables

tables are for tabular data only — rows and columns that relate to each other. never use tables for page layout.

```html
<table>
    <caption>Monthly Revenue</caption>
    <thead>
        <tr>
            <th scope="col">Month</th>
            <th scope="col">Revenue</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>January</td>
            <td>50000</td>
        </tr>
    </tbody>
    <tfoot>
        <tr>
            <td>Total</td>
            <td>50000</td>
        </tr>
    </tfoot>
</table>
```

`colspan` makes a cell span multiple columns. `rowspan` makes a cell span multiple rows.

---

## forms

forms collect user input and send it to a server. the label's `for` attribute must match the input's `id` — this connects them so clicking the label focuses the input.

```html
<form action="/submit" method="POST">

    <label for="name">Full Name</label>
    <input type="text" id="name" name="name"
           placeholder="Abhishek Kumar" required minlength="2">

    <label for="email">Email</label>
    <input type="email" id="email" name="email" required>

    <label for="password">Password</label>
    <input type="password" id="password" name="password" minlength="8">

    <label for="age">Age</label>
    <input type="number" id="age" name="age" min="1" max="120">

    <!-- checkbox -->
    <input type="checkbox" id="agree" name="agree" value="yes">
    <label for="agree">I agree to terms</label>

    <!-- radio buttons -->
    <fieldset>
        <legend>Experience Level</legend>
        <input type="radio" id="beginner" name="level" value="beginner">
        <label for="beginner">Beginner</label>
        <input type="radio" id="advanced" name="level" value="advanced">
        <label for="advanced">Advanced</label>
    </fieldset>

    <!-- dropdown -->
    <select id="country" name="country">
        <option value="">Select country</option>
        <option value="in">India</option>
        <option value="us">USA</option>
    </select>

    <!-- textarea -->
    <textarea id="message" name="message" rows="5"></textarea>

    <!-- file upload -->
    <input type="file" name="photo" accept="image/*">

    <button type="submit">Submit</button>

</form>
```

`method="GET"` puts data in URL (for search forms). `method="POST"` puts data in request body (for sensitive data like passwords).

---

## data attributes

store custom data on elements, accessible via JavaScript:

```html
<button data-user-id="123" data-action="delete">Delete User</button>
<div data-product-id="456" data-price="999">Product Card</div>
```

```javascript
const btn = document.querySelector('button')
btn.dataset.userId   // "123"
btn.dataset.action   // "delete"
```

---

## accessibility

```html
<!-- alt on all images -->
<img src="logo.png" alt="Company Logo">
<img src="bg.png" alt="">  <!-- decorative: empty alt -->

<!-- label every input -->
<label for="email">Email</label>
<input id="email" type="email">

<!-- aria-label for icon buttons -->
<button aria-label="Close dialog">x</button>

<!-- skip link for keyboard users -->
<a href="#main" class="skip-link">Skip to main content</a>

<!-- live region for dynamic updates -->
<div aria-live="polite" id="notification"></div>
```

---

## SEO meta tags

```html
<head>
    <title>How to Learn HTML | DevBlog</title>
    <meta name="description" content="Complete guide to learning HTML">

    <!-- open graph for social media previews -->
    <meta property="og:title" content="How to Learn HTML">
    <meta property="og:image" content="https://example.com/og-image.jpg">
    <meta property="og:url" content="https://example.com/html-guide">

    <!-- canonical URL prevents duplicate content penalty -->
    <link rel="canonical" href="https://example.com/html-guide">

    <link rel="icon" href="/favicon.ico">
</head>
```

---

## HTML entities

used to display reserved or special characters:

```
&lt;     less than sign
&gt;     greater than sign
&amp;    ampersand
&quot;   double quote
&nbsp;   non-breaking space
&copy;   copyright symbol
&mdash;  em dash
&hellip; ellipsis
```

---

```
=^._.^= structure first, style later
```
