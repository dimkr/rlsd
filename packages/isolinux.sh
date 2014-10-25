PACKAGE_VERSION="4.07"
PACKAGE_SOURCES="https://www.kernel.org/pub/linux/utils/boot/syslinux/syslinux-$PACKAGE_VERSION.tar.xz"
PACKAGE_DESC="A BIOS boot loader for ISO9660 file systems"

build() {
	[ -d syslinux-$PACKAGE_VERSION ] && rm -rf syslinux-$PACKAGE_VERSION
	tar -xJvf syslinux-$PACKAGE_VERSION.tar.xz
	cd syslinux-$PACKAGE_VERSION
}

package() {
	install -D -m 644 core/isolinux.bin "$1/boot/isolinux.bin"
	install -m 644 mbr/isohdpfx.bin "$1/boot/isohdpfx.bin"
	install -D -m 644 README "$1/usr/share/doc/isolinux/README"
	install -m 644 NEWS "$1/usr/share/doc/isolinux/NEWS"
	install -m 644 COPYING "$1/usr/share/doc/isolinux/COPYING"
}
