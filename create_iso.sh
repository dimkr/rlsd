#!/bin/sh

. ./config

BASE_DIR="$(pwd)"
VERSION="$(date +%d%m%Y)"
ISO_NAME="lazyux-$VERSION.iso"

# create a temporary directory
iso_root="$(mktemp -d)"

# add the skeleton and generate a compressed initramfs
cp -ar skeleton/* "$SYSROOT"
cd "$SYSROOT"
find . | cpio -o -H newc | xz -9 -e --check=none > "$iso_root/initrd.xz"

# copy the kernel, the boot loader and its configuration file
cp "$SYSROOT/boot/bzImage" "$iso_root/"
cp "$SYSROOT/boot/isolinux.bin" "$iso_root/"
cp "$SYSROOT/boot/isolinux.cfg" "$iso_root/"

# generate an ISO image
xorriso -as mkisofs \
        -U -A "Lazyux $VERSION" \
        -r -v -T \
        -o "$BASE_DIR/$ISO_NAME" \
        -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 \
        -boot-info-table -eltorito-alt-boot -no-emul-boot "$iso_root"

# clean up
rm -rf "$iso_root"