# Dev Vocabulary

> every term you will encounter building websites, web apps and android apps.

---

## UI components

these are the building blocks of every interface. learn these names and you can communicate clearly with any designer or developer.

### navigation

**Navbar / Navigation Bar** — horizontal bar at top of page with links and logo.

**Sidebar** — vertical panel on left or right side with navigation or extra content.

**Breadcrumb** — shows current location in hierarchy. `Home > Blog > Article Title`

**Tab Bar** — tabs at top or bottom to switch between sections.

**Drawer / Side Sheet** — panel that slides in from the side, usually on mobile.

**Bottom Navigation Bar** — Android/iOS style tabs at bottom of screen.

**Hamburger Menu** — three horizontal lines icon that opens a menu on click. common on mobile.

**Dropdown Menu** — list that appears below a button when clicked.

**Mega Menu** — large dropdown with multiple columns, used for complex sites.

**Pagination** — numbered pages at bottom. `< 1 2 3 4 5 >`

**Breadcrumb Trail** — path showing where you are in the app hierarchy.

---

### content display

**Card** — box containing related content (image, title, description, action). the most common UI component.

**Hero Section** — large banner at top of page, usually with headline and CTA.

**Banner** — wide horizontal strip, often for announcements or ads.

**Avatar** — small circular image representing a user.

**Badge** — small indicator showing count or status, often on icons. the notification count on an app icon.

**Tag / Chip / Pill** — small label to categorize content. `#technology` `React` `Beginner`.

**Tooltip** — small popup with extra info when you hover over something.

**Popover** — floating panel with more content, triggered by click.

**Callout / Alert Box** — highlighted box for important messages. success (green), warning (yellow), error (red), info (blue).

**Empty State** — what is shown when there is no data. "No posts yet — create your first post!"

**Skeleton Screen** — animated placeholder shown while content loads. grey boxes that pulse.

**Placeholder** — grayed-out hint text inside an empty input field.

---

### feedback and status

**Toast / Snackbar** — small temporary notification that appears briefly at bottom or top of screen. "Message sent successfully."

**Modal / Dialog** — popup overlay that requires user action before continuing. blocks background interaction.

**Alert** — inline message about something important.

**Progress Bar** — horizontal bar showing completion percentage.

**Spinner / Loader** — rotating animation showing something is loading.

**Loading Skeleton** — animated gray placeholder mimicking content layout while loading.

**Notification** — message alerting user to an event (new message, like, etc).

**Error State** — what is shown when something goes wrong. error message with retry option.

---

### input and forms

**Input Field / Text Field** — box where user types text.

**Textarea** — multi-line text input for longer content.

**Dropdown / Select** — click to reveal list of options, pick one.

**Checkbox** — square box, tick to select. multiple can be selected.

**Radio Button** — circular button. only one in a group can be selected.

**Toggle / Switch** — on/off switch. like a light switch.

**Slider** — drag left/right to pick a value in a range.

**Date Picker** — calendar UI for picking a date.

**Time Picker** — clock UI for picking a time.

**Color Picker** — palette UI for picking a color.

**Search Bar** — input field with search icon, often with autocomplete.

**Autocomplete** — dropdown suggestions that appear as you type.

**File Upload** — button or drag-drop area to select files.

**Form** — group of input fields with a submit button.

**Field Validation** — check if input is correct. shows error message if not.

**Label** — text above or beside an input describing what it is.

**Placeholder Text** — hint text inside empty input. disappears when you start typing.

**Required Field** — input that must be filled before form can be submitted.

---

### actions and buttons

**CTA (Call to Action)** — button that prompts user to do something. "Sign Up", "Get Started", "Buy Now".

**Primary Button** — main action, visually prominent (filled, colored).

**Secondary Button** — alternative action, less prominent (outlined or ghost).

**Ghost Button** — button with only an outline, no fill.

**Icon Button** — button with just an icon, no text label.

**FAB (Floating Action Button)** — circular button floating over content, for primary action. common in Android apps.

**Link Button** — looks like a link but works like a button.

**Button Group** — multiple related buttons together.

