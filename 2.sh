#!/bin/bash

# List of packages to install
packages=(i3 ranger xdg-user-dirs xdg-user-dirs-gtk dex pulseaudio nm-tray feh
           fonts-font-awesome fonts-powerline fonts-ubuntu fonts-liberation2
           fonts-liberation fonts-terminus fonts-cascadia-code gnugpg chromium
           geany geany-plugins geany-commons notepadqq notepadqq-common
           notepadqq-gtk gdebi synaptic cmus cava dunst ffmpeg
           cmus-plugin-ffmpeg cpio cron debconf dialog zenity efibootmgr
           exfatprogs fakeroot fdisk ffmpegthumbnailer gdebi-core gparted gvfs
           gvfs-backends gvfs-common gzip kbd mpv vlc mpd)

# Install packages
sudo apt install -f -y "${packages[@]}"

# Update and configure package manager
sudo apt-get update && sudo dpkg --configure --pending && sudo dpkg --purge --remaining-package-config-files

exit 0