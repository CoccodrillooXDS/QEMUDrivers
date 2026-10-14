QEMU pvpanic Driver 1.4
=======================
Automatic VM power-off through QEMU ISA pvpanic for the following non-ACPI compliant systems:
  Windows NT 3.51 (x86)
  Windows NT 4.0  (x86)

QEMU configuration
------------------
The guest requires ISA pvpanic at I/O port 0x505 with event 0x04 enabled:

  -device pvpanic,ioport=0x505,events=7

You can add this line to your existing QEMU command-line arguments.

Installation
------------
1. Place QEMUPWR.EXE and QEMUPWR.SYS in the same directory.
2. Run QEMUPWR.EXE as Administrator.
3. Select "Install".

Operation
---------
"Shutdown" powers off the virtual machine and closes the QEMU process using the pvpanic device.
"Shutdown and Restart" reboots the virtual machine normally.

Removal
-------
Run QEMUPWR.EXE and select "Uninstall". The service and driver hooks are
restored before removal. Deletion of an executable in use may require
a reboot.

Diagnostics
-----------
"Info" displays kernel compatibility and pvpanic capabilities.
"Save Report" writes a diagnostic text file to the selected location.

Available Command-line actions: SCAN, INSTALL, STATUS, REMOVE.

Source: https://github.com/CoccodrillooXDS/QEMUDrivers/tree/patches/QEMU/pvpanic/1.4