**Split Button** — button + dropdown arrow combined.

---

### layout components

**Container** — wrapper that limits content width and centers it on the page.

**Grid** — layout system dividing page into rows and columns.

**Divider / Separator** — horizontal or vertical line separating sections.

**Spacer** — empty space between elements for visual breathing room.

**Section** — major part of a page. hero section, features section, testimonials section.

**Panel** — contained area of content, usually with a border or background.

**Accordion** — list of items that expand/collapse on click to show content.

**Tabs** — multiple panels where one is shown at a time, switched by clicking tab labels.

**Stepper** — shows steps in a multi-step process. `Step 1 > Step 2 > Step 3`.

**Timeline** — vertical or horizontal list of events in chronological order.

**List Item** — single row in a list, often with icon, title, subtitle and action.

**Table** — rows and columns of data with sortable headers.

**Data Grid** — advanced table with sorting, filtering, pagination.

---

### media

**Carousel / Slider** — shows multiple images/cards that scroll horizontally.

**Gallery** — grid of images.

**Lightbox** — overlay that shows full-size image when thumbnail is clicked.

**Video Player** — component with play/pause/volume controls.

**Image** — obvious. always needs alt text for accessibility.

**Icon** — small visual symbol representing an action or concept.

**Illustration** — custom drawing used decoratively in UI.

---

## layout and design terms

**Whitespace / Negative Space** — empty space around elements. essential for readability. more whitespace = more premium feel.

**Padding** — space inside an element, between content and border.

**Margin** — space outside an element, between it and other elements.

**Border** — line around an element.

**Border Radius** — rounded corners. high border-radius = pill shape.

**Shadow** — drop shadow under element to create depth.

**Elevation** — how high an element appears to float above the surface (material design concept).

**Z-index** — stacking order. higher z-index = on top.

**Viewport** — visible area of the browser window.

**Above the fold** — content visible without scrolling. the most important content goes here.

**Below the fold** — content that requires scrolling to see.

**Breakpoint** — screen width at which layout changes for responsiveness. common: 480px, 768px, 1024px, 1280px.

**Grid System** — set of columns used to align content. 12-column grid is standard.

**Gutter** — space between columns in a grid.

**Alignment** — how elements are positioned relative to each other. left, center, right, justified.

**Hierarchy** — visual ordering of importance. biggest/boldest = most important.

**Contrast** — difference between elements. high contrast = easier to read.

**Consistency** — same patterns repeated. buttons look the same everywhere. same font, same spacing.

---

## web development terms

**Frontend** — everything the user sees and interacts with. HTML, CSS, JavaScript.

**Backend** — server-side logic, database, APIs. user never sees this directly.

**Full Stack** — both frontend and backend.

**Static Site** — pre-built HTML files. no server needed. fast, secure, cheap. (your Hugo site)

**Dynamic Site** — content generated on the fly by a server.

**SPA (Single Page Application)** — one HTML page, JavaScript handles all navigation without reloading. React, Vue, Angular apps.

**SSR (Server-Side Rendering)** — HTML generated on server for each request. good for SEO. Next.js does this.

**SSG (Static Site Generation)** — HTML generated at build time. fastest. Hugo, Next.js, Astro.

**CSR (Client-Side Rendering)** — HTML generated in browser by JavaScript. React default behavior.

**Hydration** — process where static HTML becomes interactive by attaching JavaScript event listeners.

**API (Application Programming Interface)** — a way for two programs to talk to each other. your frontend calls an API to get data.

**REST API** — standard for web APIs. uses HTTP methods (GET, POST, PUT, DELETE) with JSON data.

**GraphQL** — alternative to REST where client requests exactly the data it needs.

**JSON (JavaScript Object Notation)** — lightweight data format used in APIs.

**HTTP** — protocol for web communication. request/response.

**HTTPS** — HTTP with encryption (TLS/SSL).

**URL (Uniform Resource Locator)** — web address. `https://example.com/path?query=value`.

**Domain** — human-readable address. `google.com`, `abhishekkumar.xyz`.

