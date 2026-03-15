# Hetzner Dev Server

Remote development server on Hetzner Cloud running Claude Code CLI — code from anywhere with an internet connection.

## Overview

- **Server**: Hetzner Cloud CX32 (4 vCPU, 8GB RAM, 80GB disk) — ~EUR 7/month
- **AI**: Claude Code CLI with Claude Max subscription ($200/month)
- **OS**: Ubuntu 24.04 LTS
- **Access**: SSH from any laptop (Mac/Windows WSL2) / VS Code Remote / Android phone (Termux + Mosh)
- **Session persistence**: Zellij (modern tmux alternative with sane keybindings)

## Connecting from Any Device

| Device | How |
|--------|-----|
| Mac laptop (work) | iTerm2 → `ssh dev` or `new-claude ~/project` (local) |
| Windows laptop (personal) | WSL2 → `ssh dev` or `mosh dev` |
| Android phone (S23) | Termux → `mosh dev -- zellij a coding` (single pane + voice) |
| VS Code (any laptop) | Remote SSH extension → connect to `dev` |

All connections land in the same Zellij session on the server. Pick up where you left off from any device.

## Quick Start

```bash
# 1. Provision server via Hetzner Cloud Console or CLI
#    See docs/01-hetzner-setup.md

# 2. SSH into server and run setup script
scp scripts/setup.sh root@YOUR_SERVER_IP:~
ssh root@YOUR_SERVER_IP
bash setup.sh

# 3. Authenticate Claude Code
claude auth

# 4. Start coding
zellij
claude
```

## Documentation

| File | Description |
|------|-------------|
| [docs/01-hetzner-setup.md](docs/01-hetzner-setup.md) | Hetzner account + server provisioning |
| [docs/02-server-config.md](docs/02-server-config.md) | Server hardening, user setup, SSH keys |
| [docs/03-claude-code.md](docs/03-claude-code.md) | Claude Code CLI install + auth |
| [docs/04-zellij.md](docs/04-zellij.md) | Zellij setup + cheatsheet |
| [docs/05-vscode-remote.md](docs/05-vscode-remote.md) | VS Code Remote SSH setup |
| [docs/06-maintenance.md](docs/06-maintenance.md) | Backups, upgrades, cost management |
| [docs/07-mobile-access.md](docs/07-mobile-access.md) | Coding from Android phone (Termux, Mosh, voice input) |

## Scripts

| File | Description |
|------|-------------|
| [scripts/setup.sh](scripts/setup.sh) | Full server setup (run once after provisioning) |
| [scripts/upgrade.sh](scripts/upgrade.sh) | Update system packages + Claude Code |
| [scripts/new-claude](scripts/new-claude) | Open a new Zellij tab with 3-pane Claude workspace |
| [scripts/zellij-multiclaud.kdl](scripts/zellij-multiclaud.kdl) | Zellij layout for multiclauding (3 tabs × 3 panes) |
