Realtek RTL8139 PCI - Windows NT 3.51 (x86)
===========================================

Source: Realtek RTL8139 Family PCI/CardBus Fast Ethernet NIC Driver Disk v5.00.
Original driver files: EXE/NT351/ (unmodified).
The OEMSETUP.INF reports product version 3.11; v5.00 is the disk release.

FILES
-----
OEMSETUP.INF   Windows NT Network Control Panel installer
RTL8139.SYS    Realtek NDIS miniport driver for Windows NT 3.51
RTSNTHLP.HLP   Driver configuration help

INSTALLATION
------------
1. In Proxmox, configure the VM network adapter as RTL8139 (PCI).
2. In Windows NT 3.51, open Control Panel > Network > Add Adapter.
3. Select the option to supply a manufacturer disk and point to this folder.
4. Install the Realtek RTL8139 adapter and restart if requested.
5. Configure TCP/IP (DHCP or static) and verify with ipconfig /all.

VALIDATION
----------
Tested on Windows NT 3.51 x86 with SP5 and post-SP5 fixes,
Proxmox VE/QEMU pc-i440fx-9.1 and an emulated RTL8139 PCI NIC.
DHCP, gateway, DNS and Internet connectivity confirmed.

RTL8139.SYS SHA-256:
45a3a31e676bde2e937bda56bad08ed005ac008814e8dabd7dcaf613ff8908a0
