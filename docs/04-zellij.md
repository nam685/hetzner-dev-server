# Zellij — Terminal Multiplexer

Zellij is a modern terminal multiplexer (like tmux) with much better defaults and keybindings. It shows a status bar with all shortcuts, so you don't have to memorize anything.

## Why Zellij over tmux

- **Discoverable UI**: Status bar shows available keybindings at all times
- **No prefix key**: tmux requires Ctrl-b before every command. Zellij uses direct shortcuts.
- **Intuitive modes**: Switch between Normal, Pane, Tab, Resize, etc. with clear visual feedback
- **Sane defaults**: Works great out of the box, minimal config needed
- **Session management**: Built-in session attach/detach (critical for SSH — your work survives disconnects)

## Install

```bash
# The setup script installs this, but if you need to install manually:
bash <(curl -L zellij.dev/launch)

# Or via cargo
cargo install zellij

# Or download binary
curl -L https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz | tar xz
sudo mv zellij /usr/local/bin/
```

## Essential Usage

```bash
# Start new session
zellij

# Start named session (recommended)
zellij -s coding

# List sessions
zellij list-sessions
zellij ls

# Attach to existing session (after SSH reconnect)
zellij attach coding
zellij a coding
```

## Key Bindings Cheatsheet

Zellij uses a **modal** system. Press a mode key, then the action key.

### Quick Reference

| Action | Keys |
|--------|------|
| **Lock mode** (pass all keys to terminal) | Ctrl-g |
| **Pane mode** | Ctrl-p |
| **Tab mode** | Ctrl-t |
| **Resize mode** | Ctrl-n |
| **Scroll/Search mode** | Ctrl-s |
| **Session mode** | Ctrl-o |
| **Quit Zellij** | Ctrl-q |

### Pane Mode (Ctrl-p, then...)

| Key | Action |
|-----|--------|
| n | New pane |
| d | Split down |
| r | Split right |
| x | Close pane |
| f | Toggle fullscreen |
| Arrow keys | Navigate between panes |

### Tab Mode (Ctrl-t, then...)

| Key | Action |
|-----|--------|
| n | New tab |
| x | Close tab |
| r | Rename tab |
| Arrow keys | Switch tabs |
| 1-9 | Go to tab N |

### Session Mode (Ctrl-o, then...)

| Key | Action |
|-----|--------|
| d | Detach (session keeps running) |
| w | Session manager |

## Typical Workflow

```bash
# SSH into server
ssh dev

# Start or reattach session
zellij a coding || zellij -s coding

# Now you're in Zellij:
# - Tab 1: claude (Claude Code session)
# - Tab 2: shell (for git, builds, etc.)
# - Tab 3: logs / servers

# If SSH disconnects, just reconnect and:
zellij a coding
# Everything is exactly where you left it
```

## Auto-Start on SSH (optional)

Add to `~/.bashrc`:
```bash
if [[ -z "$ZELLIJ" && -n "$SSH_CONNECTION" ]]; then
    zellij attach coding 2>/dev/null || zellij -s coding
fi
```

This auto-attaches to your session on SSH login.

## Multiclauding Layout

Run multiple Claude instances in parallel — each tab has 3 panes:

```
Tab "task-1"                Tab "task-2"                Tab "task-3"
┌──────────┬─────────┐  ┌──────────┬─────────┐  ┌──────────┬─────────┐
│ claude   │  shell  │  │ claude   │  shell  │  │ claude   │  shell  │
│          │         │  │          │         │  │          │         │
│          ├─────────┤  │          ├─────────┤  │          ├─────────┤
│          │  logs   │  │          │  logs   │  │          │  logs   │
└──────────┴─────────┘  └──────────┴─────────┘  └──────────┴─────────┘
```

### Start with layout

```bash
# From the repo
zellij --layout scripts/zellij-multiclaud.kdl

# Or copy to your Zellij layouts dir
cp scripts/zellij-multiclaud.kdl ~/.config/zellij/layouts/
zellij --layout multiclaud
```

Then in each tab's left pane, run `claude` (or `c`). Use the right panes for shell commands and log tailing (`ell up`, `nam up`, etc.).

### Quick manual setup (no layout file)

```bash
zellij -s coding
# Ctrl-p → r (split right) → Ctrl-p → arrow to right pane
# Ctrl-p → d (split down) → done
# Ctrl-t → n (new tab) → repeat
```

## Config (optional)

Config file: `~/.config/zellij/config.kdl`

```kdl
// Example: change theme
theme "catppuccin-mocha"

// Example: set default layout
default_layout "compact"
```
