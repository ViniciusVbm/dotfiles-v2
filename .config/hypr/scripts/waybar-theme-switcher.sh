#!/bin/bash

THEME_DIR="$HOME/.config/waybar/themes"

THEME=$(ls $THEME_DIR | rofi -dmenu -p "Waybar Theme")

if [ -z "$THEME" ]; then
    exit
fi

cp "$THEME_DIR/$THEME/config.jsonc" ~/.config/waybar/config.jsonc
cp "$THEME_DIR/$THEME/style.css" ~/.config/waybar/style.css

killall waybar
waybar &
