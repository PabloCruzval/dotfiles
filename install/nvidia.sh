#!/bin/bash

info "Configuring NVIDIA for Wayland..."

if [ ! -f "/etc/modprobe.d/nvidia.conf" ]; then
    echo "options nvidia_drm modeset=1 fbdev=1" | sudo tee /etc/modprobe.d/nvidia.conf > /dev/null
    ok "NVIDIA DRM modeset and fbdev enabled."
else
    ok "NVIDIA modprobe configuration already exists."
fi

if ! grep -q "nvidia nvidia_modeset" /etc/mkinitcpio.conf; then
    sudo sed -i 's/^MODULES=(/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm /' /etc/mkinitcpio.conf
    info "Regenerating initramfs..."
    sudo mkinitcpio -P
    ok "Early KMS configured and initramfs regenerated."
else
    ok "Early KMS modules already configured."
fi

sudo mkdir -p /etc/pacman.d/hooks
if [ ! -f "/etc/pacman.d/hooks/nvidia.hook" ]; then
    sudo tee /etc/pacman.d/hooks/nvidia.hook > /dev/null <<EOF
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia-lts
Target=linux-lts

[Action]
Description=Update NVIDIA module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case \$trg in linux-lts) exit 0; esac; done; /usr/bin/mkinitcpio -P'
EOF
    ok "NVIDIA pacman hook created."
else
    ok "NVIDIA pacman hook already exists."
fi

if ! sudo systemctl is-enabled nvidia-suspend.service &>/dev/null; then
    sudo systemctl enable nvidia-suspend.service
    sudo systemctl enable nvidia-hibernate.service
    sudo systemctl enable nvidia-resume.service
    ok "NVIDIA power management services enabled."
else
    ok "NVIDIA power management services already enabled."
fi

ok "NVIDIA configuration completed."