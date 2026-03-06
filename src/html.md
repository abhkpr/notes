# HTML

> the skeleton of the web. structure everything.

---

## basics

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
    <!-- content here -->
    <script src="app.js"></script>
</body>
</html>
```

---

## semantic elements

use semantic tags — they mean something to browsers and screen readers

```html
<header>     → top of page / section
<nav>        → navigation links
<main>       → main content
<section>    → grouped content
<article>    → standalone content (blog post)
<aside>      → sidebar content
<footer>     → bottom of page
<figure>     → image with caption
<figcaption> → caption for figure
```

non-semantic (just containers):
```html
<div>   → block container
<span>  → inline container
```

---

## text

```html
<h1> to <h6>          → headings (h1 = most important)
<p>                   → paragraph
<strong>              → bold (important)
<em>                  → italic (emphasis)
<br>                  → line break
<hr>                  → horizontal rule
<blockquote>          → quote block
<code>                → inline code
<pre>                 → preformatted text
<mark>                → highlighted text
<small>               → smaller text
<del>                 → strikethrough
```

---

## links and images

```html
<!-- link -->
<a href="https://example.com">click here</a>
<a href="/about">about page</a>
<a href="#section-id">jump to section</a>
<a href="mailto:you@email.com">email me</a>
<a href="url" target="_blank">open in new tab</a>

<!-- image -->
<img src="image.jpg" alt="description" width="300">

<!-- image with link -->
<a href="url">
    <img src="image.jpg" alt="description">
</a>
```

---

## lists

```html
<!-- unordered -->
<ul>
    <li>item one</li>
    <li>item two</li>
</ul>

<!-- ordered -->
<ol>
    <li>first</li>
    <li>second</li>
</ol>

<!-- nested -->
<ul>
    <li>parent
        <ul>
            <li>child</li>
        </ul>
    </li>
</ul>

<!-- description list -->
<dl>
    <dt>term</dt>
    <dd>definition</dd>
</dl>
```

---

## forms

```html
<form action="/submit" method="POST">

    <!-- text input -->
    <input type="text" name="username" placeholder="enter username">

    <!-- email -->
    <input type="email" name="email" required>

    <!-- password -->
    <input type="password" name="password" minlength="8">

    <!-- number -->
    <input type="number" name="age" min="1" max="100">

    <!-- checkbox -->
    <input type="checkbox" name="agree" id="agree">
    <label for="agree">I agree</label>

    <!-- radio -->
    <input type="radio" name="gender" value="male"> Male
    <input type="radio" name="gender" value="female"> Female

    <!-- dropdown -->
    <select name="country">
        <option value="in">India</option>
        <option value="us">USA</option>
    </select>

    <!-- textarea -->
    <textarea name="message" rows="5" cols="40"></textarea>

    <!-- file upload -->
    <input type="file" name="photo" accept="image/*">

    <!-- hidden field -->
    <input type="hidden" name="token" value="abc123">

    <!-- submit -->
    <button type="submit">Submit</button>
    <input type="reset" value="Reset">

</form>
```

---

## tables

```html
<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Age</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Abhishek</td>
            <td>20</td>
        </tr>
    </tbody>
    <tfoot>
        <tr>
            <td colspan="2">footer</td>
        </tr>
    </tfoot>
</table>
```

---

## media

```html
<!-- video -->
<video controls width="640">
    <source src="video.mp4" type="video/mp4">
    your browser doesn't support video
</video>

<!-- audio -->
<audio controls>
    <source src="audio.mp3" type="audio/mpeg">
</audio>

<!-- embed youtube -->
<iframe width="560" height="315"
    src="https://www.youtube.com/embed/VIDEO_ID"
    allowfullscreen>
</iframe>
```

---

## important attributes

```html
id="name"           → unique identifier, used by CSS/JS
class="name"        → group elements, used by CSS/JS
style="color:red"   → inline CSS (avoid this)
data-*="value"      → custom data attributes
hidden              → hides element
disabled            → disables input
readonly            → read only input
required            → required field
placeholder="..."   → hint text in inputs
title="..."         → tooltip on hover
tabindex="1"        → keyboard tab order
```

---

## meta tags (important for SEO)

```html
<meta name="description" content="page description">
<meta name="keywords" content="html, css, web">
<meta name="author" content="Abhishek Kumar">

<!-- open graph (for social sharing) -->
<meta property="og:title" content="Page Title">
<meta property="og:description" content="description">
<meta property="og:image" content="image.jpg">
```

---

## accessibility tips

```html
<!-- always add alt to images -->
<img src="logo.png" alt="company logo">

<!-- label every input -->
<label for="email">Email</label>
<input id="email" type="email">

<!-- use aria labels when needed -->
<button aria-label="close menu">×</button>

<!-- use semantic html over divs -->
<nav> instead of <div class="nav">
<button> instead of <div class="btn">
```

---

## html entities

```
&nbsp;   → non-breaking space
&lt;     → <
&gt;     → >
&amp;    → &
&copy;   → ©
&trade;  → ™
&mdash;  → —
```

---

## project patterns

**card component:**
```html
<article class="card">
    <img src="thumbnail.jpg" alt="post thumbnail">
    <div class="card-body">
        <h2 class="card-title">Title</h2>
        <p class="card-text">description here</p>
        <a href="/read-more" class="btn">Read More</a>
    </div>
</article>
```

**navbar:**
```html
<header>
    <nav class="navbar">
        <a href="/" class="brand">MyApp</a>
        <ul class="nav-links">
            <li><a href="/about">About</a></li>
            <li><a href="/projects">Projects</a></li>
            <li><a href="/contact">Contact</a></li>
        </ul>
        <button class="hamburger">☰</button>
    </nav>
</header>
```

---

```
=^._.^= structure first, style later
```
