# dotfiles

My current dotfile configurations

## Instructions

### Installation

This will clone the repo, symlink all settings and install applications via brew.

```bash
git clone git@github.com:magerlinc/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh bin/setup-env.sh
```

## Layout

- Repo root: macOS setup (`Brewfile`, `bin/`, `skhd/`, `zshrc`, `macos`, ...) plus the configs
  shared by both machines: `nvim/`, `tmux/`, `wezterm/`, `starship.toml`, `gitconfig`.
- [`cachyos/`](cachyos/README.md): the CachyOS gaming desktop (Hyprland). Links the shared configs
  listed in `cachyos/shared.txt` alongside its own.

### CachyOS installation

```bash
git clone https://github.com/MagerlinC/dotfiles ~/dotfiles
cd ~/dotfiles/cachyos
./install.sh
```

### Commit signing

Both machines sign commits with an SSH key stored in 1Password (`gpg.format = ssh` in `gitconfig`).
Each OS links its own `~/.config/git/platform.gitconfig` with the path to 1Password's `op-ssh-sign`
(`gitconfig-macos` on the Mac, via `bin/setup-symlinks.sh`).
