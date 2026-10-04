#!/usr/bin/env nix-shell
#! nix-shell -i bash -p bash

echo "what system do you want to install? desktop, laptop, homelab, steamMachine."
read system

echo "building $system!"
cp /etc/nixos/hardware-configuration.nix ~/nixos/host/$system/hardware-configuration.nix
sudo nixos-rebuild switch --flake ~/nixos#$system

