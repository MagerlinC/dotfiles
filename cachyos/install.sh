#!/usr/bin/env bash
# Bootstrap / update this machine from the dotfiles repo.
#
#   ./install.sh            install packages, set up system files/services, then link configs
#   ./install.sh packages   only install packages
#   ./install.sh system     only copy system/etc/* into /etc and enable system/services.txt
#   ./install.sh link       only link configs (same as ./link.sh)
#   ./install.sh defaults   only apply default apps from system/default-apps.txt
#   ./install.sh tmux       only install tmux plugins (tpm)
#   ./install.sh zsh        only install oh-my-zsh + plugins
#   ./install.sh godot      only install the pinned Godot (.NET) binary
#
# Safe to re-run: already-installed packages are skipped.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$DOTFILES")"   # shared (Mac + Linux) files live here

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

# oh-my-zsh + the plugins the shared zshrc enables. Cloned directly instead of using the
# oh-my-zsh installer, which would try to replace ~/.zshrc (a symlink into this repo).
setup_zsh() {
    echo "==> Setting up oh-my-zsh"
    local omz="$HOME/.oh-my-zsh" custom="$HOME/.oh-my-zsh/custom/plugins"
    [[ -d "$omz" ]] || git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$omz"
    [[ -d "$custom/zsh-syntax-highlighting" ]] || git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$custom/zsh-syntax-highlighting"
    [[ -d "$custom/zsh-autosuggestions" ]] || git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "$custom/zsh-autosuggestions"
    if [[ "$(getent passwd "$USER" | cut -d: -f7)" != */zsh ]]; then
        echo "    login shell is not zsh; change it with: chsh -s /usr/bin/zsh  (then log out and back in)"
    fi
}

# Godot (.NET build), pinned to 4.6.x: the repos/AUR only package the latest release.
# Official binary goes to ~/.local/opt/godot/<version>, with ~/.local/bin/godot and a .desktop entry.
# To upgrade: bump GODOT_VERSION + GODOT_SHA512 (from the release's SHA512-SUMS.txt), re-run.
GODOT_VERSION="4.6.3-stable"
GODOT_SHA512="962c4f5fd3a704de36c9dedcb2f5f6c973065ac8ed8fd6e12c7ebf7e48c3852d774bcef2ccf76b50b206c0c564ceea54315e2943e76e397529923e7de680508e"
install_godot() {
    local name="Godot_v${GODOT_VERSION}_mono_linux_x86_64"
    local base="https://github.com/godotengine/godot/releases/download/$GODOT_VERSION"
    local dest="$HOME/.local/opt/godot/$GODOT_VERSION"
    local bin="$dest/$name/Godot_v${GODOT_VERSION}_mono_linux.x86_64"

    if [[ ! -x "$bin" ]]; then
        echo "==> Installing Godot $GODOT_VERSION (.NET)"
        local tmp
        tmp="$(mktemp -d)"
        curl -fL --progress-bar -o "$tmp/$name.zip" "$base/$name.zip"
        echo "$GODOT_SHA512  $tmp/$name.zip" | sha512sum -c --quiet
        mkdir -p "$dest"
        unzip -q "$tmp/$name.zip" -d "$dest"
        rm -rf "$tmp"
    fi

    mkdir -p "$HOME/.local/bin" "$HOME/.local/share/applications" "$HOME/.local/share/icons/hicolor/scalable/apps"
    ln -sfn "$bin" "$HOME/.local/bin/godot"
    local icon="$HOME/.local/share/icons/hicolor/scalable/apps/godot.svg"
    [[ -s "$icon" ]] || curl -fsSL -o "$icon" "https://raw.githubusercontent.com/godotengine/godot/$GODOT_VERSION/icon.svg"
    cat > "$HOME/.local/share/applications/godot.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Godot Engine
GenericName=Game Engine
Comment=Godot $GODOT_VERSION (.NET)
Exec=$HOME/.local/bin/godot %f
Icon=godot
Terminal=false
Categories=Development;IDE;
MimeType=application/x-godot-project;
StartupWMClass=Godot
EOF
    echo "    godot -> $bin"
}

# tmux plugin manager (tpm) + plugins, using the shared script from the repo root.
setup_tmux_plugins() {
    if [[ -d "$HOME/.config/tmux/plugins/tpm" ]]; then return 0; fi
    echo "==> Installing tmux plugins"
    zsh "$REPO_ROOT/bin/install-tmux-plugins.sh"
}

case "${1:-all}" in
    packages)         install_packages ;;
    system|services)  install_etc_files; enable_services ;;
    link)             "$DOTFILES/link.sh" ;;
    defaults)         set_default_apps ;;
    tmux)             setup_tmux_plugins ;;
    zsh)              setup_zsh ;;
    godot)            install_godot ;;
    all)              install_packages; install_etc_files; enable_services; "$DOTFILES/link.sh"; set_default_apps; setup_zsh; setup_tmux_plugins; install_godot ;;
    *)                echo "usage: $0 [all|packages|system|link|defaults|tmux|zsh|godot]" >&2; exit 1 ;;
esac
