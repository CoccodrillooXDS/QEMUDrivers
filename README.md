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

The [source code](QEMU/pvpanic/1.4/) produces `QEMUPWR.EXE` and `QEMUPWR.SYS`.

The tested driver packages are provided on `main` for [Windows NT 3.51](https://github.com/CoccodrillooXDS/QEMUDrivers/tree/main/2-Drivers/1995-NT3.51/Power/QEMU%20pvpanic) and [Windows NT 4.0](https://github.com/CoccodrillooXDS/QEMUDrivers/tree/main/2-Drivers/1996-NT4/Power/QEMU%20pvpanic).

## Copyright and licensing

Original drivers and third-party components remain subject to their respective copyright and license terms. Any included patches or utilities should be considered separately from the licensing of the software they modify.
