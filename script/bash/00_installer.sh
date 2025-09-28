install_yay () {
    set -euo pipefail
    if command -v yay &> /dev/null; then
        echo "yay is already installed, skipped..."
        return 0
    fi
    echo "yay not found, installing yay"
    sudo pacman -S --needed --noconfirm git base-devel
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    cd "$tmpdir/yay"
    makepkg -si --noconfirm
    cd -
    rm -rf "$tmpdir"
}


install_widget() {
    set -euo pipefail
    install_yay
    if command -v eww &> /dev/null; then
        echo "eww is already installed, skipped..."
        return 0
    fi
    echo "Installing eww..."
    yay -S --needed --noconfirm eww
}