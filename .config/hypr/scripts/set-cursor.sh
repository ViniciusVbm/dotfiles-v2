#!/bin/bash

THEME=$1
SIZE=${2:-24} # Usa o tamanho 24 por padrão se você não especificar outro

if [ -z "$THEME" ]; then
    echo "Erro: Você precisa informar o nome do tema."
    echo "Uso: ./set-cursor.sh <Nome-Do-Tema> [tamanho]"
    echo "Exemplo: ./set-cursor.sh Bibata-Modern-Ice"
    exit 1
fi

echo "Aplicando cursor: $THEME (Tamanho: $SIZE)..."

# 1. Aplica no Hyprland (área de trabalho e bordas)
hyprctl setcursor "$THEME" "$SIZE"

# 2. Aplica nos aplicativos GTK (Brave, Nemo, etc)
gsettings set org.gnome.desktop.interface cursor-theme "$THEME"
gsettings set org.gnome.desktop.interface cursor-size "$SIZE"

# 3. Aplica no fallback do XWayland (programas mais antigos)
mkdir -p ~/.icons/default
echo -e "[Icon Theme]\nInherits=$THEME" > ~/.icons/default/index.theme

echo "Pronto! Cursor alterado com sucesso."