**Subdomain** — prefix to domain. `api.example.com`, `app.example.com`.

**DNS** — system that converts domain names to IP addresses.

**IP Address** — numerical address of a computer on the internet.

**Server** — computer that responds to requests and serves data.

**Client** — browser or app that makes requests to a server.

**Request** — message sent from client to server asking for something.

**Response** — server's reply to a request.

**Status Code** — number in HTTP response indicating success or failure. 200=ok, 404=not found, 500=server error.

**Authentication** — verifying who a user is. logging in.

**Authorization** — verifying what a user is allowed to do.

**Session** — period of user activity. maintained by cookie or token.

**JWT (JSON Web Token)** — encoded token proving user's identity. sent with each request.

**Cookie** — small file stored in browser, sent automatically with requests.

**Local Storage** — browser storage that persists after tab close.

**Session Storage** — browser storage that clears when tab closes.

**Cache** — stored copy of data for faster access.

**CDN (Content Delivery Network)** — servers around the world that serve files from nearest location.

**Deployment** — process of making your code live on the internet.

**Environment Variables** — configuration values stored outside code. API keys, database URLs.

**Dev/Staging/Production** — development (local), staging (test server), production (live site).

**CI/CD (Continuous Integration/Continuous Deployment)** — automatic testing and deployment when you push code. GitHub Actions.

**Version Control** — tracking changes to code over time. Git.

**Repository (Repo)** — project folder tracked by Git.

**Branch** — separate version of code for a feature or fix.

**Pull Request (PR)** — request to merge your branch into main. for code review.

**Dependency** — external package your code needs to work.

**Package Manager** — tool to install and manage dependencies. npm, pip, gradle.

**Build** — process of compiling/bundling code for production.

**Bundle** — single file combining all your JS/CSS for production.

**Minification** — removing whitespace and renaming variables to make files smaller.

**CORS (Cross-Origin Resource Sharing)** — browser security rule that blocks requests from different domains.

**Webhook** — HTTP callback. when event happens, send POST to a URL.

**WebSocket** — persistent connection for real-time two-way communication.

---

## database terms

**Database** — organized collection of data.

**SQL** — language for querying relational databases.

**Table** — data organized in rows and columns (like Excel).

**Row / Record** — one entry in a table.

**Column / Field** — one attribute of the data.

**Primary Key** — unique identifier for each row. usually `id`.

**Foreign Key** — column that references primary key of another table. creates relationship.

**Index** — data structure that speeds up database queries.

**Query** — request to get or modify data from a database.

**Schema** — structure/blueprint of the database. tables, columns, types.

**Migration** — versioned changes to database schema.

**ORM (Object-Relational Mapper)** — tool that lets you interact with database using code instead of SQL.

**NoSQL** — non-relational databases. MongoDB, Redis, Cassandra.

**CRUD** — Create, Read, Update, Delete. the four basic database operations.

**Transaction** — group of operations that all succeed or all fail together.

---

## Android development terms

**Activity** — a single screen in an Android app. like a page.

**Fragment** — reusable portion of UI within an Activity.

**Intent** — message to start an Activity or communicate between components.

**View** — basic building block of Android UI. button, text, image.

**ViewGroup** — container that holds Views. LinearLayout, RelativeLayout.

**Layout** — XML file defining the structure of a screen.

**RecyclerView** — efficient scrolling list that recycles views.

**Adapter** — connects data to a RecyclerView or ListView.

**ViewModel** — holds and manages UI data, survives configuration changes (screen rotation).

**LiveData** — observable data holder that respects Android lifecycle.

**StateFlow** — Kotlin version of LiveData, modern approach.

**Coroutine** — Kotlin's way of doing async operations cleanly.

**Repository** — layer between ViewModel and data sources (API, database).

**Room** — Android's SQLite ORM library.

**Jetpack Compose** — modern way to build Android UI with Kotlin code instead of XML.

**Composable** — a function that defines UI in Jetpack Compose.

**Recomposition** — Compose re-running composables when state changes.

**APK (Android Package Kit)** — the file format for distributing Android apps.

