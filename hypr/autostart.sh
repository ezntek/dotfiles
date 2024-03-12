#!/bin/sh

dinit &
hyprctl setcursor Qogir 24 &
hyprpm reload &
nextcloud &
#/usr/local/libexec/xdg-desktop-portal -v -r &
#/usr/local/libexec/xdg-desktop-portal-hyprland -l DEBUG &
kdeconnect-indicator &
waypaper --restore
