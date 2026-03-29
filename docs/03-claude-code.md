# Claude Code CLI Setup

## Install

Handled by `scripts/setup.sh`. To install manually:

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Binary goes to `~/.local/bin/claude`. Make sure `~/.local/bin` is in your PATH.

## Authenticate

```bash
# Just run claude — it will prompt you to auth on first launch
claude
# Opens a URL → open in browser → copy code → paste into terminal
```

## Subscription Options

| Plan | Price | Claude Code Usage |
|------|-------|-------------------|
| Claude Max $100 | $100/month | 5x Pro rate limits |
| Claude Max $200 | $200/month | 20x Pro rate limits |
| API (pay-per-use) | Variable | Pay per token |

## Updating

```bash
claude update
# Or use the alias:
update
```

## Tips

```bash
claude              # start interactive session
claude "explain X"  # one-shot
claude --resume     # resume last session
```

Create a `CLAUDE.md` in your project root for project-specific instructions — Claude Code reads it automatically.
