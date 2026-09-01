#!/usr/bin/env bash
# One-shot setup: installs packages and symlinks configs.
# Usage: cd ~/dotfiles && ./scripts/install.sh
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "==> Dotfiles at: $DOTFILES"

# --- Homebrew ---------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Activate for this session
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

echo "==> Installing packages from Brewfile..."
brew bundle install --file="$DOTFILES/Brewfile"

# --- Symlinks ---------------------------------------------------------
echo "==> Creating symlinks..."
mkdir -p "$HOME/.config/wezterm"

link() {
  local src="$1" dst="$2"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    echo "    Backing up existing $dst -> $dst.bak"
    mv "$dst" "$dst.bak"
  fi
  ln -sfn "$src" "$dst"
  echo "    $dst -> $src"
}

link "$DOTFILES/wezterm/wezterm.lua"   "$HOME/.config/wezterm/wezterm.lua"
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"
link "$DOTFILES/zsh/.zshrc"             "$HOME/.zshrc"

echo "==> Done. Open a new WezTerm window (or run: source ~/.zshrc)"
