# VS Code Remote SSH

Connect VS Code to the Hetzner server for file browsing, markdown preview, and diff viewing.

## Setup

1. Install extension: **Remote - SSH** (by Microsoft)
2. VS Code picks up `~/.ssh/config` automatically
3. Ctrl+Shift+P → "Remote-SSH: Connect to Host..." → select `hetzner`
4. First time: VS Code installs its server component on the remote (~1 min)
5. Bottom-left corner shows "SSH: hetzner" when connected

## What It's For

| Task | Tool |
|------|------|
| Browsing/editing files | VS Code file explorer |
| Viewing markdown | VS Code preview (Ctrl+Shift+V) |
| Reviewing diffs | VS Code git diff viewer |
| Port forwarding | VS Code (automatic — app on :3000 becomes localhost:3000) |

## Tips

- **Port forwarding**: automatic when a process binds a port — check the Ports panel
- Install language extensions on the remote side when prompted
