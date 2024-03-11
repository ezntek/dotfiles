#!/bin/sh

dinit &
hyprpm reload &
nextcloud &
#/usr/local/libexec/xdg-desktop-portal -v -r &
#/usr/local/libexec/xdg-desktop-portal-hyprland -l DEBUG &

/home/ezntek/.local/bin/waypaper --restore
