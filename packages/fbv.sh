PACKAGE_VERSION="1.0b"
PACKAGE_SOURCES="http://s-tech.elsat.net.pl/fbv/fbv-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="An image viewer"

build() {
	[ -d fbv-$PACKAGE_VERSION ] && rm -rf fbv-$PACKAGE_VERSION
	tar -xzvf fbv-$PACKAGE_VERSION.tar.gz
	cd fbv-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/fbv-giflib.patch"
	patch -p 1 < "$BASE_DIR/patches/fbv-libpng.patch"
	patch -p 1 < "$BASE_DIR/patches/fbv-build.patch"

	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/fbv/README"
	install -m 644 ChangeLog "$1/usr/share/doc/fbv/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/fbv/COPYING"
}
