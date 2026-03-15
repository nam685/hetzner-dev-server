# Claude Code CLI Setup

## Prerequisites

- Claude Max subscription or Anthropic API key
- No Node.js required (native installer available)

## Subscription Options

| Plan | Price | Claude Code Usage |
|------|-------|-------------------|
| Claude Max $100 | $100/month | 5x Pro rate limits |
| Claude Max $200 | $200/month | 20x Pro rate limits, best for daily heavy coding |
| Claude Pro | $20/month | Limited Claude Code usage |
| API (pay-per-use) | Variable | Pay per token, no monthly cap but can get expensive with heavy use |

**Recommendation**: Start with Max $100/month. Upgrade to $200 if you hit rate limits regularly. The API can exceed these amounts easily with heavy Opus usage.

## Install Claude Code CLI

### Option A: Native installer (recommended, no Node.js needed)

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

Binary goes to `~/.local/bin/claude`. Make sure `~/.local/bin` is in your PATH.

### Option B: Via npm

```bash
npm install -g @anthropic-ai/claude-code
```

## Authenticate

### Option A: Claude Max (recommended)

```bash
claude auth
# Follow the browser-based OAuth flow
# If on a headless server, it will give you a URL to open on any device
```

### Option B: API Key

```bash
export ANTHROPIC_API_KEY="sk-ant-..."
# Or persist it:
echo 'export ANTHROPIC_API_KEY="sk-ant-..."' >> ~/.bashrc
source ~/.bashrc
```

## Verify

```bash
claude --version
claude "say hello"
```

## Configuration

Claude Code stores config in `~/.claude/`.

### Useful Settings

```bash
# Set preferred model
claude config set model claude-opus-4-6

# Set max tokens
claude config set maxTokens 8192
```

### Project-Level Config

Create a `CLAUDE.md` in your project root with project-specific instructions. Claude Code reads this automatically.

## Usage Tips

```bash
# Start interactive session
claude

# One-shot command
claude "explain this error: <paste error>"

# Pipe input
cat error.log | claude "what's wrong?"

# Resume last session
claude --resume
```

## Updating

```bash
# If installed via native installer
claude update

# If installed via npm
npm update -g @anthropic-ai/claude-code
```
