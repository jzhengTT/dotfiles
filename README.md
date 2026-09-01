# dotfiles

Configs for WezTerm, Starship, and zsh (autosuggestions + syntax highlighting).

## First machine (where configs already exist)

```bash
# 1. Put this folder at ~/Projects/dotfiles
mkdir -p ~/Projects && mv ~/Downloads/dotfiles ~/Projects/dotfiles

# 2. Initialize git and push to your own repo
cd ~/Projects/dotfiles
git init && git add -A && git commit -m "initial dotfiles"
git remote add origin git@github.com:YOURNAME/dotfiles.git
git push -u origin main

# 3. Symlink configs into place (backs up anything already there)
./scripts/install.sh
```

## Other machines

```bash
git clone git@github.com:YOURNAME/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles && ./scripts/install.sh
```

The script installs Homebrew if missing, installs all packages from the
Brewfile (WezTerm, Starship, zsh plugins, Nerd Font), and symlinks:

| Repo file                  | Symlinked to                        |
| -------------------------- | ----------------------------------- |
| `wezterm/wezterm.lua`      | `~/.config/wezterm/wezterm.lua`     |
| `starship/starship.toml`   | `~/.config/starship.toml`           |
| `zsh/.zshrc`               | `~/.zshrc`                          |

## Making changes

Edit files in `~/Projects/dotfiles` directly (the symlinks mean the tools pick up
changes immediately), then:

```bash
cd ~/Projects/dotfiles && git add -A && git commit -m "tweak" && git push
```

On other machines: `cd ~/Projects/dotfiles && git pull`.

## Machine-specific settings

Put anything local-only in `~/.zshrc.local` — it's sourced automatically
and never tracked in git. For WezTerm, branch on `wezterm.hostname()`
inside `wezterm.lua`.
