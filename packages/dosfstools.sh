PACKAGE_VERSION="3.0.26"
PACKAGE_SOURCES="http://daniel-baumann.ch/files/software/dosfstools/dosfstools-$PACKAGE_VERSION.tar.xz"
PACKAGE_DESC="Tools for creation and checking of FAT file systems"

dosfstools_build() {
	[ -d dosfstools-$PACKAGE_VERSION ] && rm -rf dosfstools-$PACKAGE_VERSION
	tar -xJvf dosfstools-$PACKAGE_VERSION.tar.xz
	cd dosfstools-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/dosfstools-man.patch"
	patch -p 1 < "$BASE_DIR/patches/dosfstools-build.patch"

	$MAKE
}

dosfstools_package() {
	$MAKE PREFIX="/usr" SBINDIR="/bin" DESTDIR="$1" install
}
