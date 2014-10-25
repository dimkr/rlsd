PACKAGE_VERSION="3.17"
PACKAGE_SOURCES="https://www.kernel.org/pub/software/network/iw/iw-$PACKAGE_VERSION.tar.xz"
PACKAGE_DESC="A wireless network interface configuration tool"

build() {
	[ -d iw-$PACKAGE_VERSION ] && rm -rf iw-$PACKAGE_VERSION
	tar -xJvf iw-$PACKAGE_VERSION.tar.xz
	cd iw-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/iw-libnl-tiny.patch"
	CFLAGS="-D_GNU_SOURCE $CFLAGS" \
	LDFLAGS="$(echo $LDFLAGS | sed s~'-Wl,-gc-sections'~~)" \
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" SBINDIR="/bin" install
	install -D -m 644 README "$1/usr/share/doc/iw/README"
	install -m 644 COPYING "$1/usr/share/doc/iw/COPYING"
}
