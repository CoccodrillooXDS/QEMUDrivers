VMware VMMouse 12.4.0.3 patched for Windows NT 3.51
================================================

Patched VMware VMMouse driver for Windows NT 3.51 (x86) on QEMU/KVM.
Tested with Proxmox VE. This is an unofficial adaptation of the NT 4.0
driver, not an official VMware release.

The binary has been patched to accommodate NT 3.51's PE loader and
available kernel functions. It provides absolute mouse positioning
through QEMU's VMware VMMouse device while retaining PS/2 keyboard input.


DISCLAIMER
----------
This driver was backported from the NT 4.0 version and adapted for Windows NT 3.51.
It was backported with assistance from AI (ChatGPT by OpenAI).
It is an independent project and is not affiliated with, endorsed by,
or supported by the QEMU project or VMware or its developers.

The driver has been tested on Windows NT 3.51 SP5 (x86, build 1057)

This software is provided "as is", without warranty of any kind.
The author assumes no responsibility for damage or data loss arising
from its use. Use at your own risk.


FILES
-----
OEMSETUP.INF  Native Windows NT 3.x Setup installer
VMMOUSE.SYS   Patched VMware VMMouse 12.4.0.3 driver
VMMOUSE.TAG   OEM setup media identifier
README.TXT    This file


INSTALLATION
------------
1. Use a QEMU/KVM VM exposing the VMware VMMouse device. QEMU should
   already hiddenly expose this device by default and enable it when
   the driver is installed.
2. Make a VM snapshot to preserve the current mouse and keyboard
   configuration in case there are issues with the new driver.
3. Open Windows NT Setup.
4. Select Options > Change Mouse or Keyboard > Other.
5. Select the directory containing OEMSETUP.INF, then VMware VMMouse.
6. Restart Windows NT when prompted.


RESTORING THE PREVIOUS DRIVER
-----------------------------
Open Windows NT Setup > Options > Change Mouse or Keyboard, select the
previous driver, then restart Windows NT.


MOUSE AND KEYBOARD TROUBLESHOOTING
----------------------------------
If the mouse and keyboard stop working after installing VMware VMMouse,
verify that QEMU is exposing the VMware VMMouse device.

You can check this using the QEMU monitor command (info mice). The device
should appear as
    * vmmouse (absolute positioning)

If it's missing, check the VM configuration to ensure that VMware
VMMouse support is enabled.

If the problem persists, you can attempt to restore the previous driver
configuration using the Windows NT's Last Known Good Configuration
feature:
1. Reboot the VM.
2. When prompted during the Windows NT startup, press SPACEBAR to access
   the Configuration Recovery menu.
3. Select "Use Last Known Good Configuration" and press ENTER.

The system will proceed to boot with the previously known working system
configuration, which should restore the original mouse and keyboard
functionality.

If the recovery is unsuccessful, restore the VM snapshot or backup, if
available.


TECHNICAL NOTES
---------------
The installer creates the VMMouse service using the existing i8042prt
service configuration. VMMouse starts in the System phase (Start=1),
and the original i8042prt service is disabled (Start=4). The Microsoft
i8042prt.sys file itself is not modified. The keyboard and mouse both
depend on the replacement port driver; keep a VM snapshot available
before changing input drivers.

VMMOUSE.SYS SHA-256:
64ef6c103db6d63c86e024bfe0454cac7c7ad4f23a3f539c293897c351a7fc5e


CREDITS AND LICENSING
---------------------
VMMOUSE.SYS is a modified VMware driver. VMware retains its rights to
the original binary; its redistribution is subject to applicable VMware
license terms. The NT 3.51 patch and OEM installer are third-party work.

The OEM installer draws on Goldfish64/hyperv_nt:
https://github.com/Goldfish64/hyperv_nt
The MIT license reproduced below accompanies portions of OEMSETUP.INF
adapted from that project. It does not apply to VMMOUSE.SYS.


MIT LICENSE - OEM INSTALLER COMPONENTS
--------------------------------------
MIT License

Copyright (c) 2026 John Davis

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
