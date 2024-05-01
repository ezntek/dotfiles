#!/usr/bin/env bash

rm ~/.config/waybar/config && ln ~/.config/waybar/config-docked.json5 ~/.config/waybar/config
pkill waybar

if [[ "$(pgrep dinit)" == "" ]]; then
    waybar & disown
fi
