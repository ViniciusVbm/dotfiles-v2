#!/bin/bash

# Verifica se o relógio específico já está rodando
if pgrep -f "float_clock"; then
    # Se sim, fecha tudo
    pkill -f "float_clock"
    pkill -f "float_cava"
else
    # Se não, abre as janelas
    
    # 1. CAVA (Visualizer)
    kitty --class float_cava --title "Widget Cava" -e cava &
    
    # 2. RELÓGIO (Tty-clock)
    # Ajuste as cores ou formato se quiser
    kitty --class float_clock --title "Widget Clock" -e tty-clock -c -C 4 -s -B &
fi
