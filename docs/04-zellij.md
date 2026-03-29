# Zellij — Terminal Multiplexer

Zellij keeps your terminal session alive when you disconnect. Essential for phone/Termux — close the app, reconnect later, everything is still running.

## Install

Handled by `scripts/setup.sh`. To install manually:

```bash
ZELLIJ_VERSION=$(curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest | jq -r .tag_name)
curl -L "https://github.com/zellij-org/zellij/releases/download/${ZELLIJ_VERSION}/zellij-x86_64-unknown-linux-musl.tar.gz" | tar xz -C /tmp
sudo mv /tmp/zellij /usr/local/bin/
```

## Session Picker

On SSH/Mosh login, `.bashrc` shows a picker:

```
 Zellij:
  > New session      <- prompts for a name
    Skip (no Zellij)
    my-session       <- existing sessions, if any
```

Arrow keys or j/k to navigate, Enter to confirm.

## Aliases

```bash
z    # zellij
```

## Key Bindings

| Action | Keys |
|--------|------|
| Pane mode | Ctrl-p |
| Tab mode | Ctrl-t |
| Scroll mode | Ctrl-s |
| Session mode | Ctrl-o |
| Quit | Ctrl-q |

### Pane mode (Ctrl-p, then...)

| Key | Action |
|-----|--------|
| n | New pane |
| d | Split down |
| r | Split right |
| x | Close pane |
| f | Toggle fullscreen |
| Arrows | Navigate panes |

### Tab mode (Ctrl-t, then...)

| Key | Action |
|-----|--------|
| n | New tab |
| x | Close tab |
| Arrows / 1-9 | Switch tabs |

### Session mode (Ctrl-o, then...)

| Key | Action |
|-----|--------|
| d | Detach (session keeps running) |

## Scrolling in Termux

`Ctrl-s` → scroll mode → PgUp/PgDn → `Esc` to exit.

Add to `~/.termux/termux.properties` for on-screen PgUp/PgDn keys:
```
extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]
```
