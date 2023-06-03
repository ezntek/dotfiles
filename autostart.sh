#!/bin/sh
export QT_QPA_PLATFORMTHEME=qt5ct

light-locker &
picom -b
systemctl --user import-environment PATH
systemctl --user restart xdg-desktop-portal
~/.screenlayout/layout.sh
