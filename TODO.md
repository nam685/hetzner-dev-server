# TODO

## Before provisioning
- [x] Get permission to use work Claude Max subscription for personal use
- [x] Create Hetzner account and add payment method

## Server setup
- [x] Provision server — CAX21 (ARM64, 4 vCPU, 8GB RAM) in Helsinki, ~€8/month
- [x] Run `scripts/setup.sh` on server (with manual fixes for ssh.service, ARM64 Zellij, PATH)
- [x] Authenticate Claude Code: `claude` (interactive mode handles auth)
- [x] Add SSH key to server from Mac laptop
- [x] Add SSH key to server from Windows laptop (WSL2)
- [x] Configure `~/.ssh/config` on Mac laptop
- [x] Configure `~/.ssh/config` on Windows laptop (WSL2)

## Phone setup (Android S23)
- [x] Install Termux from F-Droid (not Google Play)
- [x] Install Mosh in Termux: `pkg install openssh mosh`
- [x] Generate SSH key on phone and add to server
- [x] Configure `~/.ssh/config` in Termux
- [x] Enable clickable URLs: `terminal-onclick-url-open=true` in `~/.termux/termux.properties`
- [x] Install GitHub app on phone (for PR review via tapped links)
- [x] Install Termux:Styling from F-Droid for better fonts
- [x] Test voice input (Samsung voice input)

## Post-setup
- [x] Copy `scripts/new-claude` to server `~/.local/bin/`
- ~~Copy `scripts/zellij-multiclaud.kdl` to server~~ (skipped — `new-claude` covers this)
- [x] Test multiclauding layout from Mac (iTerm2 `new-claude`)
- [x] Test multiclauding layout from server (Zellij `new-claude`)
- [x] Test phone workflow: Termux → SSH → Zellij → Claude Code → PR (first PR from phone!)
- [x] Clone a project repo on server and test a full Claude Code session (nam-website from Windows)

## Claude Code config
- [x] Add global `~/.claude/CLAUDE.md` with "be succinct on narrow terminal" instruction
- [ ] Add project-level `CLAUDE.md` to repos cloned on server

## Termux quality-of-life
- [x] Scrolling: use Zellij scroll mode (`Ctrl+S`, then PgUp/PgDn, `Esc` to exit)
- [x] Extra-keys row configured (PgUp/PgDn, Ctrl, Esc, Tab, arrows)
- [x] Using Mosh for resilient connections
- [x] Termux:Widget installed for one-tap SSH shortcut
- [x] Alias `c` conditionally: `--dangerously-skip-permissions` on phone (< 100 cols), normal on laptop

## Remote Control (Claude App → Server)
- [ ] Pair Claude mobile app with running Claude Code session on server
- [ ] Test Remote Control workflow: send prompt from app → verify execution on server
- [ ] Test pairing persistence across app restarts
- [ ] Document any gotchas or additional setup steps discovered

## Security
- [x] SSH key-only auth (PasswordAuthentication no)
- [x] Root login disabled (PermitRootLogin no)
- [x] UFW firewall enabled (SSH + Mosh ports only)
- [x] fail2ban installed
- [ ] When serving nam-website: open ports 80/443 in UFW, set up nginx/caddy
