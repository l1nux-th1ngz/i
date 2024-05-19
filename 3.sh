#!/bin/bash

# List of packages to install
packages=(scrot maim slop imagemagick fzf ffcast graphicsmagick udisks2 udiskie kitty alacritty dmenu sxhkd numlockx dunst libnotify-bin picom unzip zip)

# Install packages
for package in "${packages[@]}"; do
  sudo apt install -y "$package"
done

# Create directories
mkdir -p "$HOME/.config/dunst" "$HOME/.config/dunst/icons" "$HOME/.config/dunst/sounds" "$HOME/.config/dunst/scripts"
mkdir -p "$HOME/.config/rofi" "$HOME/.config/rofi/themes" "$HOME/.config/rofi/scripts" "$HOME/.config/rofi/mount" "$HOME/.config/rofi/music" "$HOME/.config/rofi/screen" "$HOME/.config/rofi/screenshot" "$HOME/.config/rofi/wifi"

# Get rofi-screenshot
curl -L https://git.io/rofi-screenshot > rofi-screenshot && chmod 777 rofi-screenshot
sudo mv rofi-screenshot /usr/local/bin/

# Create config files
mkdir -p "$HOME/.config/rofi"
touch "$HOME/.config/rofi/config"
mkdir -p "$HOME/.config/rofi/themes"
mkdir -p "$HOME/.config/rofi/scripts"
mkdir -p "$HOME/.config/rofi/mount"
mkdir -p "$HOME/.config/rofi/music"
mkdir -p "$HOME/.config/rofi/screen"
mkdir -p "$HOME/.config/rofi/screenshot"
mkdir -p "$HOME/.config/rofi/wifi"

# Install rofi
sudo apt install -y rofi

# Clone polybar repo
git clone https://github.com/polybar/polybar.git
cd polybar && ./build.sh

# Create autostart directory and add i3.desktop file
mkdir -p "$HOME/.config/autostart"
echo "[Desktop Entry]
Encoding=UTF-8
Name=i3
Comment=Dynamic window manager
Exec=i3
Icon=i3
Type=XSession" > $HOME/.config/autostart/i3.desktop

# Install lightdm and lightdm-gtk
sudo apt install -y lightdm lightdm-gtk

# Enable lightdm service
sudo systemctl enable lightdm

exit 0