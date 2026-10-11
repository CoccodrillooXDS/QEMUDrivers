# VMware VMMouse 12.4.0.3 — Windows NT 3.51 patch

Reproducible binary patch for VMware VMMouse 12.4.0.3 (x86), adapted from its Windows NT 4.0 version to Windows NT 3.51 for QEMU/KVM.

The installable package is distributed on the [`main` branch](https://github.com/CoccodrillooXDS/QEMUDrivers/tree/main/2-Drivers/1995-NT3.51/Mouse). This development project contains no driver binaries.

## Input and output

| File | SHA-256 |
| --- | --- |
| Original NT 4.0 `vmmouse.sys` | `f84cbcca5464c797f60ebc66ecc74cb32b5fabcaa9fbd4d84dbe9f6a373a4e76` |
| Patched NT 3.51 `VMMOUSE.SYS` | `64ef6c103db6d63c86e024bfe0454cac7c7ad4f23a3f539c293897c351a7fc5e` |

## Reproduce

Run on macOS or Linux with Python 3. Python packages are not required.

From a checkout of QEMUDrivers, while on the `patches` branch:

```sh
git fetch origin main
git show origin/main:2-Drivers/1996-NT4/Mouse/12.4.0.3/vmmouse.sys > /tmp/vmmouse-nt4.sys
git show origin/main:2-Drivers/1995-NT3.51/Mouse/VMMOUSE.SYS > /tmp/vmmouse-nt351-reference.sys

python3 patch_vmmouse_nt351.py \
  --input /tmp/vmmouse-nt4.sys \
  --output /tmp/VMMOUSE.SYS \
  --verify-against /tmp/vmmouse-nt351-reference.sys
```

The command refuses an unexpected source binary, checks the resulting SHA-256, and optionally compares every output byte against the file published in `main`. The output is not installed automatically.

## Changes

- Replaces an 8-byte diagnostic breakpoint call at file offset `0x14DF` with NOPs.
- Changes the `DbgBreakPointWithStatus` imported function name to `DbgBreakPoint` at file offset `23190`, preserving the import record size.
- Changes the PE optional-header OS, image and subsystem version fields from `4.0` to `3.51`.
- Recomputes the PE checksum.

The patch does not implement a mouse device or keyboard driver from scratch. It adapts the original VMware kernel driver.

## Installation and testing

The patched binary requires the separate native Windows NT Setup `OEMSETUP.INF` available in the `main` package. The validated installer uses an independent `VMMouse` service with `Start=1`, retaining PS/2 keyboard input and providing absolute mouse positioning through QEMU. The Microsoft `i8042prt.sys` file is not modified.

This adaptation was tested on Windows NT 3.51 x86 running under Proxmox VE / QEMU/KVM; no broader compatibility is implied.

## Attribution

The original driver is VMware software and remains subject to its applicable licensing terms. This project documents a third-party binary adaptation; it does not grant a license to redistribute the original VMware driver.
