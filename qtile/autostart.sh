#!/bin/sh
export GDK_SCALE=1
export GDK_DPI_SCALE=1;

export QT_QPA_PLATFORMTHEME=qt5ct
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

nextcloud &
picom -b &
nitrogen --restore
pipewire &
nm-applet &
~/.screenlayout/layout.sh &
xfce4-screensaver &
#/home/ezntek/.local/bin/volctl &
#systemctl --user import-environment PATH
#systemctl --user restart xdg-desktop-portal
