# TODO

## Before provisioning
- [x] Get permission to use work Claude Max subscription for personal use
- [x] Create Hetzner account and add payment method

## Server setup
- [x] Provision server — CAX21 (ARM64, 4 vCPU, 8GB RAM) in Helsinki, ~€8/month
- [x] Run `scripts/setup.sh` on server (with manual fixes for ssh.service, ARM64 Zellij, PATH)
- [x] Authenticate Claude Code: `claude` (interactive mode handles auth)
- [x] Add SSH key to server from Mac laptop
- [ ] Add SSH key to server from Windows laptop (WSL2)
- [x] Configure `~/.ssh/config` on Mac laptop
- [ ] Configure `~/.ssh/config` on Windows laptop (WSL2)

## Phone setup (Android S23)
- [ ] Install Termux from F-Droid (not Google Play)
- [ ] Install Mosh in Termux: `pkg install openssh mosh`
- [ ] Generate SSH key on phone and add to server
- [ ] Configure `~/.ssh/config` in Termux
- [ ] Enable clickable URLs: `terminal-onclick-url-open=true` in `~/.termux/termux.properties`
- [ ] Install GitHub app on phone (for PR review via tapped links)
- [ ] Optional: install Termux:Styling from F-Droid for better fonts
- [ ] Test voice input workflow with Gboard

## Post-setup
- [ ] Copy `scripts/new-claude` to server `~/.local/bin/`
- [ ] Copy `scripts/zellij-multiclaud.kdl` to server `~/.config/zellij/layouts/`
- [ ] Test multiclauding layout from Mac (iTerm2 `new-claude`)
- [ ] Test multiclauding layout from server (Zellij `new-claude`)
- [ ] Test phone workflow: Termux → Mosh → Zellij → Claude Code → PR link → GitHub app
- [ ] Clone a project repo on server and test a full Claude Code session
