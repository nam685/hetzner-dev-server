# Claude Code Anywhere — Hetzner Dev Server

---

## The Problem

- Claude Code CLI is powerful but tied to your laptop terminal
- Context is lost when switching devices
- Can't code from your phone without a full terminal setup
- Local machines vary — different OS, specs, configs

---

## The Solution

One always-on dev server in the cloud. Connect from any device.

- **Hetzner Cloud ARM64** — EUR 8/month
- **Claude Code CLI** — Claude Max/Teams subscription
- **Zellij** — sessions persist across disconnects
- **SSH from anywhere** — laptop, phone, tablet, browser

---

## Architecture

```
                    ┌─────────────────────┐
  Mac (work)    ──→ │                     │
  Windows (home)──→ │  Hetzner Server     │
  Phone (Claude)──→ │  Ubuntu 24.04       │
  VS Code       ──→ │  Zellij + Claude    │
                    └─────────────────────┘
```

One server. One session. Any device picks up where you left off.

---

## Connect from Any Device

| Device | How |
|--------|-----|
| Mac laptop | `ssh dev` → Zellij auto-attaches |
| Windows laptop | WSL2 → `ssh dev` or `mosh dev` |
| Android phone | Claude app (Remote Control) or Termux + Mosh |
| VS Code | Remote SSH extension → `dev` |

---

## Remote Control (New!)

Control Claude Code from your phone — no SSH needed.

1. On server: `/remote-control` inside Claude Code
2. Scan QR code on your phone
3. Type or voice-dictate prompts from the Claude app
4. Claude executes on the server, streams results back

Your full environment stays on the server — filesystem, tools, MCP servers.

---

## Live Demo: PR from Every Device

We've created PRs from:

- **Android phone** — Termux + SSH + voice input (PR #1)
- **Windows laptop** — WSL2 + SSH (PR #2)
- **Phone via Remote Control** — Claude app, no terminal needed

Same server, same session, same repo.

---

## Phone Workflow: Termux + SSH

```
1. Open Termux
2. ssh dev                    (auto-attaches Zellij)
3. claude                     (start coding)
4. Voice dictate your prompt
5. Claude writes code, makes PR
6. Tap link → review in GitHub app
7. Close Termux — session lives on
```

Phone gets a single-pane layout automatically (detected by terminal width).

---

## Phone Workflow: Remote Control

```
1. SSH into server from laptop (or reuse Zellij session)
2. /remote-control            (generates QR code)
3. Scan QR on phone
4. Prompt Claude from the app
5. Close app — session stays alive
6. Next time: /remote-control again
```

Best for quick tasks. Use Termux when you need full shell access.

---

## Multiclauding

Run multiple Claude instances in parallel with Zellij layouts:

- 3 tabs x 3 panes = up to 9 Claude agents
- Each working on a different task
- `new-claude ~/project` opens a fresh workspace tab

---

## Cost

| Item | Cost |
|------|------|
| Hetzner CAX21 (4 vCPU, 8GB RAM) | ~EUR 8/month |
| Claude Teams | $30/user/month |
| **Total** | **~$40/month** |

No GPU needed. All AI runs through Anthropic's API.

---

## Setup in 5 Minutes

```bash
# 1. Provision server (Hetzner Cloud Console)
# 2. Run setup script
scp scripts/setup.sh root@SERVER_IP:~
ssh root@SERVER_IP bash setup.sh

# 3. Authenticate Claude Code
claude

# 4. Start coding
zellij && claude
```

Full docs + scripts in the repo.

---

## Key Takeaways

- **EUR 8/month** for an always-on dev server
- **Any device** — Mac, Windows, phone, browser
- **Session persistence** — pick up where you left off
- **Remote Control** — Claude app on phone, no terminal needed
- **Voice input** — practical phone-first coding
- **Multiclauding** — parallel Claude agents in Zellij tabs
