# Maintenance & Operations

## Regular Updates

```bash
update   # alias for: sudo apt update && sudo apt upgrade -y && claude update
```

## Backups

### Snapshots (recommended — full server backup)

```bash
# Via Hetzner Console: Server → Snapshots → Create
# Or via hcloud CLI:
hcloud server create-image --type snapshot --description "backup-$(date +%Y-%m-%d)" dev-server
```

Snapshots cost EUR 0.0108/GB/month. ~EUR 0.86/month for an 80GB server.

**Create a snapshot before deleting the server** — this is how you recover from ransomware or accidents.

### Code backups

Push all repos to GitHub regularly. Your code should never live only on the server.

## Stopping vs Deleting

| Action | Billing | Data |
|--------|---------|------|
| Power off | Still billed (disk reserved) | Preserved |
| Delete | Billing stops | Lost |
| Snapshot + Delete | Only snapshot cost | Preserved |

### Pause server (save money)

```bash
# 1. Push all code to GitHub
# 2. Create snapshot (Hetzner Console)
# 3. Delete server
hcloud server delete dev-server
# 4. Recreate from snapshot when needed
hcloud server create --name dev-server --type cx32 --image <snapshot-id> --location fsn1 --ssh-key your-key
```

## Upgrading Server Size

Hetzner Console → Server → Rescale → select new type → confirm (reboots in ~1 min).

## Monitoring

```bash
df -h      # disk usage
free -h    # memory
htop       # processes
```

## Troubleshooting

**SSH dropped mid-session**: reconnect and reattach Zellij — everything still running.

**Claude Code auth expired**:
```bash
claude
# Follow auth prompt on first launch
```

**Server unreachable**: check Hetzner Console — is it running? Use the web console (VNC) for rescue access.

**Disk full**:
```bash
du -sh /* 2>/dev/null | sort -rh | head -20
sudo apt clean
```
