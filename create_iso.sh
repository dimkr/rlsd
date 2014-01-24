#!/bin/sh

. ./config

INITRAMFS_PROGRAMS="init loksh syslogd logd mkdir mount umount luufs chroot"
BASE_DIR="$(pwd)"
VERSION="$(date +%d%m%Y)"
ISO_NAME="lazyux-$VERSION.iso"

# create a temporary directory for the initramfs contents
initramfs_root="$(mktemp -d -u)"

# copy the initramfs skeleton
cp -r initramfs-skeleton "$initramfs_root"

# add required programs to the initramfs
for i in $INITRAMFS_PROGRAMS
do
	cp "$SYSROOT/bin/$i" "$initramfs_root/bin"
done

# create a temporary directory for the extracted ISO image contents
iso_root="$(mktemp -d)"

# generate a compressed initramfs
cd "$initramfs_root"
find -name .gitignore -delete
find . | cpio -o -H newc | xz -9 -e --check=none > "$iso_root/initrd.xz"
rm -rf "$initramfs_root"

# create a 4 MB, FAT12 UEFI boot image, for UEFI boot
dd if=/dev/zero of="$iso_root/efiboot.img" bs=1024K count=4
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

# add the skeleton to the root file system
cd "$BASE_DIR"
cp -ar skeleton/* "$SYSROOT"

# generate the root file system image
find "$SYSROOT" -name .gitignore -delete
mksquashfs "$SYSROOT" \
           "$iso_root/rootfs.sfs" \
           -comp xz \
           -Xbcj x86 \
           -b 512K \
           -no-exports

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