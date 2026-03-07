# Alacritty

## What is Alacritty?

Alacritty is a **GPU-accelerated terminal emulator** written in Rust. It is the fastest terminal available — renders using OpenGL, configured entirely via a single TOML file. No GUI settings, no tabs built-in, no plugins.

```
fast        → GPU rendering, no electron, no web engine
minimal     → one config file, zero bloat
composable  → pair with tmux or zellij for tabs/splits
live reload → change config, see it instantly
```

---

## Install

```bash
# Ubuntu / Debian
sudo apt install alacritty

# Arch
sudo pacman -S alacritty

# macOS
brew install --cask alacritty

# From source (latest)
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev \
  libxcb-xfixes0-dev libxkbcommon-dev python3
git clone https://github.com/alacritty/alacritty.git
cd alacritty
cargo build --release
sudo cp target/release/alacritty /usr/local/bin
```

---

## Config File Location

```bash
# Linux + macOS
~/.config/alacritty/alacritty.toml

# Create it
mkdir -p ~/.config/alacritty
touch ~/.config/alacritty/alacritty.toml
```

Alacritty **watches the config file** — changes apply live without restarting.

> Note: versions before v0.12 use YAML (`alacritty.yml`). v0.12+ uses TOML.

---

## Full Config Reference

```toml
# ~/.config/alacritty/alacritty.toml

[env]
TERM = "xterm-256color"

[window]
padding.x = 12
padding.y = 10
decorations = "full"        # full | none | transparent (macOS)
opacity = 1.0               # 0.0 transparent → 1.0 opaque
blur = false                # background blur (macOS / picom)
startup_mode = "Windowed"   # Windowed | Maximized | Fullscreen
dynamic_title = true        # title shows current process

[scrolling]
history = 10000             # lines of scrollback
multiplier = 3              # scroll speed multiplier

[font]
size = 13.0

[font.normal]
family = "JetBrainsMono Nerd Font"
style = "Regular"

[font.bold]
family = "JetBrainsMono Nerd Font"
style = "Bold"

[font.italic]
family = "JetBrainsMono Nerd Font"
style = "Italic"

[font.bold_italic]
family = "JetBrainsMono Nerd Font"
style = "Bold Italic"

[font.offset]
x = 0
y = 2                       # extra line spacing

[cursor]
style.shape = "Block"       # Block | Underline | Beam
style.blinking = "On"       # Never | Off | On | Always
blink_interval = 500        # ms between blinks
unfocused_hollow = true     # hollow cursor when window loses focus

[terminal]
shell.program = "/bin/zsh"  # default shell

[mouse]
hide_when_typing = true

[selection]
save_to_clipboard = false   # auto-copy selection to clipboard
```

---

## Fonts

Alacritty works best with **Nerd Fonts** — patched fonts that include icons used by neovim, starship, lsd, etc.

```bash
# Install JetBrains Mono Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip
fc-cache -fv

# Verify
fc-list | grep -i "jetbrains"
```

**Good font choices:**
```
JetBrainsMono Nerd Font    clean, excellent ligatures
FiraCode Nerd Font          popular, great ligatures
Hack Nerd Font              minimal, very readable
CascadiaCode Nerd Font      Microsoft font, clean
Iosevka Nerd Font           narrow, fits more on screen
```

---

## Colors

### Tokyo Night

```toml
[colors.primary]
background = "#1a1b26"
foreground = "#c0caf5"

[colors.cursor]
text   = "#1a1b26"
cursor = "#c0caf5"

[colors.normal]
black   = "#15161e"
red     = "#f7768e"
green   = "#9ece6a"
yellow  = "#e0af68"
blue    = "#7aa2f7"
magenta = "#bb9af7"
cyan    = "#7dcfff"
white   = "#a9b1d6"

[colors.bright]
black   = "#414868"
red     = "#f7768e"
green   = "#9ece6a"
yellow  = "#e0af68"
blue    = "#7aa2f7"
magenta = "#bb9af7"
cyan    = "#7dcfff"
white   = "#c0caf5"
```

### Catppuccin Mocha

