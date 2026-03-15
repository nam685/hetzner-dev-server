# VS Code Remote SSH

VS Code Remote SSH connects to the Hetzner server for file browsing, markdown preview, and diff viewing. All actual coding happens in the terminal (iTerm2 / Zellij + Claude Code).

## Setup

### 1. Install Extension

In VS Code: Extensions → search "Remote - SSH" → Install (by Microsoft)

### 2. Connect

VS Code picks up `~/.ssh/config` automatically, so if you've configured the `dev` host:

- Cmd+Shift+P → "Remote-SSH: Connect to Host..." → select `dev`
- First time: VS Code installs its server component on the remote machine
- Bottom-left corner shows "SSH: dev" when connected

### 3. Open a Folder

- File → Open Folder → select your project directory on the server

## What VS Code is For (in this setup)

| Use | Tool |
|-----|------|
| Writing code | Terminal → Claude Code |
| Running commands | Terminal → `!command` or shell pane |
| Browsing files | VS Code file explorer |
| Viewing markdown | VS Code preview (Cmd+Shift+V) |
| Reviewing diffs | VS Code git diff viewer / GitLens |
| Port forwarding | VS Code (automatic) |

## Useful Extensions (install on remote)

- **GitLens** — git blame, file history, diff viewer
- Language extensions for syntax highlighting

## Tips

- **Port forwarding**: VS Code auto-forwards ports. Dev server on port 3000 becomes localhost:3000 on your Mac.
- **Settings sync**: Use VS Code's built-in Settings Sync to keep config consistent across machines.
- **Terminal in VS Code**: You can run `zellij a coding` in VS Code's terminal, but iTerm2 is better for the actual Claude sessions.
