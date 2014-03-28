#!/bin/sh

. ./config

INITRAMFS_PROGRAMS="init
                    loksh
                    syslogd
                    logd
                    mkdir
                    mount
                    umount
                    luufs
                    sleep
                    klogecho
                    clear
                    cat"
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
chown -R 0:0 .
find . | cpio -o -H newc | xz -9 -e --check=none > "$iso_root/initrd.xz"
rm -rf "$initramfs_root"

# add the skeleton to the root file system
root_fs="$(mktemp -d -u)"
cp -ar "$SYSROOT" "$root_fs"
cp -ar "$BASE_DIR/skeleton"/* "$root_fs"

# create a 4 MB, FAT12 UEFI boot image, for UEFI boot
dd if=/dev/zero of="$iso_root/efiboot.img" bs=1024K count=4
mkfs.vfat -F 12 -n "LAZYUX" "$iso_root/efiboot.img"
mount_point="$(mktemp -d)"
mount -o loop -t vfat "$iso_root/efiboot.img" "$mount_point"
mkdir -p "$mount_point/EFI/BOOT"
mv "$root_fs/boot/elilo.efi" "$mount_point/EFI/BOOT/BOOTX64.EFI"
mv "$root_fs/boot/elilo.conf" "$mount_point/EFI/BOOT/"
cp "$root_fs/boot/bzImage" "$mount_point/EFI/BOOT/"
cp "$iso_root/initrd.xz" "$mount_point/EFI/BOOT/"
umount "$mount_point"
rmdir "$mount_point"

# put the kernel, the boot loader and its configuration file in the image root,
# for BIOS boot
mv "$root_fs/boot/bzImage" "$iso_root/"
mv "$root_fs/boot/isolinux.bin" "$iso_root/"
mv "$root_fs/boot/isohdpfx.bin" "$iso_root/"
mv "$root_fs/boot/isolinux.cfg" "$iso_root/"

# generate font cache files
for i in "$root_fs/usr/share/fonts"/*
do
	cd "$i"
	mkfontscale
	mkfontdir
done

# list all files under the root file system, to register it as a package
find "$root_fs" -name .gitignore -delete
mkdir "$root_fs/var/pkg/system"
find "$root_fs" | sed s~"$root_fs"~~g > "$root_fs/var/pkg/system/contents"
chmod 400 "$root_fs/var/pkg/system/contents"

# generate the root file system image
chown -R 0:0 "$root_fs"
mksquashfs "$root_fs" \
           "$iso_root/rootfs.sfs" \
           -comp xz \
           -Xbcj x86 \
           -b 512K \
           -no-exports
rm -rf "$root_fs"

# generate an ISO image
xorriso -as mkisofs \
        -iso-level 3 \
        -full-iso9660-filenames \
        -volid "LAZYUX_$VERSION" \
        -appid "Lazyux $VERSION" \
        -eltorito-boot isolinux.bin \
        -eltorito-catalog boot.cat \
        -no-emul-boot -boot-load-size 4 -boot-info-table \
        -isohybrid-mbr "$iso_root/isohdpfx.bin" \
        -eltorito-alt-boot \
        -e efiboot.img \
        -no-emul-boot \
        -isohybrid-gpt-basdat \
        -output "$BASE_DIR/$ISO_NAME" \
        "$iso_root"

# clean up
rm -rf "$iso_root"