```toml
[colors.primary]
background = "#1e1e2e"
foreground = "#cdd6f4"

[colors.normal]
black   = "#45475a"
red     = "#f38ba8"
green   = "#a6e3a1"
yellow  = "#f9e2af"
blue    = "#89b4fa"
magenta = "#f5c2e7"
cyan    = "#94e2d5"
white   = "#bac2de"

[colors.bright]
black   = "#585b70"
red     = "#f38ba8"
green   = "#a6e3a1"
yellow  = "#f9e2af"
blue    = "#89b4fa"
magenta = "#f5c2e7"
cyan    = "#94e2d5"
white   = "#a6adc8"
```

### Gruvbox Dark

```toml
[colors.primary]
background = "#282828"
foreground = "#ebdbb2"

[colors.normal]
black   = "#282828"
red     = "#cc241d"
green   = "#98971a"
yellow  = "#d79921"
blue    = "#458588"
magenta = "#b16286"
cyan    = "#689d6a"
white   = "#a89984"

[colors.bright]
black   = "#928374"
red     = "#fb4934"
green   = "#b8bb26"
yellow  = "#fabd2f"
blue    = "#83a598"
magenta = "#d3869b"
cyan    = "#8ec07c"
white   = "#ebdbb2"
```

---

## Key Bindings

```toml
[[keyboard.bindings]]
key = "C"
mods = "Control|Shift"
action = "Copy"

[[keyboard.bindings]]
key = "V"
mods = "Control|Shift"
action = "Paste"

[[keyboard.bindings]]
key = "Plus"
mods = "Control"
action = "IncreaseFontSize"

[[keyboard.bindings]]
key = "Minus"
mods = "Control"
action = "DecreaseFontSize"

[[keyboard.bindings]]
key = "Key0"
mods = "Control"
action = "ResetFontSize"

[[keyboard.bindings]]
key = "N"
mods = "Control|Shift"
action = "SpawnNewInstance"

[[keyboard.bindings]]
key = "F11"
action = "ToggleFullscreen"

[[keyboard.bindings]]
key = "PageUp"
mods = "Shift"
action = "ScrollPageUp"

[[keyboard.bindings]]
key = "PageDown"
mods = "Shift"
action = "ScrollPageDown"

[[keyboard.bindings]]
key = "Home"
mods = "Shift"
action = "ScrollToTop"

[[keyboard.bindings]]
key = "End"
mods = "Shift"
action = "ScrollToBottom"
```

---

## Default Shortcuts

```
Ctrl+Shift+C          copy selection
Ctrl+Shift+V          paste
Ctrl+Shift+N          new window
Ctrl++                increase font size
Ctrl+-                decrease font size
Ctrl+0                reset font size
Shift+PageUp          scroll up one page
Shift+PageDown        scroll down one page
Shift+Home            scroll to top
Shift+End             scroll to bottom
Ctrl+Shift+Space      enter vi mode
```

---

## Vi Mode

Vi mode lets you scroll and select text without a mouse.

```
Ctrl+Shift+Space      enter vi mode
h j k l               move cursor left/down/up/right
Ctrl+d                half page down
Ctrl+u                half page up
Ctrl+f                full page down
Ctrl+b                full page up
gg                    go to top
G                     go to bottom
v                     start character selection
V                     select entire line
y                     copy selection and exit vi mode
/                     search forward
?                     search backward
n                     next search match
N                     previous search match
Escape                exit vi mode
```

---

## Transparency + Blur

```toml
[window]
opacity = 0.90        # semi-transparent

# blur — needs a compositor
blur = true
```

**Setup picom blur on i3:**

```bash
# Install picom
sudo apt install picom

# Run with blur
picom --blur-method dual_kawase --blur-strength 5 &
```

```bash
# Add to i3 config so it starts automatically
exec --no-startup-id picom --blur-method dual_kawase --blur-strength 5
```

---

## Use with tmux

Alacritty has no tabs or splits by design. tmux gives you that.

```toml
# Auto-attach or create tmux session on launch
[terminal]
shell.program = "/bin/bash"
shell.args = ["-c", "tmux attach || tmux new-session"]
```

```
# Essential tmux shortcuts inside alacritty
Ctrl+b c          new window
Ctrl+b n          next window
Ctrl+b p          previous window
Ctrl+b %          split vertically
Ctrl+b "          split horizontally
Ctrl+b h/j/k/l    move between panes
Ctrl+b d          detach session
Ctrl+b [          scroll mode (vi keys work here)
```

