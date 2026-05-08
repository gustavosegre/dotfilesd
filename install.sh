#!/bin/bash
set -e

echo "==> Install yay..."
if ! command -v yay &>/dev/null; then
	sudo pacman -S --needed got base-devel
	git clone https://aur.archlinux.org/yay.git /tmp/yay
	cd /tmp/yay && makepkg -si
	cd -
fi

echo "==> Install oficial packages..."
sudo pacman -S --needed - < pkglist.txt

echo "==> Install AUR packages..."
yay -S --needed - < aurlist.txt

echo "==> Copy .configs"
cp -r config/hypr ~/.config/
cp -r config/kity ~/.config/
cp -r config/quickshell ~/.config/
cp -r config/caelestia ~/.config/

echo "Enable services..."
systemctl enable NetworkManager
systemctl enable --now spice-vdagentd

echo ""
echo "==> Success, restart Hyprland"
