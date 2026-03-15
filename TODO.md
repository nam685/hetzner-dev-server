# TODO

## Before provisioning
- [ ] Get permission to use work Claude Max subscription for personal use
- [ ] Create Hetzner account and add payment method

## Server setup
- [ ] Provision CX32 server (docs/01-hetzner-setup.md)
- [ ] Run `scripts/setup.sh` on server
- [ ] Authenticate Claude Code: `claude auth`
- [ ] Add SSH key to server from Mac laptop
- [ ] Add SSH key to server from Windows laptop (WSL2)
- [ ] Configure `~/.ssh/config` on both laptops

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
