# QEMUDrivers

Drivers and related software for QEMU/KVM virtual machines primarily running on Proxmox VE.

The `main` branch provides installable packages organized by operating system and device. The repository focuses on working driver versions rather than maintaining an archive of every upstream release.

## Repository structure

- [`1-Certs`](1-Certs/) — Certificates for supported packages.
- [`2-Drivers`](2-Drivers/) — Drivers organized by operating system and device type.
- [`3-SPICE-Agent`](3-SPICE-Agent/) — SPICE guest components.
- [`4-QEMU-Agent`](4-QEMU-Agent/) — QEMU guest components.

Source code, patch scripts, and build utilities developed for this repository are maintained separately in the [`patches` branch](https://github.com/CoccodrillooXDS/QEMUDrivers/tree/patches).

## Copyright and licensing

This branch contains software from multiple copyright holders. **No single repository-wide license applies to the packages on `main`.** Each component remains subject to its own copyright and licensing terms. Refer to its accompanying documentation, license notices, `.inf` files, and copyright metadata for details.

Original source code, scripts, and patches developed for QEMUDrivers are licensed under the [MIT License in the `patches` branch](https://github.com/CoccodrillooXDS/QEMUDrivers/blob/patches/LICENSE), unless otherwise noted. That license does not apply to proprietary or third-party binaries distributed on `main`.

Identified copyright holders include, but are not limited to:

- AlterWare
- AnaPa Corp
- BearWindows
- Cirrus Logic
- Intel
- LSI Logic
- Microsoft
- Red Hat
- Realtek
- Renesas
- VMware
- JHRobotics

### Red Hat license notice

Copyright 2009-2017 Red Hat, Inc. and/or its affiliates.
Copyright 2016 Google, Inc.
Copyright 2016 Virtuozzo, Inc.
Copyright 2007 IBM Corporation

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.

Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.

Neither the name of the copyright holder nor the names of its
contributors may be used to endorse or promote products derived from
this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
