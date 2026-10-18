#!/bin/bash

# NixOS TUI Installer (Bash Version)

# Clear the screen and display the menu
clear

echo -e "\nNixOS TUI Installer"
echo -e "Choose your system configuration:"
echo -e "1) Desktop"
echo -e "2) Laptop"
echo -e "3) Homelab"
echo -e "4) Steam Machine"
echo -e "Select an option (1-4) or q to quit: "
read -p "" choice

clear

# Process the user's choice
if [[ $choice == "q" || $choice == "Q" ]]; then
    echo "Quitting installer..."
    exit 0
fi

 case $choice in
     1) 
         echo "Rebuilding Desktop configuration..."
         sudo nixos-rebuild switch --flake ~/nixos#desktop
         ;;
     2) 
         echo "Rebuilding Laptop configuration..."
         sudo nixos-rebuild switch --flake ~/nixos#laptop
         ;;
     3) 
         echo "Rebuilding Homelab configuration..."
         sudo nixos-rebuild switch --flake ~/nixos#homelab
         ;;
     4) 
         echo "Rebuilding Steam Machine configuration..."
         sudo nixos-rebuild switch --flake ~/nixos#steam-machine
         ;;
     *) 
         echo "Invalid selection. Please try again."
         exit 1
         ;;
 esac
