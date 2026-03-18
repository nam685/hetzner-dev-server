# Remote Control (Claude Code CLI → Phone/Browser)

Control a running Claude Code CLI session on your Hetzner server from the Claude mobile app or any browser — no SSH needed from the phone side.

## How It Works

```
Hetzner Server (Claude Code in Zellij) → Anthropic Relay → Claude App (phone/browser)
```

1. You start Remote Control **from the CLI** on the server
2. It generates a URL and QR code
3. Open the URL on your phone/browser to connect
4. Your full local environment stays available — filesystem, MCP servers, tools, project config
5. Nothing moves to the cloud — Claude keeps running locally on the server

## Remote Control vs Termux+SSH

| | Remote Control | Termux+SSH |
|---|---|---|
| **Setup** | `/remote-control` in CLI | SSH keys, Termux config |
| **Connection** | Through Anthropic relay | Direct SSH/Mosh |
| **Firewall** | No changes needed | Ports 22 + 60000-61000 |
| **UI** | Claude app (native mobile UX) | Terminal (Termux) |
| **Capabilities** | Claude Code commands only | Full shell access |
| **Offline/local** | Needs internet + Anthropic relay | Needs internet + SSH |
| **Best for** | Quick tasks, reviewing, prompting Claude | Full dev work, shell access, multi-pane |

**Use both**: Remote Control for quick Claude interactions from the app. Termux+SSH when you need raw shell access, Zellij panes, or `!command`.

## Starting a Remote Control Session

Each time you want to connect from your phone, you need to start Remote Control from the server:

```bash
# Option A: from a new terminal
ssh dev
cd ~/your-project
claude remote-control

# Option B: from inside an existing Claude Code session
/remote-control
```

This displays a **URL and QR code** in the terminal. Scan the QR code or open the URL on your phone.

You need to run this each session — it's not a persistent pairing.

## Daily Workflow

```
1. SSH into server (from laptop, or use existing Zellij session)
2. Run /remote-control inside Claude Code (or `claude remote-control` from shell)
3. Scan QR code / open URL on phone
4. Type or voice-dictate prompts from the Claude app
5. Claude executes on the server, streams results back to your phone
6. Close the app when done — the CLI session stays alive in Zellij
7. Next time, run /remote-control again to reconnect
```

## Tips

- **Voice input works great** — the Claude app has native voice support, perfect for phone
- **Conversation stays in sync** — you can send messages from terminal, browser, and phone interchangeably
- **Zellij keeps it alive** — even if your SSH drops, the CLI session persists; just SSH back in and run `/remote-control` again
- **No inbound ports needed** — the CLI makes outbound HTTPS requests only

## Security

- All traffic is encrypted over TLS through Anthropic's relay
- No inbound ports need to be opened on the server
- The CLI makes outbound HTTPS requests only — same transport as normal Claude Code usage
- Each Remote Control session generates a unique URL

---

> Remote Control makes the Hetzner server truly phone-first — no terminal app needed for most Claude interactions.
