# Alacritty

> the fastest terminal emulator. GPU-accelerated, minimal, fast.

---

## what is Alacritty

Alacritty is a terminal emulator written in Rust. it uses the GPU for rendering which makes it significantly faster than CPU-rendered terminals like GNOME Terminal or xterm.

it is intentionally minimal — no tabs, no splits, no scrollback search UI. it does one thing: render text fast. pair it with tmux for tabs and splits.

**why use it:**
- fastest terminal available
- cross-platform (Linux, macOS, Windows)
- highly configurable via a single TOML file
- works perfectly with i3wm (what you use)
- low memory usage

---

## install

```bash
# Ubuntu / Linux Lite
sudo apt install alacritty

# or from source (latest version)
sudo apt install cargo
cargo install alacritty

# set as default terminal
sudo update-alternatives --install /usr/bin/x-terminal-emulator \
    x-terminal-emulator /usr/bin/alacritty 50
sudo update-alternatives --config x-terminal-emulator

# in i3 config — set alacritty as terminal
bindsym $mod+Return exec alacritty
```

---

## config file

Alacritty uses TOML format. config lives at:

```
~/.config/alacritty/alacritty.toml   (modern, preferred)
~/.alacritty.toml                     (alternative)
```

```bash
mkdir -p ~/.config/alacritty
nano ~/.config/alacritty/alacritty.toml
```

---

## complete config

```toml
# ~/.config/alacritty/alacritty.toml

[env]
TERM = "xterm-256color"

[window]
padding = { x = 12, y = 12 }
dynamic_padding = false
decorations = "none"          # no title bar (good for i3)
opacity = 0.95                # slight transparency
startup_mode = "Windowed"
title = "alacritty"
dynamic_title = true          # show current command in title

[scrolling]
history = 10000               # lines to keep in scrollback
multiplier = 3                # scroll speed

[font]
normal = { family = "FiraCode Nerd Font", style = "Regular" }
bold   = { family = "FiraCode Nerd Font", style = "Bold" }
italic = { family = "FiraCode Nerd Font", style = "Italic" }
size = 13.0

[font.offset]
x = 0
y = 2                         # line height tweak

[cursor]
style = { shape = "Block", blinking = "Always" }
blink_interval = 500          # ms
vi_mode_style = { shape = "Block" }
thickness = 0.15

[terminal]
osc52 = "CopyPaste"           # allow copy via OSC52 (useful in SSH)

# dark theme — matches your notes site
[colors.primary]
background = "#0d0d0d"
foreground = "#e0e0e0"

[colors.cursor]
text   = "#0d0d0d"
cursor = "#00cc00"

[colors.normal]
black   = "#1a1a1a"
red     = "#cc3333"
green   = "#00cc00"
yellow  = "#ccaa00"
blue    = "#3399cc"
magenta = "#9966cc"
cyan    = "#00aaaa"
white   = "#cccccc"

[colors.bright]
black   = "#333333"
red     = "#ff4444"
green   = "#33ff33"
yellow  = "#ffcc00"
blue    = "#44aaff"
magenta = "#bb88ff"
cyan    = "#00cccc"
white   = "#e0e0e0"

# key bindings
[[keyboard.bindings]]
key = "V"
mods = "Control|Shift"
action = "Paste"

[[keyboard.bindings]]
key = "C"
mods = "Control|Shift"
action = "Copy"

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
key = "F11"
action = "ToggleFullscreen"

# open new terminal in same directory
[[keyboard.bindings]]
key = "Return"
mods = "Control|Shift"
action = "SpawnNewInstance"
```

---

## fonts

Alacritty works best with a Nerd Font — these include icons used by tools like nvim plugins, starship prompt, etc.

```bash
# install FiraCode Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# download
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip FiraCode.zip
fc-cache -fv

# verify font is found
fc-list | grep -i firacode
```

---

## useful CLI flags

```bash
alacritty                          # open terminal
alacritty --hold -e command        # run command, keep open after exit
alacritty -e htop                  # open with specific command
alacritty --title "my terminal"    # set window title
alacritty --config-file ~/custom.toml  # use different config
alacritty -o 'font.size=16'        # override config option

# open in specific directory
alacritty --working-directory ~/projects/studentos
```

---

## with i3wm

```bash
# ~/.config/i3/config

# open terminal
bindsym $mod+Return exec alacritty

# open terminal in current directory (requires xcwd or similar)
bindsym $mod+Shift+Return exec alacritty --working-directory "$(xcwd)"

# scratchpad terminal
bindsym $mod+grave exec alacritty --title scratchpad
for_window [title="scratchpad"] move scratchpad
bindsym $mod+Shift+grave [title="scratchpad"] scratchpad show
```

---

## with tmux (the right combo)

Alacritty has no tabs or splits. use tmux for that:

```bash
# open alacritty and start tmux
alacritty -e tmux new-session

# or add to alacritty config to always start tmux
# no built-in way — do it in shell profile instead:
# add to ~/.bashrc:
# if [ -z "$TMUX" ]; then tmux attach || tmux new-session; fi
```

---

## live reload

Alacritty watches its config file and reloads automatically when you save. no restart needed.

```bash
# edit config and save — terminal updates instantly
nano ~/.config/alacritty/alacritty.toml
```

---

## troubleshooting

```bash
# check config for errors
alacritty --print-events 2>&1 | head -20

# reset to defaults
mv ~/.config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml.bak

# wrong colors in vim/neovim
# make sure TERM is set correctly
echo $TERM          # should be xterm-256color or alacritty
# add to config: [env] TERM = "xterm-256color"

# font not found
fc-list | grep -i "your font name"
fc-cache -fv       # rebuild font cache
```

---

```
=^._.^= fast terminal. more time coding.
```
