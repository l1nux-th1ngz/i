#!/bin/bash

# List of packages to install
packages=(
    build-essential xcb gcc libgtk-3-dev ninja-build libgtkmm-3.0-dev libxcb-randr0
    libxcb-randr0-dev libxcb-util-dev libxcb-util0-dev libxcb-util1 libxcb-ewmh-dev
    libxcb-xinerama0 libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-keysyms1-dev
    libxcb-cursor-dev libxcb-shape0-dev cmake cmake-data libcairo2-dev libxcb1-dev
    libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev
    libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev
    libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev cmake-extras cmake-format
    cmake-vala cmake-valac automake autoconf autopoint autotools-dev base-files blueman
    bluetooth bluez bluez-firmware bluez-obexed curl wget xll-server-utils playerctl
    brightnessctl xorg xbindkeys network-manager intel-microcode dialog mtools dosfstools
    avahi-daemon acpi acpid network-manager-gnome
)

# Install all packages
for pkg in "${packages[@]}"; do
    sudo apt-get install -y "$pkg"
done

# Enable services
services=(
    avahi-daemon
    acpid
    bluetooth
)

for svc in "${services[@]}"; do
    sudo systemctl enable "$svc"
done
