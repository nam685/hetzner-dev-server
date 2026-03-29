# Server Configuration

Everything is handled by `scripts/setup.sh`. This doc describes what it does for reference.

## What setup.sh Does

1. **System update** — `apt update && apt upgrade`
2. **Installs**: build-essential, curl, git, htop, jq, ripgrep, fd-find, mosh, ufw, fail2ban
3. **Firewall (UFW)**: allows SSH (22) and Mosh (60000-61000/udp)
4. **Creates user `nam`**: sudo, passwordless sudo, copies root's authorized_keys
5. **Installs Claude Code** via native installer
6. **Installs Zellij** (latest release binary)
7. **4GB swap** at `/swapfile`
8. **SSH hardening**: disables root login and password auth, restarts sshd
9. **Adds to `~/.bashrc`**: PATH, Zellij session picker on SSH login, aliases

## Manual Steps After Setup

```bash
# 1. Authenticate Claude Code
claude

# 2. Set up GitHub SSH key for cloning private repos
ssh-keygen -t ed25519 -C "hetzner" -f ~/.ssh/id_ed25519_github
cat ~/.ssh/id_ed25519_github.pub
# Add to GitHub: repo → Settings → Deploy keys → Add deploy key
cat >> ~/.ssh/config << 'EOF'
Host github.com
    IdentityFile ~/.ssh/id_ed25519_github
EOF

# 3. Set git identity
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global init.defaultBranch main
```

## Firewall Ports

Open additional ports when deploying webapps:

```bash
sudo ufw allow 80    # HTTP
sudo ufw allow 443   # HTTPS
sudo ufw status
```
