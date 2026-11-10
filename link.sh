#!/usr/bin/env bash
# Symlink every package in stow/ into $HOME with GNU Stow.
#
# Each folder in stow/ mirrors $HOME, e.g. stow/kitty/.config/kitty -> ~/.config/kitty
#
# If a real (non-symlink) file or folder already sits where a link should go,
# it is moved to ~/.dotfiles-backup/<timestamp>/ first, so nothing is lost.
#
#   ./link.sh            link all packages
#   ./link.sh kitty fish link only the named packages
#   ./link.sh -D kitty   unlink a package (stow -D)
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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

if (($#)); then pkgs=("$@"); else
    pkgs=(); for d in "$STOW_DIR"/*/; do pkgs+=("$(basename "$d")"); done
fi

shopt -s nullglob dotglob

# List the paths (relative to $HOME) that a package will link:
# ~/.config/<app>, ~/.local/{bin,share}/<thing>, or a top-level ~/.<file>.
link_targets() {
    local root="$STOW_DIR/$1" entry sub child
    for entry in "$root"/*; do
        case "${entry##*/}" in
            .config) for child in "$entry"/*; do echo "${child#"$root/"}"; done ;;
            .local)  for sub in "$entry"/*/; do
                         for child in "$sub"*; do echo "${child#"$root/"}"; done
                     done ;;
            *)       echo "${entry#"$root/"}" ;;
        esac
    done
}

for pkg in "${pkgs[@]}"; do
    [[ -d "$STOW_DIR/$pkg" ]] || { echo "no such package: $pkg" >&2; exit 1; }
    while IFS= read -r rel; do
        target="$HOME/$rel"
        if [[ -e "$target" && ! -L "$target" ]]; then
            mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
            mv "$target" "$BACKUP_DIR/$rel"
            echo "backed up ~/$rel -> $BACKUP_DIR/$rel"
        fi
    done < <(link_targets "$pkg")

    stow -R -v -d "$STOW_DIR" -t "$HOME" "$pkg"
done

echo "==> Linked: ${pkgs[*]}"
