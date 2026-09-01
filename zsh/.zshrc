# ~/.zshrc — lives in ~/dotfiles, symlinked to ~/.zshrc

# ----------------------------------------------------------------------
# Homebrew (works on both Apple Silicon and Intel)
# ----------------------------------------------------------------------
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# ----------------------------------------------------------------------
# Starship prompt
# ----------------------------------------------------------------------
eval "$(starship init zsh)"

# ----------------------------------------------------------------------
# zsh-autosuggestions (before syntax-highlighting)
# ----------------------------------------------------------------------
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# ----------------------------------------------------------------------
# zsh-syntax-highlighting — must be sourced LAST
# ----------------------------------------------------------------------

# Disable underline on paths
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# ----------------------------------------------------------------------
# Machine-specific overrides (not tracked in git)
# ----------------------------------------------------------------------
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
