#!/usr/bin/env python3
"""Reproduce the validated VMware VMMouse 12.4.0.3 patch for Windows NT 3.51.

This modifies a known NT 4.0 x86 driver binary. It does not install the
driver, alter the guest OS, or modify a QEMU/Proxmox configuration.
"""
import argparse
import hashlib
from pathlib import Path
import struct
import sys

ORIGINAL_SHA256 = "f84cbcca5464c797f60ebc66ecc74cb32b5fabcaa9fbd4d84dbe9f6a373a4e76"
PATCHED_SHA256 = "64ef6c103db6d63c86e024bfe0454cac7c7ad4f23a3f539c293897c351a7fc5e"
DRIVER_SIZE = 32304

DEBUG_CALL_OFFSET = 0x14DF
DEBUG_CALL_ORIGINAL = bytes.fromhex("6A 02 FF 15 AC 2B 01 00")
IMPORT_NAME_OFFSET = 23190
IMPORT_NAME_ORIGINAL = b"DbgBreakPointWithStatus\0"
IMPORT_NAME_REPLACEMENT = b"DbgBreakPoint\0"


def sha256(data):
    return hashlib.sha256(data).hexdigest()


def pe_checksum(data, field_offset):
    """Compute the PE image checksum with its CheckSum field zeroed."""
    image = bytearray(data)
    struct.pack_into("<I", image, field_offset, 0)
    if len(image) % 2:
        image.append(0)
    total = 0
    for i in range(0, len(image), 2):
        total += image[i] | (image[i + 1] << 8)
        total = (total & 0xFFFF) + (total >> 16)
    total = (total & 0xFFFF) + (total >> 16)
    return ((total & 0xFFFF) + len(data)) & 0xFFFFFFFF


def patch(data):
    if len(data) != DRIVER_SIZE:
        raise ValueError(f"Unexpected input size: {len(data)} (expected {DRIVER_SIZE})")
    if sha256(data) != ORIGINAL_SHA256:
        raise ValueError("Input SHA-256 does not match the supported NT 4.0 VMMouse binary")

    if data[:2] != b"MZ":
        raise ValueError("DOS header missing")
    pe = struct.unpack_from("<I", data, 0x3C)[0]
    if data[pe:pe + 4] != b"PE\0\0":
        raise ValueError("PE header missing")
    opt = pe + 24
    if (struct.unpack_from("<H", data, pe + 4)[0] != 0x14C or
            struct.unpack_from("<H", data, opt)[0] != 0x10B):
        raise ValueError("Expected PE32 image for x86")

    if data[DEBUG_CALL_OFFSET:DEBUG_CALL_OFFSET + 8] != DEBUG_CALL_ORIGINAL:
        raise ValueError("Unexpected bytes at diagnostic breakpoint call")
    end = IMPORT_NAME_OFFSET + len(IMPORT_NAME_ORIGINAL)
    if data[IMPORT_NAME_OFFSET:end] != IMPORT_NAME_ORIGINAL:
        raise ValueError("Unexpected imported function name")

    for relative in (40, 44, 48):
        if struct.unpack_from("<HH", data, opt + relative) != (4, 0):
            raise ValueError("Unexpected PE OS/Image/Subsystem version")

    result = bytearray(data)
    result[DEBUG_CALL_OFFSET:DEBUG_CALL_OFFSET + 8] = b"\x90" * 8
    result[IMPORT_NAME_OFFSET:end] = IMPORT_NAME_REPLACEMENT.ljust(
        len(IMPORT_NAME_ORIGINAL), b"\0"
    )
    for relative in (40, 44, 48):
        struct.pack_into("<HH", result, opt + relative, 3, 51)

    checksum_offset = opt + 64
    struct.pack_into("<I", result, checksum_offset, pe_checksum(result, checksum_offset))

    patched = bytes(result)
    if sha256(patched) != PATCHED_SHA256:
        raise ValueError("Generated driver does not match the validated NT 3.51 driver")
    return patched


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", required=True, type=Path,
                        help="Unmodified VMware VMMouse 12.4.0.3 NT 4.0 x86 binary")
    parser.add_argument("--output", required=True, type=Path,
                        help="Destination for the patched NT 3.51 binary")
    parser.add_argument("--verify-against", type=Path,
                        help="Optional validated NT 3.51 binary for byte comparison")
    args = parser.parse_args()

    if args.input.resolve() == args.output.resolve():
        parser.error("--input and --output must be different files")
    original = args.input.read_bytes()
    patched = patch(original)

    if args.verify_against:
        reference = args.verify_against.read_bytes()
        if patched != reference:
            raise ValueError("Patched output differs from the supplied reference binary")
        print("Byte comparison against reference: PASS")

    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_bytes(patched)
    print("Input SHA-256: ", sha256(original))
    print("Output SHA-256:", sha256(patched))
    print("Output:", args.output)
    print("Verification: PASS")


if __name__ == "__main__":
    try:
        main()
    except (OSError, ValueError, struct.error) as error:
        print("ERROR:", error, file=sys.stderr)
        sys.exit(1)
