#!/usr/bin/env bash
# Hetzner Dev Server Setup Script
# Run as root on a fresh Ubuntu 24.04 server
# Usage: bash setup.sh

set -euo pipefail

# --- Configuration ---
USERNAME="nam"

echo "=== Hetzner Dev Server Setup ==="

# --- System Updates ---
echo "[1/7] Updating system packages..."
apt update && apt upgrade -y

# --- Essential Tools ---
echo "[2/7] Installing essential tools..."
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
echo "[3/7] Configuring firewall..."
ufw allow OpenSSH
ufw allow 60000:61000/udp  # Mosh
ufw --force enable

# --- Create User (if not exists) ---
echo "[4/7] Setting up user: $USERNAME..."
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

# --- Claude Code CLI (native installer, no Node.js needed) ---
echo "[5/7] Installing Claude Code CLI..."
su - $USERNAME -c 'curl -fsSL https://claude.ai/install.sh | bash'
echo "  Claude Code installed."

# --- Zellij ---
echo "[6/7] Installing Zellij..."
ZELLIJ_VERSION=$(curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest | jq -r .tag_name)
ARCH=$(uname -m)
if [ "$ARCH" = "aarch64" ]; then
    ZELLIJ_ARCH="aarch64-unknown-linux-musl"
else
    ZELLIJ_ARCH="x86_64-unknown-linux-musl"
fi
curl -L "https://github.com/zellij-org/zellij/releases/download/${ZELLIJ_VERSION}/zellij-${ZELLIJ_ARCH}.tar.gz" | tar xz -C /usr/local/bin
chmod +x /usr/local/bin/zellij
echo "  Zellij ${ZELLIJ_VERSION} installed."

# --- Swap ---
echo "[7/7] Setting up swap..."
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
systemctl restart ssh

# --- Shell Config for User ---
echo "Configuring shell for $USERNAME..."
su - $USERNAME -c 'cat >> ~/.bashrc << "BASHEOF"

# --- Dev Server Config ---
export PATH="$HOME/.local/bin:$PATH"

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
alias update="sudo apt update && sudo apt upgrade -y && claude update"
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
