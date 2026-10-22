# QEMUDrivers — Patches

This branch contains patches, source code, build utilities, and technical documentation for modified drivers and related components in [QEMUDrivers](https://github.com/CoccodrillooXDS/QEMUDrivers).

## About this branch

The [`main` branch](https://github.com/CoccodrillooXDS/QEMUDrivers/tree/main) provides ready-to-use drivers, installers, certificates, and guest agents for QEMU/KVM virtual machines.

The `patches` branch keeps the development material separate from those distributable files. Depending on the sub-project, this may include binary patches, scripts, adapted installer sources, build instructions, or verification tools.

The two branches serve different purposes and do not need to contain the same files.

## Sub-projects

### VMware VMMouse for Windows NT 3.51

An unofficial backport of VMware VMMouse 12.4.0.3 driver from Windows NT 4.0 to Windows NT 3.51 (x86) on QEMU/KVM, tested with Proxmox VE.

The patch enables the driver to run on NT 3.51 while preserving PS/2 keyboard input and providing absolute mouse positioning.

The tested, installable driver package is available on [`main`](https://github.com/CoccodrillooXDS/QEMUDrivers/tree/main/2-Drivers/1995-NT3.51/Mouse).

### QEMUPWR for Windows NT 3.51 and NT 4.0

QEMUPWR 1.4 enables automatic VM power-off on Windows NT 3.51 and Windows NT 4.0 through the QEMU ISA pvpanic shutdown event (`0x04`), without requiring guest ACPI support.

QEMUPWR is maintained in its [dedicated repository](https://github.com/CoccodrillooXDS/QEMUPWR), which contains the source code, build tools, and [v1.4 release](https://github.com/CoccodrillooXDS/QEMUPWR/releases/tag/v1.4). Its original commits remain available in this branch's Git history.

The tested driver packages are provided on `main` for [Windows NT 3.51](https://github.com/CoccodrillooXDS/QEMUDrivers/tree/main/2-Drivers/1995-NT3.51/Power/QEMU%20pvpanic) and [Windows NT 4.0](https://github.com/CoccodrillooXDS/QEMUDrivers/tree/main/2-Drivers/1996-NT4/Power/QEMU%20pvpanic).

## Copyright and licensing

Original source code, scripts, and patches developed for this repository are licensed under the MIT License, unless otherwise noted. See [LICENSE](LICENSE).

Third-party software and components remain subject to their respective licenses and copyright terms. The MIT License does not grant rights to the original software modified by these projects.

The `main` branch contains redistributable driver packages and other components governed by their respective licenses.