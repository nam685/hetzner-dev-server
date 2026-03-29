# Connecting from Windows (WSL2)

WSL2 is the primary development machine. Code locally, SSH to the server to deploy.

## Prerequisites

- Windows 10/11 with WSL2: run `wsl --install` in PowerShell if not set up

## SSH Key

The key `~/.ssh/id_ed25519_hetzner_personal` in WSL2 is used for the server.

```bash
# Show public key (to add to a new server or Hetzner Console)
cat ~/.ssh/id_ed25519_hetzner_personal.pub
```

## SSH Config

`~/.ssh/config` should have:

```
Host hetzner
    HostName 46.224.162.194
    User nam
    IdentityFile ~/.ssh/id_ed25519_hetzner_personal
```

Then just: `ssh hetzner`

## GitHub SSH Key

Separate key for GitHub in WSL2:

```
Host github.com
    IdentityFile ~/.ssh/id_ed25519_github
    AddKeysToAgent yes
```

## Windows Terminal Tips

- Use [Windows Terminal](https://aka.ms/terminal) — proper color/Unicode support
- Set WSL2 as default profile
- Font: any Nerd Font (e.g. JetBrains Mono Nerd Font) for proper symbols
- Copy/paste: `Ctrl+Shift+C` / `Ctrl+Shift+V`
