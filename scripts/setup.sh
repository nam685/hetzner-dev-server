#!/usr/bin/env bash
# Hetzner Dev Server Setup Script
# Run as root on a fresh Ubuntu 24.04 server
# Usage: bash setup.sh

set -euo pipefail

# --- Configuration ---
USERNAME="nam"
NODE_VERSION="22"  # LTS

echo "=== Hetzner Dev Server Setup ==="

# --- System Updates ---
echo "[1/8] Updating system packages..."
apt update && apt upgrade -y

# --- Essential Tools ---
echo "[2/8] Installing essential tools..."
apt install -y \
    build-essential \
    curl \
    wget \
    git \
    htop \
    unzip \
    jq \
    tree \
    ripgrep \
    fd-find \
    mosh \
    ufw

# --- Firewall ---
echo "[3/8] Configuring firewall..."
ufw allow OpenSSH
ufw allow 60000:61000/udp  # Mosh
ufw --force enable

# --- Create User (if not exists) ---
echo "[4/8] Setting up user: $USERNAME..."
if ! id "$USERNAME" &>/dev/null; then
    adduser --disabled-password --gecos "" "$USERNAME"
    usermod -aG sudo "$USERNAME"
    # Allow sudo without password (convenience for dev server)
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME
    # Copy SSH keys
    mkdir -p /home/$USERNAME/.ssh
    cp /root/.ssh/authorized_keys /home/$USERNAME/.ssh/
    chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
    chmod 700 /home/$USERNAME/.ssh
    chmod 600 /home/$USERNAME/.ssh/authorized_keys
    echo "  User $USERNAME created."
else
    echo "  User $USERNAME already exists, skipping."
fi

# --- Node.js ---
echo "[5/8] Installing Node.js $NODE_VERSION..."
curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash -
apt install -y nodejs
echo "  Node.js $(node --version) installed."

# --- Claude Code CLI ---
echo "[6/8] Installing Claude Code CLI..."
npm install -g @anthropic-ai/claude-code
echo "  Claude Code $(claude --version 2>/dev/null || echo 'installed') ready."

# --- Zellij ---
echo "[7/8] Installing Zellij..."
ZELLIJ_VERSION=$(curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest | jq -r .tag_name)
curl -L "https://github.com/zellij-org/zellij/releases/download/${ZELLIJ_VERSION}/zellij-x86_64-unknown-linux-musl.tar.gz" | tar xz -C /usr/local/bin
chmod +x /usr/local/bin/zellij
echo "  Zellij ${ZELLIJ_VERSION} installed."

# --- Swap ---
echo "[8/8] Setting up swap..."
if [ ! -f /swapfile ]; then
    fallocate -l 4G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile none swap sw 0 0' >> /etc/fstab
    echo "  4GB swap created."
else
    echo "  Swap already exists, skipping."
fi

# --- SSH Hardening ---
echo "Hardening SSH..."
sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
systemctl restart sshd

# --- Shell Config for User ---
echo "Configuring shell for $USERNAME..."
su - $USERNAME -c 'cat >> ~/.bashrc << "BASHEOF"

# --- Dev Server Config ---
# Auto-attach Zellij on SSH login
if [[ -z "$ZELLIJ" && -n "$SSH_CONNECTION" ]]; then
    zellij attach coding 2>/dev/null || zellij -s coding
fi

# Aliases
alias c="claude"
alias z="zellij"
alias za="zellij attach coding 2>/dev/null || zellij -s coding"
alias gs="git status"
alias gp="git push"
alias update="sudo apt update && sudo apt upgrade -y && npm update -g @anthropic-ai/claude-code"
BASHEOF'

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. Open a NEW terminal and SSH as: ssh $USERNAME@$(curl -s ifconfig.me)"
echo "  2. Run: claude auth"
echo "  3. Start coding: claude"
echo ""
echo "WARNING: Root SSH login is now disabled."
echo "Make sure you can SSH as $USERNAME before closing this session!"
