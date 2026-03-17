cp acpi-override.cpio /boot/
grep -q "GRUB_EARLY_INITRD_LINUX_CUSTOM" /etc/default/grub || echo 'GRUB_EARLY_INITRD_LINUX_CUSTOM="acpi-override.cpio"' >> /etc/default/grub
update-grub
