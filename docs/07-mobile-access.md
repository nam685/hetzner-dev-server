# Coding from Your Phone

Your dev environment lives on Hetzner, always running. Connect from your S23 with Termux — one fullscreen pane is all you need. Claude Code handles file edits, shell commands (`!command`), and background processes.

## How It Works

```
S23 (Termux + Mosh) → Internet → Hetzner Server (Zellij + Claude Code)
```

- Server runs 24/7
- Zellij keeps your session alive across disconnects
- Claude Code does the heavy lifting — you voice/type prompts
- Works on any connection: WiFi, 4G/5G, airport lounge, coffee shop

## Claude App vs SSH + Claude Code CLI

| | Claude App | SSH → Claude Code CLI |
|---|---|---|
| **What it is** | Chat about code | Agent working in your codebase |
| **Filesystem** | None (isolated conversations) | Full access to your projects |
| **Can run commands** | No | Yes (tests, builds, git, servers) |
| **Session persistence** | Conversation history only | Zellij keeps everything alive |
| **Multi-file edits** | Copy-paste manually | Claude edits files directly |
| **Best for** | Quick questions, brainstorming | Actual implementation, shipping |

**Use both**: Claude app for quick questions, SSH for actual work.

## Setup: Termux (Android)

Termux is a full Linux terminal on Android — free, open source, no ads, no root needed. Install from [F-Droid](https://f-droid.org/en/packages/com.termux/) (not Google Play — that version is outdated).

```bash
# First run
pkg update && pkg upgrade
pkg install openssh mosh

# Generate SSH key
ssh-keygen -t ed25519 -C "s23"
cat ~/.ssh/id_ed25519.pub
# Copy this and add to server: ~/.ssh/authorized_keys

# SSH config
mkdir -p ~/.ssh
cat >> ~/.ssh/config << 'EOF'
Host dev
    HostName YOUR_SERVER_IP
    User nam
    IdentityFile ~/.ssh/id_ed25519
EOF
chmod 600 ~/.ssh/config

# Enable clickable URLs (for PR links → GitHub app)
echo "terminal-onclick-url-open=true" >> ~/.termux/termux.properties
termux-reload-settings
```

Optional: install [Termux:Styling](https://github.com/termux/termux-styling) from F-Droid for better fonts (JetBrains Mono) and color schemes. Pinch-to-zoom adjusts font size.

## Single-Pane Workflow

No multi-pane split needed on a phone screen. Claude Code replaces all the extra panes:

| Laptop pane | Phone equivalent |
|---|---|
| Shell pane | `!command` inside Claude Code |
| Logs pane | Claude runs `ell up` / `nam up` in background |
| PR review | Tap PR link → opens GitHub app |

### Session setup

The server `.bashrc` auto-detects your terminal width. Phone (< 100 columns) gets a dedicated `phone` session — just one pane, no tabs or splits. Laptop gets the `coding` session with multi-pane layouts.

### Daily workflow

```
1. Open Termux
2. ssh dev          (auto-attaches to "phone" Zellij session)
3. Run: claude      (or just 'c')
4. Voice or type: "implement auth middleware, then make a PR"
5. Claude does the work, creates PR, outputs link
6. Tap PR link → GitHub app → review diff, approve
7. Close Termux — session stays alive on server
```

Or with Mosh for resilient connection:
```
mosh dev
```

## Voice Input

The phone keyboard is the bottleneck. Voice makes this practical.

### How

1. Tap the microphone icon on Gboard (or hold spacebar)
2. Dictate your prompt naturally
3. Edit if needed, then hit Enter

### Tips

- Speak in natural language — Claude understands intent, not syntax
- Say "new line" or "enter" to break up multi-line prompts
- For code-heavy terms (file paths, function names), type those parts
- Works best for: task descriptions, bug reports, review requests, architecture decisions

## Alternative Apps

If you want a GUI SSH app instead of Termux:

| App | Price | Notes |
|-----|-------|-------|
| **Termius** | Free / $10/mo pro | Good UX, key management, Mosh support |
| **JuiceSSH** | Free | Simple, popular |

Termux is more flexible. These are quicker to set up.

## Security

- Use SSH keys, never passwords (already configured)
- Termux stores keys in its app-private storage
- Set up biometric lock on Termux (Settings → Security)
- Consider a passphrase on your SSH key
