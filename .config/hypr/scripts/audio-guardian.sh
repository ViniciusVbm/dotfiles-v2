#!/bin/bash

# Função que metralha comandos para desmutar tudo sem dó
force_unmute() {
    # 1. Manda o WirePlumber (gerenciador oficial) desmutar
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    
    # 2. Força as placas físicas (ignora a placa virtual)
    for i in 0 1 2; do
        amixer -c $i sset Speaker unmute >/dev/null 2>&1
        amixer -c $i sset Headphone unmute >/dev/null 2>&1
        amixer -c $i sset Master unmute >/dev/null 2>&1
    done
}

# Roda uma vez logo que o Hyprland liga (Cobre o Reboot)
sleep 2
force_unmute

# Fica rodando invisível no fundo ouvindo o aviso de suspensão do sistema (Cobre a Suspensão)
dbus-monitor --system "type='signal',interface='org.freedesktop.login1.Manager',member='PrepareForSleep'" | while read -r line; do
    # "boolean false" significa que o PC acabou de acordar
    if echo "$line" | grep -q "boolean false"; then
        sleep 3
        force_unmute
        # Roda mais uma vez após 6s só para garantir que o WirePlumber não sobrescreveu
        sleep 3
        force_unmute
    fi
done
