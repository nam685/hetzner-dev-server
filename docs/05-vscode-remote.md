# VS Code Remote SSH

VS Code Remote SSH lets you run VS Code on your Mac while executing everything on the Hetzner server. It's seamless — file explorer, terminal, extensions, everything runs remotely.

## Setup

### 1. Install Extension

In VS Code: Extensions → search "Remote - SSH" → Install (by Microsoft)

### 2. Configure SSH Host

If you already added the SSH config from the Hetzner setup guide, VS Code will pick it up automatically.

Otherwise, in VS Code: Cmd+Shift+P → "Remote-SSH: Open SSH Configuration File" → select `~/.ssh/config` and add:

```
Host dev
    HostName YOUR_SERVER_IP
    User nam
    IdentityFile ~/.ssh/id_ed25519
    ForwardAgent yes
```

### 3. Connect

- Cmd+Shift+P → "Remote-SSH: Connect to Host..." → select `dev`
- VS Code will install its server component on the remote machine (first time only)
- Once connected, the bottom-left corner shows "SSH: dev"

### 4. Open a Folder

- File → Open Folder → select your project directory on the server

## Using Claude Code in VS Code

Once connected via Remote SSH, open the integrated terminal (Ctrl+`) and run:

```bash
claude
```

Claude Code CLI works in the VS Code terminal just like any SSH terminal.

## Useful Extensions (install on remote)

When connected, install extensions on the remote server:

- **GitHub Copilot** — if you also use it alongside Claude
- **GitLens** — enhanced git blame/history
- Language extensions for your stack

## Tips

- **Terminal persistence**: VS Code's terminal doesn't survive disconnects like Zellij does. For long-running Claude sessions, use Zellij inside VS Code's terminal: just run `zellij a coding` in the VS Code terminal.
- **Port forwarding**: VS Code auto-forwards ports. If your dev server runs on port 3000, VS Code makes it available at localhost:3000 on your Mac.
- **Settings sync**: Use VS Code's built-in Settings Sync to keep your config consistent across machines.

## Comparison: Pure SSH vs VS Code Remote

| Feature | SSH + Zellij | VS Code Remote |
|---------|-------------|----------------|
| Session persistence | Zellij handles it | Need Zellij in terminal |
| File browsing | Terminal (ls, find) | Visual file explorer |
| Code editing | Vim/Nano + Claude | VS Code editor + Claude |
| Git | Terminal | Visual git UI |
| Port forwarding | Manual SSH tunnels | Automatic |
| Works on iPad/phone | Yes (any SSH client) | No |
| Bandwidth | Minimal | More (UI rendering) |

**Recommendation**: Use both. VS Code Remote for focused project work, pure SSH + Zellij when on the go or on low-bandwidth connections.
