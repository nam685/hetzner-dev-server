# Claude Code CLI Setup

## Prerequisites

- Node.js 18+ (installed by setup script)
- Claude Max subscription ($200/month) or Anthropic API key

## Subscription Options

| Plan | Price | Claude Code Usage |
|------|-------|-------------------|
| Claude Max | $200/month | High usage limits, best for daily coding |
| Claude Pro | $20/month | Limited Claude Code usage |
| API (pay-per-use) | Variable | Pay per token, no monthly cap but can get expensive with heavy use |

**Recommendation**: Claude Max at $200/month is the right call if you're using Claude Code as your primary coding tool daily. The API alternative can exceed $200/month easily with heavy Opus usage.

## Install Claude Code CLI

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
npm update -g @anthropic-ai/claude-code
```
