#!/bin/bash
set -e

echo "==> Instalando yay..."
if ! command -v yay &>/dev/null; then
  sudo pacman -S --needed --noconfirm git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si --noconfirm
  cd -
fi

echo "==> Instalando pacotes oficiais..."
sudo pacman -S --needed --noconfirm - < pkglist.txt 2>/dev/null || true

echo "==> Instalando pacotes AUR..."
yay -S --needed --noconfirm - < aurlist.txt 2>/dev/null || true

echo "==> Instalando caelestia manualmente..."
yay -S --needed --noconfirm caelestia-shell caelestia-cli quickshell-git

echo "==> Copiando configs..."
mkdir -p ~/.config

[ -d config/hypr ]       && cp -r config/hypr       ~/.config/
[ -d config/kitty ]      && cp -r config/kitty       ~/.config/
[ -d config/quickshell ] && cp -r config/quickshell  ~/.config/
[ -d config/caelestia ]  && cp -r config/caelestia   ~/.config/

echo "==> Copiando wallpapers..."
mkdir -p ~/Pictures/Wallpapers
[ -d Wallpapers ] && cp -r Wallpapers/* ~/Pictures/Wallpapers/ || true

echo "==> Habilitando serviços..."
sudo systemctl enable NetworkManager
sudo systemctl enable spice-vdagentd 2>/dev/null || true

echo "==> Iniciando swww..."
swww-daemon & 2>/dev/null || true

echo ""
echo "==> Concluido! Reinicie e execute: Hyprland"
