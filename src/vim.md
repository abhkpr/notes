# Vim Cheatsheet — Most Used Commands

---

## Modes

| Mode | How to enter | What it does |
|---|---|---|
| **Normal** | `Esc` | Navigate, run commands |
| **Insert** | `i` | Type text |
| **Visual** | `v` | Select text |

---

## Open & Exit

```bash
vim filename.txt    # open file
```

| Command | Action |
|---|---|
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving |

---

## Navigation (Normal Mode)

| Key | Action |
|---|---|
| `h j k l` | Left, down, up, right |
| `gg` | Go to top of file |
| `G` | Go to bottom of file |
| `0` | Start of line |
| `$` | End of line |
| `Ctrl+d` | Scroll down half page |
| `Ctrl+u` | Scroll up half page |

---

## Editing

| Key | Action |
|---|---|
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `o` | New line below |
| `O` | New line above |
| `dd` | Delete line |
| `yy` | Copy line |
| `p` | Paste |
| `u` | Undo |
| `Ctrl+r` | Redo |

---

## Search & Replace

| Command | Action |
|---|---|
| `/word` | Search forward |
| `n` | Next result |
| `N` | Previous result |
| `:%s/old/new/g` | Replace all occurrences |

---

## Visual Mode (Select Text)

| Key | Action |
|---|---|
| `v` | Select characters |
| `V` | Select whole lines |
| `d` | Delete selected |
| `y` | Copy selected |

---

> **Tip:** Press `Esc` whenever you're lost — it always takes you back to Normal mode.
