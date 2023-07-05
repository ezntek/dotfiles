#!/bin/sh
export QT_QPA_PLATFORMTHEME=qt5ct
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

ibus-daemon &
light-locker &
picom -b
systemctl --user import-environment PATH
systemctl --user restart xdg-desktop-portal
~/.screenlayout/layout.sh
