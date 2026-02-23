# Bruno's Dotfiles — Cloud Office Setup

Automatically configures every GitHub Codespace with Claude Code and a modular shell environment.

## What this installs

| Module | File | Purpose |
|--------|------|---------|
| Claude Code | `install.sh` | Native binary, auto-updates |
| PATH | `.bashrc.d/claude.sh` | Makes `claude` available everywhere |

## How it works

1. **GitHub Codespace starts** → GitHub detects this dotfiles repo → runs `install.sh`
2. **`install.sh`** installs Claude Code and sets up the `.bashrc.d` loader
3. **GitHub Codespaces Secret** (`ANTHROPIC_API_KEY`) is injected automatically — no key in code
4. **Type `claude`** — ready to work

## Adding new tools

Drop a new file in `.bashrc.d/`:
```bash
# .bashrc.d/mytool.sh
export PATH="$HOME/.local/bin/mytool:$PATH"
```
Re-run `install.sh` to activate. No other changes needed.

## Manual setup (one-time, GitHub UI)

1. **GitHub Settings → Codespaces → Secrets** → add `ANTHROPIC_API_KEY`
2. **GitHub Settings → Codespaces → Dotfiles** → enable + select this repo

## Architecture

```
dotfiles/
├── install.sh           ← Entry point (runs on Codespace startup)
├── .bashrc.d/
│   ├── claude.sh        ← Claude Code PATH module
│   └── (future tools)   ← Drop new .sh files here
└── README.md
```
