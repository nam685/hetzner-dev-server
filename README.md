# Hetzner Dev Server

Remote server on Hetzner Cloud for deploying webapps, accessible from Windows (primary) and Android phone via Termux.

## Overview

- **Server**: Hetzner Cloud CX32 (4 vCPU, 8GB RAM, 80GB SSD) — ~EUR 7/month
- **OS**: Ubuntu 24.04 LTS
- **Access**: SSH from Windows WSL2 / Mosh from Android (Termux)
- **Session persistence**: Zellij (for phone sessions — keeps session alive across disconnects)

## Connecting

| Device | How |
|--------|-----|
| Windows WSL2 | `ssh hetzner` |
| Android (Termux) | `hetzner` (mosh alias) |
| VS Code | Remote SSH → connect to `hetzner` |

## Quick Start (new server)

```bash
# 1. Create server in Hetzner Console — Ubuntu 24.04, add your SSH key
# 2. Connect as root and run setup
ssh -i ~/.ssh/id_ed25519_hetzner_personal root@SERVER_IP
curl -fsSL https://raw.githubusercontent.com/nam685/hetzner-dev-server/main/scripts/setup.sh | bash
# 3. Reconnect as nam
ssh hetzner
# 4. Authenticate Claude Code
claude
```

## Documentation

| File | Description |
|------|-------------|
| [docs/01-hetzner-setup.md](docs/01-hetzner-setup.md) | Server provisioning + SSH config |
| [docs/02-server-config.md](docs/02-server-config.md) | What setup.sh does |
| [docs/03-claude-code.md](docs/03-claude-code.md) | Claude Code install + auth |
| [docs/04-zellij.md](docs/04-zellij.md) | Zellij cheatsheet |
| [docs/05-vscode-remote.md](docs/05-vscode-remote.md) | VS Code Remote SSH |
| [docs/06-maintenance.md](docs/06-maintenance.md) | Backups, upgrades, cost management |
| [docs/07-mobile-access.md](docs/07-mobile-access.md) | Termux + Mosh phone setup |
| [docs/08-windows-wsl2.md](docs/08-windows-wsl2.md) | Windows WSL2 SSH setup |

## Scripts

| File | Description |
|------|-------------|
| [scripts/setup.sh](scripts/setup.sh) | Full server setup — run once after provisioning |
| [scripts/upgrade.sh](scripts/upgrade.sh) | Update system packages + Claude Code |
