QEMU pvpanic Driver 1.4
=======================
Automatic VM power-off through QEMU ISA pvpanic for the following
non-ACPI compliant systems:
  Windows NT 3.51 (x86)
  Windows NT 4.0  (x86)

DISCLAIMER
----------
QEMUPWR was developed with assistance from AI (ChatGPT by OpenAI).
It is an independent project and is not affiliated with, endorsed by,
or supported by the QEMU project or its developers.

The driver has been tested on Windows NT 3.51 SP5 (x86, build 1057)
and Windows NT 4.0 SP6 (x86, build 1381). Compatibility with other
versions or configurations has not been verified.

This software is provided "as is", without warranty of any kind.
The author assumes no responsibility for damage or data loss arising
from its use. Use at your own risk.

If you prefer not to install QEMUPWR, you can still power off the VM
from the Proxmox web interface or with qm stop <VMID>.

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
"Shutdown" powers off the virtual machine and closes the QEMU process 
using the pvpanic device.
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

Source: https://github.com/CoccodrillooXDS/QEMUPWR/
