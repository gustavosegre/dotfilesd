#!/bin/bash
set -e
echo " ----- CLEAN INSTALL ----- "
echo "==> Instalando yay..."
if ! command -v yay &>/dev/null; then
  sudo pacman -S --needed --noconfirm git base-devel
  rm -rf /tmp/yay
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si --noconfirm
  cd -
fi

echo "==> Instalando Hyprland e dependencias..."
sudo pacman -S --needed --noconfirm \
  hyprland \
  mesa \
  wayland \
  wayland-protocols \
  xdg-desktop-portal-hyprland \
  xdg-utils \
  polkit \
  pipewire \
  pipewire-pulse \
  wireplumber \
  qt5-wayland \
  qt6-wayland \
  networkmanager \
  kitty \
  swww \
  ttf-dejavu \
  noto-fonts \
  noto-fonts-emoji \
  ttf-liberation \
  spice-vdagent

echo "==> Copiando configs..."
mkdir -p ~/.config

[ -d config/hypr ]  && cp -r config/hypr  ~/.config/
[ -d config/kitty ] && cp -r config/kitty ~/.config/

echo "==> Copiando wallpapers..."
mkdir -p ~/Pictures/Wallpapers
[ -d Wallpapers ] && cp -r Wallpapers/* ~/Pictures/Wallpapers/ || true

echo "==> Habilitando serviços..."
sudo systemctl enable NetworkManager
sudo systemctl enable spice-vdagentd 2>/dev/null || true

echo ""
echo "==> Concluido! Reinicie e execute: Hyprland"
