#!/usr/bin/env bash
# Symlink every package in stow/ into $HOME with GNU Stow.
#
# Each folder in stow/ mirrors $HOME, e.g. stow/kitty/.config/kitty -> ~/.config/kitty
#
# If a real (non-symlink) file or folder already sits where a link should go,
# it is moved to ~/.dotfiles-backup/<timestamp>/ first, so nothing is lost.
#
#   ./link.sh            link all packages + the shared configs in shared.txt
#   ./link.sh kitty fish link only the named packages
#   ./link.sh shared     link only the shared configs (repo root -> $HOME, see shared.txt)
#   ./link.sh -D kitty   unlink a package (stow -D)
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$DOTFILES")"   # shared (Mac + Linux) configs live here
STOW_DIR="$DOTFILES/stow"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

command -v stow >/dev/null || { echo "stow is not installed: sudo pacman -S stow" >&2; exit 1; }

if [[ "${1:-}" == "-D" ]]; then
    shift
    stow -D -v -d "$STOW_DIR" -t "$HOME" "$@"
    exit 0
fi

# Keep these as real directories so Stow links the app folders inside them
# rather than swallowing the whole parent into a single package.
mkdir -p "$HOME/.config" "$HOME/.local/bin" "$HOME/.local/share"
mkdir -p -m 700 "$HOME/.ssh"   # private; SSH writes known_hosts here, so only individual files get linked

link_shared=0
if [[ "${1:-}" == shared ]]; then pkgs=(); link_shared=1
elif (($#)); then pkgs=("$@")
else
    pkgs=(); for d in "$STOW_DIR"/*/; do pkgs+=("$(basename "$d")"); done
    link_shared=1
fi

# Move a real file/folder out of the way before a link replaces it.
backup() {
    local rel="$1" target="$HOME/$1"
    if [[ -e "$target" && ! -L "$target" ]]; then
        mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
        mv "$target" "$BACKUP_DIR/$rel"
        echo "backed up ~/$rel -> $BACKUP_DIR/$rel"
    fi
}

shopt -s nullglob dotglob

# List the paths (relative to $HOME) that a package will link:
# ~/.config/<app>, ~/.ssh/<file>, ~/.local/{bin,share}/<thing>, or a top-level ~/.<file>.
link_targets() {
    local root="$STOW_DIR/$1" entry sub child
    for entry in "$root"/*; do
        case "${entry##*/}" in
            .config|.ssh) for child in "$entry"/*; do echo "${child#"$root/"}"; done ;;
            .local)  for sub in "$entry"/*/; do
                         for child in "$sub"*; do echo "${child#"$root/"}"; done
                     done ;;
            *)       echo "${entry#"$root/"}" ;;
        esac
    done
}

for pkg in "${pkgs[@]}"; do
    [[ -d "$STOW_DIR/$pkg" ]] || { echo "no such package: $pkg" >&2; exit 1; }
    while IFS= read -r rel; do backup "$rel"; done < <(link_targets "$pkg")

    stow -R -v -d "$STOW_DIR" -t "$HOME" "$pkg"
done

if ((link_shared)); then
    while read -r src dest; do
        [[ -e "$REPO_ROOT/$src" ]] || { echo "shared.txt: $src not found in repo root" >&2; exit 1; }
        backup "$dest"
        mkdir -p "$(dirname "$HOME/$dest")"
        ln -sfn "$REPO_ROOT/$src" "$HOME/$dest"
        echo "LINK: $dest => $REPO_ROOT/$src"
        pkgs+=("$src")
    done < <(sed -e 's/#.*//' -e '/^[[:space:]]*$/d' "$DOTFILES/shared.txt")
fi

echo "==> Linked: ${pkgs[*]}"
