#!/usr/bin/env zsh
# autostart.sh
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots &
systemctl --user stop wireplumber pipewire xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk &
systemctl --user start wireplumber
