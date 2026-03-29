# Mobile Access (Android + Termux)

Connect to the server from your phone via Mosh + Zellij. Mosh handles flaky mobile connections; Zellij keeps your session alive across disconnects.

## Setup

Install Termux from [F-Droid](https://f-droid.org/en/packages/com.termux/) (not Google Play — that version is outdated).

```bash
# In Termux
pkg update && pkg upgrade
pkg install openssh mosh

# Generate SSH key
ssh-keygen -t ed25519 -C "termux"
cat ~/.ssh/id_ed25519.pub
# Copy this output, then on the server add it:
# echo "PASTE_KEY_HERE" >> ~/.ssh/authorized_keys
```

## Connect

```bash
# Add alias to ~/.bashrc in Termux
echo 'alias hetzner="mosh --ssh=\"ssh -i ~/.ssh/id_ed25519\" nam@46.224.162.194"' >> ~/.bashrc
source ~/.bashrc

# Connect
hetzner
```

On connect, the Zellij session picker appears — create a new session or attach to an existing one.

## Quality of Life

Add to `~/.termux/termux.properties` for on-screen navigation keys:
```
extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]
terminal-onclick-url-open=true
```
Then run `termux-reload-settings`.

## Scrolling

Use Zellij scroll mode: `Ctrl-s` → PgUp/PgDn → `Esc` to exit.

## Security

- SSH key auth only (no passwords)
- Termux stores keys in app-private storage
- Consider a passphrase on your SSH key for extra protection if the phone is lost
