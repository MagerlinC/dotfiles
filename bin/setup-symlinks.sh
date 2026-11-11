#!/bin/zsh
echo "Adding symlinks"

# Dotfiles
ln -nfs ~/dotfiles/zshrc ~/.zshrc

ln -nfs ~/dotfiles/starship.toml ~/.config/starship.toml

ln -nfs ~/dotfiles/gitconfig ~/.gitconfig
mkdir -p ~/.config/git && ln -nfs ~/dotfiles/gitconfig-macos ~/.config/git/platform.gitconfig

ln -nfs ~/dotfiles/ideavimrc ~/.ideavimrc

mkdir -p ~/.config

ln -nfs ~/dotfiles/tmux ~/.config/tmux

ln -nfs ~/dotfiles/nvim ~/.config/nvim

ln -nfs ~/dotfiles/wezterm ~/.config/wezterm

#ln -nfs ~/dotfiles/yabai ~/.config/yabai

ln -nfs ~/dotfiles/skhd ~/.config/skhd

ln -nfs ~/dotfiles/.markdownlint-cli2.yaml ~/.markdownlint-cli2.yaml

mkdir ~/.config/eza && ln -nfs ~/dotfiles/eza-catppuccin-theme.yml ~/.config/eza/theme.yml

# initialize new settings
source ~/.zshrc
