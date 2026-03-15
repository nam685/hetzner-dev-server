# Connecting from Windows (WSL2)

WSL2 gives you a full Linux terminal on Windows — SSH and Mosh work the same as on Mac/Linux.

## Prerequisites

- Windows 10/11 with WSL2 installed
- Any distro (Ubuntu recommended): `wsl --install` in PowerShell

## SSH Setup

```bash
# Generate key (in WSL2 terminal)
ssh-keygen -t ed25519 -C "windows-wsl2"

# Show public key — copy this
cat ~/.ssh/id_ed25519.pub
```

Add the public key to the server:

```bash
# Option A: from WSL2 directly (if you have another way to access the server)
ssh-copy-id -i ~/.ssh/id_ed25519.pub nam@YOUR_SERVER_IP

# Option B: from your Mac (already connected)
# On Mac, paste the WSL2 public key into:
ssh dev 'cat >> ~/.ssh/authorized_keys' <<< 'ssh-ed25519 AAAA... windows-wsl2'
```

## SSH Config

```bash
cat >> ~/.ssh/config << 'EOF'
Host dev
    HostName YOUR_SERVER_IP
    User nam
    IdentityFile ~/.ssh/id_ed25519
    ForwardAgent yes
EOF
chmod 600 ~/.ssh/config
```

Test: `ssh dev`

## Optional: Mosh

Mosh handles flaky connections and roaming (WiFi → ethernet, sleep/resume). Recommended if your connection drops often.

```bash
sudo apt install mosh
mosh dev -- zellij attach coding
```

## Daily Workflow

```bash
# Connect and attach to Zellij session
ssh dev
# (Zellij auto-attaches via .bashrc)

# Or with Mosh for resilience
mosh dev -- zellij attach coding

# Open a new multiclauding tab
new-claude ~/projects/my-repo
```

You land in the same Zellij session as Mac/phone. All tabs and panes are shared.

## Windows Terminal Tips

- Use [Windows Terminal](https://aka.ms/terminal) (not cmd.exe) for proper color/Unicode support
- Set WSL2 as default profile in Windows Terminal settings
- Font: any Nerd Font (e.g. JetBrains Mono Nerd Font) for Zellij icons
- Copy/paste: `Ctrl+Shift+C` / `Ctrl+Shift+V` in Windows Terminal

## Git SSH Agent

To use GitHub from the server via SSH agent forwarding:

```bash
# Start ssh-agent in WSL2
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Verify forwarding works on the server
ssh dev 'ssh -T git@github.com'
```

If you use a separate GitHub key, add that one too:

```bash
ssh-add ~/.ssh/github_key
```

---

*Claude from Windows was here.* This PR was created from a Windows machine to prove the WSL2 workflow works end-to-end.
