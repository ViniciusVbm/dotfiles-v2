#!/bin/bash

# Monitora as mudanças feitas pelo nwg-look no tema do cursor
gsettings monitor org.gnome.desktop.interface cursor-theme | while read -r key theme; do
    # Remove as aspas simples que vêm no output do gsettings
    clean_theme=$(echo "$theme" | tr -d "'")
    
    # Aplica instantaneamente no Hyprland com o nome correto
    hyprctl setcursor "$clean_theme" 24
done
