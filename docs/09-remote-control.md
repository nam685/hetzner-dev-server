# Remote Control (Claude Code)

Claude Code supports remote control — control a running CLI session from the Claude mobile app or browser. Not currently in use; using Termux + Mosh instead for server access.

## How It Works

Start from inside a Claude Code session on the server:

```bash
/remote-control
```

This generates a URL/QR code. Open it on your phone to send prompts to the running Claude session on the server. Your full local environment (files, tools, MCP servers) stays available.

## When It's Useful

- Quick prompts from the Claude app without opening Termux
- Reviewing Claude's output from the phone while it runs on the server

## Limitations

- Requires an active Claude Code session already running on the server
- No raw shell access (use Termux for that)
- Needs internet + Anthropic relay
