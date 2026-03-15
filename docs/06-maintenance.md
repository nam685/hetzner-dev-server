# Maintenance & Operations

## Regular Updates

Run periodically (or use `scripts/upgrade.sh`):

```bash
sudo apt update && sudo apt upgrade -y
claude update
```

## Backups

### Snapshots (whole server)

```bash
# Via hcloud CLI
hcloud server create-image --type snapshot --description "backup-2026-03-15" dev-server

# Or via Hetzner Console: Server → Snapshots → Create
```

Snapshots cost EUR 0.0108/GB/month. An 80GB server snapshot ≈ EUR 0.86/month.

### Git Push (code only)

Your code should be in git repos pushed to GitHub. This is the primary backup.

```bash
# Make sure to push your work regularly
git push
```

## Stopping vs Deleting

| Action | Billing | Data |
|--------|---------|------|
| **Power off** (stop) | Still billed (disk reserved) | Preserved |
| **Delete** | Billing stops | Lost forever |
| **Snapshot + Delete** | Only snapshot cost | Preserved in snapshot |

### Cost-Saving Workflow

If you won't use the server for a while:

```bash
# 1. Push all code to GitHub
# 2. Create snapshot
hcloud server create-image --type snapshot --description "pause-$(date +%Y%m%d)" dev-server
# 3. Delete server
hcloud server delete dev-server
# 4. When needed again, recreate from snapshot
hcloud server create --name dev-server --type cx32 --image <snapshot-id> --location fsn1 --ssh-key your-key
```

## Monitoring

```bash
# Check disk usage
df -h

# Check memory
free -h

# Check running processes
htop

# Check Claude Code processes
ps aux | grep claude
```

## Upgrading Server Size

If CX32 isn't enough:

1. Hetzner Console → Server → Rescale
2. Select new type (e.g. CX42)
3. Confirm — server reboots (~1 min)
4. SSH back in, reattach Zellij: `zellij a coding`

Downgrading works the same way (as long as disk fits).

## Troubleshooting

### SSH connection dropped mid-session
```bash
# Just reconnect and reattach
ssh dev
zellij a coding
# Everything is still running
```

### Claude Code auth expired
```bash
claude auth
```

### Server unreachable
1. Check Hetzner Console — is the server running?
2. Check if IP changed (shouldn't with static IPv4)
3. Try Hetzner Console's web terminal (rescue access)

### Disk full
```bash
# Find large files
du -sh /* | sort -rh | head -20
# Clean apt cache
sudo apt clean
```
