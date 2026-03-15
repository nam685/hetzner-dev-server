# Hetzner Cloud Setup

## 1. Create Hetzner Account

1. Go to https://console.hetzner.cloud/
2. Sign up, verify email, add payment method
3. Create a new project (e.g. "Dev Server")

## 2. Generate SSH Key (if you don't have one)

On your Mac:
```bash
ssh-keygen -t ed25519 -C "your@email.com"
cat ~/.ssh/id_ed25519.pub
```

Add this public key in Hetzner Console → Security → SSH Keys.

## 3. Create Server

**Via Console (web UI):**
1. Go to your project → Servers → Add Server
2. Settings:
   - **Location**: Falkenstein (FSN1) or Nuremberg (NBG1) — cheapest EU locations
   - **Image**: Ubuntu 24.04
   - **Type**: Shared vCPU → CX32 (4 vCPU, 8GB RAM, 80GB SSD) — ~EUR 6.80/month
   - **Networking**: Public IPv4 + IPv6
   - **SSH Key**: Select the key you added
   - **Name**: `dev-server` (or whatever you like)
3. Click "Create & Buy Now"

**Via CLI (hcloud):**
```bash
# Install hcloud CLI
brew install hcloud

# Configure
hcloud context create dev
# Enter your API token from Hetzner Console → Security → API Tokens

# Create server
hcloud server create \
  --name dev-server \
  --type cx32 \
  --image ubuntu-24.04 \
  --location fsn1 \
  --ssh-key your-key-name
```

## 4. First SSH Connection

```bash
# First time only — root, to run setup.sh (which creates user 'nam')
ssh root@YOUR_SERVER_IP
```

The IP is shown in the Hetzner Console or in the `hcloud server list` output.

After running setup.sh, root SSH is disabled. Add to your `~/.ssh/config` for all future connections:
```
Host dev
    HostName YOUR_SERVER_IP
    User nam
    IdentityFile ~/.ssh/id_ed25519
    ForwardAgent yes
```

Then just: `ssh dev`

## Server Sizes Reference

| Type | vCPU | RAM | Disk | ~EUR/month |
|------|------|-----|------|------------|
| CX22 | 2 | 4 GB | 40 GB | 3.79 |
| CX32 | 4 | 8 GB | 80 GB | 6.80 |
| CX42 | 8 | 16 GB | 160 GB | 16.40 |

All plans include 20 TB monthly traffic and 1 IPv4 address (EU locations). US locations cost ~20% more.

**Note**: Hetzner prices increase April 1, 2026 for new and existing products.

Upgrading is easy: Hetzner Console → Server → Rescale. Takes a reboot (~1 min).

## Cost Management

- **Servers are billed hourly** even when stopped (disk is still reserved)
- To stop billing: **delete** the server (you lose data — snapshot first!)
- **Snapshots**: EUR 0.0108/GB/month — cheap way to preserve state
- Create a snapshot before deleting: Hetzner Console → Server → Snapshots → Create
- Recreate from snapshot anytime

### Monthly Cost Estimate

| Item | Cost |
|------|------|
| CX32 server | ~EUR 7 |
| Claude Max subscription | $100-200 (see below) |
| **Total** | **~$107-207/month** |
