#!/bin/sh

hyprpm reload &
waybar &
dunst &
gentoo-pipewire-launcher &
#/usr/local/libexec/xdg-desktop-portal -v -r &
#/usr/local/libexec/xdg-desktop-portal-hyprland -l DEBUG &

/home/ezntek/.local/bin/waypaper --restore
