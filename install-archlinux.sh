#!/bin/bash
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Lance ce script avec sudo."
    exit 1
fi

if [ ! -f "acpi-override.cpio" ]; then
    echo "Erreur : acpi-override.cpio introuvable."
    exit 1
fi

if [ ! -f "/boot/grub/grub.cfg" ]; then
    echo "Erreur : GRUB ne semble pas installé dans /boot/grub."
    exit 1
fi

echo "==> Sauvegarde de GRUB"
cp -a /etc/default/grub /etc/default/grub.backup-touchpad
cp -a /boot/grub/grub.cfg /boot/grub/grub.cfg.backup-touchpad

echo "==> Installation ACPI override"
install -m 0644 acpi-override.cpio /boot/acpi-override.cpio

echo "==> Configuration GRUB"

if grep -q '^GRUB_EARLY_INITRD_LINUX_CUSTOM=' /etc/default/grub; then
    sed -i \
        's|^GRUB_EARLY_INITRD_LINUX_CUSTOM=.*|GRUB_EARLY_INITRD_LINUX_CUSTOM="acpi-override.cpio"|' \
        /etc/default/grub
else
    echo 'GRUB_EARLY_INITRD_LINUX_CUSTOM="acpi-override.cpio"' >> /etc/default/grub
fi

echo "==> Génération de grub.cfg"
grub-mkconfig -o /boot/grub/grub.cfg

echo
echo "==> Vérification"
grep -n "acpi-override.cpio" /boot/grub/grub.cfg || true

echo
echo "Installation terminée."
echo "Redémarre avec : sudo reboot"