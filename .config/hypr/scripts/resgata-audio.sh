#!/bin/bash
# Script robusto para forçar o desmuto do áudio após boot/reboot

# Espera 2 segundinhos para o PipeWire e WirePlumber estabilizarem
sleep 2

# Tenta desmutar tudo em loop por um tempo
for i in {1..5}; do
    # 1. Força o Hardware Físico (ALSA) a desmutar
    # Tentamos nas placas 0 e 1 por segurança (geralmente é -c 0 para Intel)
    amixer -c 0 sset Speaker unmute >/dev/null 2>&1
    amixer -c 0 sset Headphone unmute >/dev/null 2>&1
    amixer -c 0 sset Master unmute >/dev/null 2>&1

    amixer -c 1 sset Speaker unmute >/dev/null 2>&1
    amixer -c 1 sset Headphone unmute >/dev/null 2>&1
    amixer -c 1 sset Master unmute >/dev/null 2>&1

    # 2. Força o Gerenciador (PipeWire/WirePlumber) a desmutar
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 >/dev/null 2>&1

    # Espera mais um segundo antes da próxima tentativa
    sleep 1
done
