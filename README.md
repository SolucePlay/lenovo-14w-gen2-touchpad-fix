# Lenovo 14w Gen 2 - Touchpad Fix for Linux

This repository contains a manual ACPI DSDT override to fix the **Elan I2C Touchpad** bug on the Lenovo 14w Gen 2 (AMD model). 

## The Problem
The BIOS fails to provide a valid IRQ for the touchpad because the `_CRS` method in the DSDT table lacks a default return statement. Linux falls back to **IRQ 0**, causing the driver to fail (`error -16`).

## The Fix
This patch bypasses the buggy check and forces the correct I2C address (`0x15`) and GPIO Interrupt (`0x09`).

## Files
- `dsdt.dsl`: Source code of the patched DSDT.
- `acpi-override.cpio`: Ready-to-use capsule for GRUB injection.

## Installation
1. Copy `acpi-override.cpio` to your `/boot/` folder:
   `sudo cp acpi-override.cpio /boot/`
2. Edit your GRUB configuration:
   `sudo nano /etc/default/grub`
3. Add the following line at the end:
   `GRUB_EARLY_INITRD_LINUX_CUSTOM="acpi-override.cpio"`
4. Update GRUB and reboot:
   `sudo update-grub && sudo reboot`
