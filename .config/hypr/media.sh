#!/bin/bash

# Verifica se o playerctl está instalado
if ! command -v playerctl &> /dev/null; then
    echo "playerctl não instalado"
    exit 0
fi

# Pega o status atual
status=$(playerctl status 2>/dev/null)

if [ "$status" == "Playing" ] || [ "$status" == "Paused" ]; then
    playerctl metadata --format '  {{title}}     {{artist}}'
else
    echo "  Nenhuma mídia em reprodução"
fi
