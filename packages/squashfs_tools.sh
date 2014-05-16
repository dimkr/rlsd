PACKAGE_VERSION="4.3"
PACKAGE_SOURCES="http://sourceforge.net/projects/squashfs/files/squashfs/squashfs$PACKAGE_VERSION/squashfs$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="SquashFS file system manipulation tools"

squashfs_tools_build() {
	[ -d squashfs$PACKAGE_VERSION ] && rm -rf squashfs$PACKAGE_VERSION
	tar -xzvf squashfs$PACKAGE_VERSION.tar.gz
	cd squashfs$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/squashfs-tools-musl.patch"
	patch -p 1 < "$BASE_DIR/patches/squashfs-tools-build.patch"
	patch -p 1 < "$BASE_DIR/patches/squashfs-tools-compression.patch"

	cd squashfs-tools
	$MAKE
}

squashfs_tools_package() {
	install -D -m 755 mksquashfs "$1/bin/mksquashfs"
	install -m 755 unsquashfs "$1/bin/unsquashfs"
	install -D -m 644 ../README "$1/usr/share/doc/squashfs-tools/README"
	install -m 644 ../README-$PACKAGE_VERSION "$1/usr/share/doc/squashfs-tools/README-$PACKAGE_VERSION"
	install -m 644 ../PERFORMANCE.README "$1/usr/share/doc/squashfs-tools/PERFORMANCE.README"
	install -m 644 ../CHANGES "$1/usr/share/doc/squashfs-tools/CHANGES"
	install -m 644 ../ACKNOWLEDGEMENTS "$1/usr/share/doc/squashfs-tools/ACKNOWLEDGEMENTS"
	install -m 644 ../COPYING "$1/usr/share/doc/squashfs-tools/COPYING"
}