**Manifest** — XML file declaring app components, permissions, configuration.

**Permission** — user must grant app access to features like camera, location, storage.

**Gradle** — build system for Android. like npm for Android.

**SDK (Software Development Kit)** — tools and libraries for building Android apps.

**API Level** — Android version number. API 21 = Android 5.0.

**minSdk** — minimum Android version your app supports.

**targetSdk** — Android version your app is optimized for.

**Notification** — message shown in status bar/notification drawer.

**Service** — background operation without a UI. music player, download manager.

**BroadcastReceiver** — listens for system-wide events. battery low, boot complete.

**ContentProvider** — shares data between apps.

**Deep Link** — URL that opens a specific screen in your app.

**Back Stack** — history of screens user has visited, navigated with back button.

**Lifecycle** — states an Activity goes through: created, started, resumed, paused, stopped, destroyed.

---

## performance terms

**Render** — process of browser drawing elements on screen.

**Repaint** — browser redrawing pixels (color changes, visibility).

**Reflow / Layout** — browser recalculating element positions and sizes. expensive.

**FPS (Frames Per Second)** — how many frames render per second. 60fps = smooth.

**Jank** — visible stuttering/lag in animation or scrolling.

**Lazy Loading** — load content only when needed, not all at once.

**Code Splitting** — splitting JS into smaller chunks loaded on demand.

**Tree Shaking** — removing unused code from build.

**Memoization** — caching results of expensive function calls.

**Debounce** — delay function execution until user stops triggering it. search input.

**Throttle** — limit how often a function can run. scroll events.

**TTI (Time to Interactive)** — how long until page is usable.

**LCP (Largest Contentful Paint)** — how long until largest content element loads.

**CLS (Cumulative Layout Shift)** — how much layout shifts unexpectedly. annoying.

**Core Web Vitals** — Google's metrics for page experience. LCP, FID, CLS.

---

## design system terms

**Design System** — collection of reusable components and guidelines for consistent UI.

**Component Library** — reusable UI components. Material UI, shadcn/ui, Ant Design.

**Style Guide** — documentation of colors, fonts, spacing, and usage rules.

**Design Tokens** — named values for colors, spacing, fonts. CSS variables.

**Theme** — set of design tokens that can be swapped. light/dark mode.

**Variant** — different visual versions of a component. primary/secondary/danger button.

**State** — visual condition of a component. default, hover, focus, active, disabled, loading.

**Responsive** — design that adapts to different screen sizes.

**Mobile-First** — designing for smallest screen first, then adding for larger screens.

**Pixel Perfect** — matching design exactly to the pixel.

**Wireframe** — low-fidelity sketch of a UI, no styling.

**Mockup** — high-fidelity static design, looks real but not interactive.

**Prototype** — interactive mockup to test user flows.

**Figma** — most popular UI design tool. designers use it, developers implement from it.

**Handoff** — when designer gives developer all specs to implement the design.

---

## common abbreviations

```
UI     User Interface
UX     User Experience
CTA    Call to Action
SPA    Single Page Application
SSR    Server Side Rendering
SSG    Static Site Generation
API    Application Programming Interface
REST   Representational State Transfer
JWT    JSON Web Token
CRUD   Create Read Update Delete
ORM    Object Relational Mapper
CDN    Content Delivery Network
DNS    Domain Name System
HTTP   HyperText Transfer Protocol
HTML   HyperText Markup Language
CSS    Cascading Style Sheets
JS     JavaScript
TS     TypeScript
DOM    Document Object Model
CORS   Cross Origin Resource Sharing
CI/CD  Continuous Integration / Continuous Deployment
PR     Pull Request
SDK    Software Development Kit
APK    Android Package Kit
MVP    Minimum Viable Product
LGTM   Looks Good To Me (code review)
WIP    Work In Progress
DRY    Don't Repeat Yourself
SOLID  Single responsibility, Open/closed, Liskov, Interface, Dependency
a11y   Accessibility (a + 11 letters + y)
i18n   Internationalization (i + 18 letters + n)
```

---

```
=^._.^= know the words, speak the language
```
