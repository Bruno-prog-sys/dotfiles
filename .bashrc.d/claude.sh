# =============================================================
# .bashrc.d/claude.sh — Claude Code PATH + aliases module
# Part of Bruno's dotfiles. Auto-loaded via .bashrc.d loader.
#
# WHY this file exists:
#   Claude Code is installed as a native binary in ~/.local/bin.
#   This module ensures that path is always in $PATH and provides
#   convenience aliases for daily use.
#   Auth uses Claude.ai Pro OAuth — no API key needed.
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

# Convenience aliases (Gemini-recommended)
alias c='claude'                  # quick launch
alias cauth='claude auth login'   # re-authenticate when token expires
alias cstatus='claude auth status' # check current auth state
