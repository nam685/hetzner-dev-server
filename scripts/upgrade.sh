#!/usr/bin/env bash
# Upgrade system packages, Claude Code, and Zellij
set -euo pipefail

echo "=== Upgrading Dev Server ==="

echo "[1/3] System packages..."
sudo apt update && sudo apt upgrade -y

echo "[2/3] Claude Code CLI..."
npm update -g @anthropic-ai/claude-code
claude --version

echo "[3/3] Zellij..."
CURRENT=$(zellij --version 2>/dev/null || echo "none")
LATEST=$(curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest | jq -r .tag_name)
if [ "$CURRENT" != "zellij $LATEST" ]; then
    curl -L "https://github.com/zellij-org/zellij/releases/download/${LATEST}/zellij-x86_64-unknown-linux-musl.tar.gz" | sudo tar xz -C /usr/local/bin
    echo "  Zellij updated to $LATEST"
else
    echo "  Zellij already at $LATEST"
fi

echo ""
echo "=== Upgrade Complete ==="
