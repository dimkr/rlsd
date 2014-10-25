PACKAGE_VERSION="3.0w"
PACKAGE_SOURCES="http://downloads.sourceforge.net/project/gnu-efi/gnu-efi_$PACKAGE_VERSION.orig.tar.gz"
PACKAGE_DESC="A common functions library for UEFI applications"

build() {
	[ -d gnu-efi-3.0 ] && rm -rf gnu-efi-3.0
	tar -xzvf gnu-efi_$PACKAGE_VERSION.orig.tar.gz
	cd gnu-efi-3.0

	patch -p 1 < "$BASE_DIR/patches/gnu-efi-build.patch"

	CFLAGS="" LDFLAGS="" $MAKE
}

package() {
	$MAKE INSTALLROOT="$1" PREFIX=/usr LIBDIR=/lib install
	install -D -m 644 README.gnuefi "$1/usr/share/doc/gnu-efi/README.gnuefi"
	install -m 644 README.efilib "$1/usr/share/doc/gnu-efi/README.efilib"
	install -m 644 ChangeLog "$1/usr/share/doc/gnu-efi/ChangeLog"
}
