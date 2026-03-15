# Coding from Your Phone

The whole point of this setup: your dev environment lives on Hetzner, always running. Connect from any device with an internet connection.

## How It Works

```
Phone (SSH client) → Internet → Hetzner Server (Zellij + Claude Code)
```

- Server runs 24/7
- Zellij keeps your session alive across disconnects
- Claude Code does the heavy lifting — you just type prompts
- Works on any connection: WiFi, 4G/5G, airport lounge, coffee shop

## iPhone SSH Apps

| App | Price | Notes |
|-----|-------|-------|
| **Termius** | Free (basic) / $10/mo (pro) | Best UX, syncs across devices, key management |
| **Blink Shell** | $20 one-time | Power user favorite, Mosh support, great keyboard |
| **a]Shell** | Free | Basic but functional |
| **Prompt 3** (Panic) | $20 one-time | Clean design, good keyboard |

**Recommendation**: **Blink Shell** for power users (Mosh support = no dropped connections), **Termius** for convenience.

## Android SSH Apps

| App | Price | Notes |
|-----|-------|-------|
| **Termius** | Free (basic) | Same as iOS version |
| **JuiceSSH** | Free | Popular, good UX |
| **Termux** | Free | Full terminal emulator, runs local tools too |

## Mosh (Mobile Shell) — Recommended

Mosh is SSH designed for mobile. It handles:
- Roaming (switch from WiFi to cellular seamlessly)
- Intermittent connectivity (no dropped sessions)
- Local echo (feels responsive even on high latency)

### Install on server
```bash
sudo apt install mosh
sudo ufw allow 60000:61000/udp   # Mosh port range
```

### Connect from phone
Use Blink Shell (iOS) or Termius — both support Mosh natively.

```bash
mosh nam@YOUR_SERVER_IP
```

### Mosh + Zellij Workflow
```bash
# From phone:
mosh nam@YOUR_SERVER_IP -- zellij a coding
# Instant reconnect to your session, even on flaky connections
```

## Keyboard Tips for Phone Coding

The phone keyboard is the main limitation. Tips:
- **Get a Bluetooth keyboard** — even a small foldable one makes a huge difference
- **Blink Shell** has excellent keyboard customization (remap Caps Lock → Ctrl, etc.)
- **Claude Code is text-in, text-out** — typing natural language prompts is easier than writing code directly
- Focus on **code review, debugging prompts, and architecture decisions** on phone
- Save heavy implementation sessions for when you have a proper keyboard

## iPad / Tablet

Same SSH apps work on iPad. With a keyboard (Magic Keyboard, etc.), it's nearly a laptop replacement for this workflow.

## Workflow: Phone Coding Session

```
1. Open Blink Shell / Termius
2. Connect: mosh dev   (or ssh dev)
3. Reattach: zellij a coding
4. You're back in your Claude Code session
5. Ask Claude to implement features, fix bugs, review code
6. git commit and push when done
7. Close app — session stays alive on server
```

## Security Note

- Use SSH keys, never passwords (already configured)
- Your SSH key lives on your phone (the SSH app manages it)
- Enable biometric lock on your SSH app
- Consider using a passphrase on your SSH key
