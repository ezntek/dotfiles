#!/bin/sh
nitrogen --restore
picom -bf 
~/.screenlayout/layout.sh
pipewire &
wireplumber &
pipewire-pulse &
