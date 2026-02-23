# =============================================================
# .bashrc.d/claude.sh — Claude Code PATH module
# Part of Bruno's dotfiles. Auto-loaded via .bashrc.d loader.
#
# WHY this file exists:
#   Claude Code is installed as a native binary in ~/.local/bin.
#   This module ensures that path is always in $PATH.
#   ANTHROPIC_API_KEY is NOT set here — it arrives automatically
#   from GitHub Codespaces Secrets at Codespace startup.
#
# To add a new tool (Gemini CLI, n8n CLI, etc.):
#   → Create a new file: .bashrc.d/toolname.sh
#   → Add only PATH and env vars for that tool
#   → Drop it in this folder and re-run install.sh
# =============================================================

# Ensure Claude Code binary is discoverable
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
