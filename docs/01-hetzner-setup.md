# Hetzner Cloud Setup

## 1. Create Hetzner Account

1. Go to https://console.hetzner.cloud/
2. Sign up, verify email, add payment method
3. Create a new project

## 2. Add SSH Key

In Hetzner Console → Security → SSH Keys → Add SSH Key, paste your public key:

```bash
# In WSL2
cat ~/.ssh/id_ed25519_hetzner_personal.pub
```

## 3. Create Server

1. Go to your project → Servers → Add Server
2. Settings:
   - **Location**: Falkenstein (FSN1) or Nuremberg (NBG1) — cheapest EU
   - **Image**: Ubuntu 24.04
   - **Type**: CX32 (4 vCPU, 8GB RAM, 80GB SSD) — ~EUR 7/month
   - **SSH Key**: select the key you added
3. Click "Create & Buy Now"

## 4. First Connection + Setup

```bash
# Connect as root (first time only)
ssh -i ~/.ssh/id_ed25519_hetzner_personal root@SERVER_IP

# Run setup script
curl -fsSL https://raw.githubusercontent.com/nam685/hetzner-dev-server/main/scripts/setup.sh | bash
```

The script creates user `nam`, copies your SSH key, installs tools, disables root login.

**Before the root session ends**, test in a new terminal:
```bash
ssh -i ~/.ssh/id_ed25519_hetzner_personal nam@SERVER_IP
```

## 5. SSH Config (WSL2)

Add to `~/.ssh/config`:
```
Host hetzner
    HostName SERVER_IP
    User nam
    IdentityFile ~/.ssh/id_ed25519_hetzner_personal
```

Then just: `ssh hetzner`

## Server Sizes Reference

| Type | vCPU | RAM | Disk | ~EUR/month |
|------|------|-----|------|------------|
| CX22 | 2 | 4 GB | 40 GB | 3.79 |
| CX32 | 4 | 8 GB | 80 GB | 6.80 |
| CX42 | 8 | 16 GB | 160 GB | 16.40 |

All plans include 20 TB monthly traffic. Upgrading: Hetzner Console → Server → Rescale (takes a reboot).

## Cost Management

- Servers are billed hourly even when stopped (disk is still reserved)
- To stop billing: **delete** the server (snapshot first!)
- **Snapshots**: EUR 0.0108/GB/month — cheap insurance
- Create a snapshot: Hetzner Console → Server → Snapshots → Create
