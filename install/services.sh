#!/bin/bash

info "Configuring system and user services..."

system_services=(
    "NetworkManager.service"
    "bluetooth.service"
)

user_services=(
    "theme.timer"
    "syncthing.service"
)

info "Enabling system services..."
for svc in "${system_services[@]}"; do
    if sudo systemctl is-enabled "$svc" &>/dev/null; then
        ok "[$svc] was already enabled."
    else
        warn "Enabling and starting [$svc]..."
        sudo systemctl enable --now "$svc"
        ok "[$svc] enabled successfully."
    fi
done

info "Enabling user services..."
for usvc in "${user_services[@]}"; do
    if systemctl --user is-enabled "$usvc" &>/dev/null; then
        ok "[$usvc] was already enabled."
    else
        warn "Enabling and starting [$usvc]..."
        systemctl --user enable --now "$usvc"
        ok "[$usvc] enabled successfully."
    fi
done

echo ""
ok "Services setup completed."