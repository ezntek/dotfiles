#!/bin/sh
picom -bf 
~/.screenlayout/layout.sh
pipewire &
pipewire-pulse &
wireplumber &
