#!/usr/bin/env bash
# Bootstrap / update this machine from the dotfiles repo.
#
#   ./install.sh            install packages, set up system files/services, then link configs
#   ./install.sh packages   only install packages
#   ./install.sh system     only copy system/etc/* into /etc and enable system/services.txt
#   ./install.sh link       only link configs (same as ./link.sh)
#   ./install.sh defaults   only apply default apps from system/default-apps.txt
#
# Safe to re-run: already-installed packages are skipped.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Print package names from a list file, stripping comments and blank lines.
read_list() { sed -e 's/#.*//' -e 's/[[:space:]]*$//' -e '/^$/d' "$1"; }

install_packages() {
    echo "==> Installing official repo packages"
    mapfile -t repo_pkgs < <(read_list "$DOTFILES/packages/pacman.txt")
    sudo pacman -S --needed --noconfirm "${repo_pkgs[@]}"

    echo "==> Installing AUR packages"
    mapfile -t aur_pkgs < <(read_list "$DOTFILES/packages/aur.txt")
    if printf '%s\n' "${aur_pkgs[@]}" | grep -qx '1password'; then
        # The 1password AUR package verifies its download against this key.
        curl -fsSL https://downloads.1password.com/linux/keys/1password.asc | gpg --import
    fi
    paru -S --needed --noconfirm "${aur_pkgs[@]}"
}

# Copy system/etc/* into /etc as root-owned files. These are copied rather than symlinked
# because several programs (e.g. 1Password) refuse config files that a normal user can modify.
install_etc_files() {
    echo "==> Installing files into /etc"
    local src rel
    while IFS= read -r -d '' src; do
        rel="${src#"$DOTFILES/system/etc/"}"
        sudo install -D -o root -g root -m 755 "$src" "/etc/$rel"
        echo "    /etc/$rel"
    done < <(find "$DOTFILES/system/etc" -type f -print0)
}

enable_services() {
    echo "==> Enabling system services"
    mapfile -t units < <(read_list "$DOTFILES/system/services.txt")
    # --now would start nvidia-suspend & co. immediately (= suspend the GPU), so only enable;
    # timers are safe to start right away.
    sudo systemctl enable "${units[@]}"
    for u in "${units[@]}"; do
        [[ "$u" == *.timer ]] && sudo systemctl start "$u"
    done
    return 0
}

# Apply system/default-apps.txt with xdg-mime (per-user: writes ~/.config/mimeapps.list).
set_default_apps() {
    echo "==> Setting default applications"
    local app types
    while read -r app types; do
        if [[ ! -e "/usr/share/applications/$app" && ! -e "$HOME/.local/share/applications/$app" ]]; then
            echo "    skipping $app (not installed)" >&2
            continue
        fi
        # shellcheck disable=SC2086  # word-split the MIME type list on purpose
        xdg-mime default "$app" $types
        echo "    $app -> $types"
    done < <(read_list "$DOTFILES/system/default-apps.txt")
}

case "${1:-all}" in
    packages)         install_packages ;;
    system|services)  install_etc_files; enable_services ;;
    link)             "$DOTFILES/link.sh" ;;
    defaults)         set_default_apps ;;
    all)              install_packages; install_etc_files; enable_services; "$DOTFILES/link.sh"; set_default_apps ;;
    *)                echo "usage: $0 [all|packages|system|link|defaults]" >&2; exit 1 ;;
esac
