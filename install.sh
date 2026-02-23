#!/bin/bash
# =============================================================
# Bruno's Dotfiles — install.sh
# Runs automatically on every new GitHub Codespace startup.
#
# What this does:
#   1. Installs Claude Code (native binary, auto-updates)
#   2. Adds the .bashrc.d loader to ~/.bashrc (idempotent)
#   3. Installs .bashrc.d modules (PATH, future tools)
#
# ANTHROPIC_API_KEY is injected via GitHub Codespaces Secrets —
# never stored here. Claude reads it from the environment.
# =============================================================

set -e  # Exit immediately on any error

echo ""
echo "============================================"
echo " Bruno's Cloud Office — Dotfiles Setup"
echo "============================================"

# --- 1. Install Claude Code (native binary) ---
echo ""
echo "→ [1/3] Installing Claude Code (native binary)..."
curl -fsSL https://claude.ai/install.sh | bash

# --- 2. Add .bashrc.d loader to ~/.bashrc (idempotent, Gemini-validated) ---
# Codespaces Ubuntu does NOT auto-load .bashrc.d — we add the loader once.
echo ""
echo "→ [2/3] Configuring .bashrc.d loader..."

BASHRC_D_LOADER='if [ -d ~/.bashrc.d ]; then for file in ~/.bashrc.d/*.sh; do . "$file"; done; fi'

if ! grep -qF ".bashrc.d" ~/.bashrc 2>/dev/null; then
    echo ""                                          >> ~/.bashrc
    echo "# Load .bashrc.d modules (added by dotfiles)" >> ~/.bashrc
    echo "$BASHRC_D_LOADER"                         >> ~/.bashrc
    echo "  ✓ Loader added to ~/.bashrc"
else
    echo "  ✓ Loader already present — skipping"
fi

mkdir -p ~/.bashrc.d

# --- 3. Install .bashrc.d modules from this dotfiles repo ---
echo ""
echo "→ [3/3] Installing .bashrc.d modules..."

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -d "$DOTFILES_DIR/.bashrc.d" ]; then
    for module in "$DOTFILES_DIR/.bashrc.d/"*.sh; do
        [ -f "$module" ] || continue  # skip if glob returns no files
        target="$HOME/.bashrc.d/$(basename "$module")"
        cp "$module" "$target"
        echo "  ✓ Installed: $(basename "$module")"
    done
else
    echo "  ⚠ No .bashrc.d modules found in dotfiles repo"
fi

# Apply PATH immediately for the current session
export PATH="$HOME/.local/bin:$PATH"

echo ""
echo "============================================"
echo " ✅ Cloud Office ready. Type: claude"
echo "============================================"
echo ""
