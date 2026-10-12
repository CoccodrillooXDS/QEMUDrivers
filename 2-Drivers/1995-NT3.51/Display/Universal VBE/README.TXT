VBEMP - Windows NT 3.51 (x86)
==============================

Source: Bearwindows / AnaPa Corp
Driver: VBEMPJ

FILES
-----
OEMSETUP.INF   Original Windows NT 3.5x display setup script
VBEMP.SYS      Original AnaPa Corp VBE 2.0 miniport driver
DISK1          Original OEM media marker required by setup
FRAMEBUF.DLL   NT 3.5x framebuffer display DLL
LIC.HTM        Original VBEMP license
PREPARE.CMD    NT 3.51 setup helper (QEMUDrivers addition)
README.TXT     This document

INSTALLATION
------------
1. Back up/snapshot the Windows NT 3.51 VM first.
2. Double-click PREPARE.CMD to copy the VBEMP driver files in C:\VBEMP.
3. PREPARE.CMD copies the original OEMSETUP.INF, VBEMP.SYS and DISK1
   to C:\VBEMP. If FRAMEBUF.DLL is missing, it copies the supplied
   NT35X version to %SystemRoot%\SYSTEM32. Existing FRAMEBUF.DLL
   is not overwritten.
4. Open Control Panel > Display > Change Display Type > Change > Other.
   Enter C:\VBEMP as the OEM source path and select an
   "AnaPa Corp VBE Miniport" mode and specify C:\VBEMP
   as the source directory when prompted for the OEM disk.
5. Restart normally. Use the Display control panel to change the
   resolution or color depth as supported by the driver.

RECOVERY
--------
If normal startup fails, boot Windows NT in VGA Mode.
If a STOP c0000143 ("framebuf" missing or bad) error occurs when VBEMP was
installed without FRAMEBUF.DLL in %SystemRoot%\SYSTEM32, you must reinstall
the driver with the correct FRAMEBUF.DLL.
Do not substitute an NT 4.0/2000/XP FRAMEBUF.DLL for the NT35X file.

NOTES
-----
- This is a VESA BIOS Extensions display driver, not a native QXL driver.
- The QXL device may still be used to provide the Proxmox SPICE console.
- OEMSETUP.INF, VBEMP.SYS, DISK1, FRAMEBUF.DLL and LIC.HTM are exact,
  unmodified copies from the source ISO. PREPARE.CMD is separate.
- The PREPARE.CMD script is designed to facilitate the installation of the VBEMP driver
  on a Windows NT 3.51 VM in QEMU/KVM. It is not part of the original driver package.

SHA-256 (original binary files)
-------------------------------
VBEMP.SYS    a592e03dac8b2e24995799092375fd8b95d1bfda2a12b26a5bd4fe6987df01e4
FRAMEBUF.DLL 40cc702fd06eb5cea6b24f13bd512aaabc52f0780404857542818bcb9f168074
