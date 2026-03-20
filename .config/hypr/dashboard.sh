#!/bin/bash

# Verifica se o dashboard já está aberto procurando por "dashboard_fastfetch" na lista de clientes
if hyprctl clients | grep -q "dashboard_fastfetch"; then
    
    # --- MODO FECHAR ---
    # Se encontrou o dashboard, fecha todas as janelas específicas
    hyprctl dispatch closewindow title:dashboard_fastfetch
    hyprctl dispatch closewindow title:dashboard_clock
    hyprctl dispatch closewindow title:dashboard_bonsai
    hyprctl dispatch closewindow title:dashboard_btop
    hyprctl dispatch closewindow title:dashboard_cava

else

    # --- MODO ABRIR ---
    # Se NÃO encontrou, executa a sequência de abertura
    
    # 1. Limpa workspace e vai para o 1
    hyprctl dispatch workspace 1
    
    # 2. Inicia Fastfetch
    kitty -o confirm_os_window_close=0 --title "dashboard_fastfetch" --hold sh -c "fastfetch" &
    sleep 0.5
    
    # 3. Inicia Relógio
    kitty -o confirm_os_window_close=0 --title "dashboard_clock" --hold sh -c "tty-clock -c -C 4 -r -s -f '%d/%m/%Y'" &
    sleep 0.5
    
    # 4. Inicia Bonsai (Foca no Fastfetch primeiro para dividir verticalmente)
    hyprctl dispatch focuswindow title:dashboard_fastfetch
    sleep 0.2
	kitty -o confirm_os_window_close=0 --title "dashboard_bonsai" --hold sh -c "cbonsai -l -i -L 40" &
    sleep 0.5
    
    # 5. Inicia Btop (Foca no Relógio para dividir verticalmente)
    hyprctl dispatch focuswindow title:dashboard_clock
    sleep 0.2
	kitty -o confirm_os_window_close=0 --title "dashboard_btop" --hold sh -c "btop" &
    sleep 0.5
    
    # 6. Inicia Cava (Foca no Bonsai para dividir horizontalmente)
    hyprctl dispatch focuswindow title:dashboard_bonsai
    sleep 0.2
	kitty -o confirm_os_window_close=0 --title "dashboard_cava" --hold sh -c "cava" &

fi
