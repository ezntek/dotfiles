#!/bin/sh

#dinit &
hyprpm reload &
nextcloud &
#/usr/local/libexec/xdg-desktop-portal -v -r &
#/usr/local/libexec/xdg-desktop-portal-hyprland -l DEBUG &
#hypridle &
#waypaper --restore &
hypridle &
nm-applet &
hyprpaper &
gnome-keyring-daemon&

sleep 1
waybar &

#ibus-daemon -rxRd &
