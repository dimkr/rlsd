PACKAGE_VERSION="4.07"
PACKAGE_SOURCES="https://www.kernel.org/pub/linux/utils/boot/syslinux/syslinux-$PACKAGE_VERSION.tar.xz"

isolinux_build() {
	[ -d syslinux-$PACKAGE_VERSION ] && rm -rf syslinux-$PACKAGE_VERSION
	tar -xJvf syslinux-$PACKAGE_VERSION.tar.xz
	cd syslinux-$PACKAGE_VERSION
}

isolinux_package() {
	install -D -m 644 core/isolinux.bin "$1/boot/isolinux.bin"
	install -D -m 644 README "$1/usr/share/doc/syslinux/README"
	install -m 644 NEWS "$1/usr/share/doc/syslinux/NEWS"
	install -m 644 COPYING "$1/usr/share/doc/syslinux/COPYING"
}
