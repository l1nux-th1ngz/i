
#!/bin/bash

# Update package lists
sudo apt update

# Upgrade installed packages
sudo apt upgrade -y

# Clean up apt cache
sudo apt clean

# Remove unused packages
sudo apt autoremove -y

# Update package lists
sudo apt update

# Upgrade installed packages
sudo apt upgrade -y

# Reboot the system
sudo reboot
