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

# create a 20 MB, FAT12 UEFI boot image, for UEFI boot
dd if=/dev/zero of="$iso_root/efiboot.img" bs=1024K count=20
mkfs.vfat -F 12 -n "Lazyux" "$iso_root/efiboot.img"
mount_point="$(mktemp -d)"
mount -o loop -t vfat "$iso_root/efiboot.img" "$mount_point"
mkdir -p "$mount_point/EFI/BOOT"
cp "$SYSROOT/boot/elilo.efi" "$mount_point/EFI/BOOT/BOOTX64.EFI"
cp "$SYSROOT/boot/elilo.conf" "$mount_point/EFI/BOOT/"
cp "$SYSROOT/boot/bzImage" "$mount_point/EFI/BOOT/"
cp "$iso_root/initrd.xz" "$mount_point/EFI/BOOT/"
umount "$mount_point"
rmdir "$mount_point"

# copy the kernel, the boot loader and its configuration file, for BIOS boot
cp "$SYSROOT/boot/bzImage" "$iso_root/"
cp "$SYSROOT/boot/isolinux.bin" "$iso_root/"
cp "$SYSROOT/boot/isolinux.cfg" "$iso_root/"

# generate an ISO image
xorriso -dev "$BASE_DIR/$ISO_NAME" \
        -volid "Lazyux $VERSION" \
        -joliet on \
        -compliance iso_9660_level=3 \
        -map "$iso_root" / \
        -boot_image isolinux dir=/ \
        -boot_image isolinux next \
        -boot_image any efi_path=efiboot.img

# clean up
rm -rf "$iso_root"