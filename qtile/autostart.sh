#!/bin/sh
export GDK_SCALE=1
export GDK_DPI_SCALE=1;

export QT_QPA_PLATFORMTHEME=qt5ct
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

ibus-daemon &
light-locker &
systemctl --user import-environment PATH
systemctl --user restart xdg-desktop-portal
~/.screenlayout/layout.sh
picom -b --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffness 350 &
