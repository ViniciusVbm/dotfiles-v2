#!/bin/bash

# Espera 2 segundinhos pro sistema acordar e respirar
sleep 2

# Varre as placas 0 e 1 (Intel e NVIDIA)
for i in 0 1; do
    # 1º Golpe: Força o software a entender que está mutado
    amixer -c $i sset Speaker mute >/dev/null 2>&1
    amixer -c $i sset Headphone mute >/dev/null 2>&1
    
    # 2º Golpe: Força a abertura de energia e desmuta tudo
    amixer -c $i sset Speaker unmute >/dev/null 2>&1
    amixer -c $i sset Headphone unmute >/dev/null 2>&1
    amixer -c $i sset Master unmute >/dev/null 2>&1
done

# Garante que o gerenciador principal também libera o volume
wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
