#!/bin/bash

# Obtém o ID do sink (saída) padrão atual
CURRENT_SINK=$(wpctl status | grep "*" | grep "Vol" | awk '{print $2}' | tr -d '.')

# Lista todos os sinks disponíveis, pega os IDs e filtra
# A lógica aqui é encontrar o "próximo" ID na lista para alternar
NEXT_SINK=$(wpctl status | grep "Vol" | grep -v "Default" | awk '{print $2}' | tr -d '.' | grep -A 1 $CURRENT_SINK | tail -n 1)

# Se não houver "próximo" (estamos no último), volta para o primeiro
if [ -z "$NEXT_SINK" ]; then
    NEXT_SINK=$(wpctl status | grep "Vol" | grep -v "Default" | awk '{print $2}' | tr -d '.' | head -n 1)
fi

# Define o novo padrão
wpctl set-default $NEXT_SINK

# (Opcional) Envia notificação visual para saber que trocou
DEVICE_NAME=$(wpctl inspect @DEFAULT_AUDIO_SINK@ | grep "node.nick" | awk -F '"' '{print $2}')
notify-send -t 2000 "Áudio Alterado" "Saída: $DEVICE_NAME"