---

## Use with Zellij

Modern tmux alternative — better UI, easier config.

```bash
# Install
bash <(curl -L zellij.dev/launch)

# Auto-start in alacritty
```

```toml
[terminal]
shell.program = "/bin/bash"
shell.args = ["-c", "zellij attach main || zellij --session main"]
```

---

## Split Config with Imports

Keep config clean by splitting into multiple files:

```toml
# alacritty.toml
import = [
  "~/.config/alacritty/themes/tokyo-night.toml",
  "~/.config/alacritty/keybindings.toml",
]

[font]
size = 13.0

[window]
padding.x = 14
padding.y = 12
opacity = 0.95
```

Good folder structure:
```
~/.config/alacritty/
├── alacritty.toml          main config
├── keybindings.toml        all key bindings
└── themes/
    ├── tokyo-night.toml
    ├── catppuccin.toml
    └── gruvbox.toml
```

To switch themes just change the import line.

---

## My Recommended Config

```toml
# ~/.config/alacritty/alacritty.toml

[env]
TERM = "xterm-256color"

[window]
padding.x = 14
padding.y = 12
opacity = 0.95
dynamic_title = true
startup_mode = "Windowed"

[scrolling]
history = 10000
multiplier = 3

[font]
size = 13.0

[font.normal]
family = "JetBrainsMono Nerd Font"
style = "Regular"

[font.bold]
family = "JetBrainsMono Nerd Font"
style = "Bold"

[font.italic]
family = "JetBrainsMono Nerd Font"
style = "Italic"

[font.offset]
y = 2

[cursor]
style.shape = "Beam"
style.blinking = "On"
blink_interval = 500
unfocused_hollow = true

[mouse]
hide_when_typing = true

[colors.primary]
background = "#1a1b26"
foreground = "#c0caf5"

[colors.cursor]
text   = "#1a1b26"
cursor = "#c0caf5"

[colors.normal]
black   = "#15161e"
red     = "#f7768e"
green   = "#9ece6a"
yellow  = "#e0af68"
blue    = "#7aa2f7"
magenta = "#bb9af7"
cyan    = "#7dcfff"
white   = "#a9b1d6"

[colors.bright]
black   = "#414868"
red     = "#f7768e"
green   = "#9ece6a"
yellow  = "#e0af68"
blue    = "#7aa2f7"
magenta = "#bb9af7"
cyan    = "#7dcfff"
white   = "#c0caf5"

[[keyboard.bindings]]
key = "C"
mods = "Control|Shift"
action = "Copy"

[[keyboard.bindings]]
key = "V"
mods = "Control|Shift"
action = "Paste"

[[keyboard.bindings]]
key = "N"
mods = "Control|Shift"
action = "SpawnNewInstance"

[[keyboard.bindings]]
key = "Plus"
mods = "Control"
action = "IncreaseFontSize"

[[keyboard.bindings]]
key = "Minus"
mods = "Control"
action = "DecreaseFontSize"

[[keyboard.bindings]]
key = "Key0"
mods = "Control"
action = "ResetFontSize"
```

---

## Troubleshooting

```bash
# Check for config errors
alacritty --print-events 2>&1 | head -30

# Font not found — check exact name
fc-list | grep -i "jetbrains"
fc-cache -fv                        # rebuild font cache

# Colors wrong
echo $TERM                          # should be xterm-256color

# Slow rendering
# → set opacity = 1.0 (transparency is expensive)
# → disable blur

# Check version (determines YAML vs TOML)
alacritty --version
# v0.12+ → use .toml
# older  → use .yml

# Reset to defaults
mv ~/.config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml.bak
```

---

## Quick Reference

```
Config file         ~/.config/alacritty/alacritty.toml
Live reload         yes — save file, changes apply instantly
Tabs / splits       no — use tmux or zellij
Font format         TTF/OTF, Nerd Fonts recommended
Copy                Ctrl+Shift+C
Paste               Ctrl+Shift+V
New window          Ctrl+Shift+N
Font size           Ctrl+= / Ctrl+-
Vi scroll mode      Ctrl+Shift+Space
Search (vi mode)    /
```
