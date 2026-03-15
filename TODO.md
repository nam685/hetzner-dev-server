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
