#!/bin/sh

waybar &
hyprpm reload &
nextcloud &
dunst &
#/usr/local/libexec/xdg-desktop-portal -v -r &
#/usr/local/libexec/xdg-desktop-portal-hyprland -l DEBUG &
hypridle &
waypaper --restore &
nm-applet &
ibus-daemon -rxRd &
