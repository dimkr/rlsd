PACKAGE_VERSION="0.9.1"
PACKAGE_SOURCES="http://sourceforge.net/projects/xzgv/files/xzgv/$PACKAGE_VERSION/xzgv-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="An image viewer"

build() {
	[ -d xzgv-$PACKAGE_VERSION ] && rm -rf xzgv-$PACKAGE_VERSION
	tar -xzvf xzgv-$PACKAGE_VERSION.tar.gz
	cd xzgv-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/xzgv-gtk.patch"
	patch -p 1 < "$BASE_DIR/patches/xzgv-build.patch"

	$MAKE
}

package() {
	$MAKE PREFIX="$1/usr" BINDIR="$1/bin" install
	install -D -m 644 README "$1/usr/share/doc/xzgv/README"
	install -m 644 NEWS "$1/usr/share/doc/xzgv/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/xzgv/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/xzgv/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/xzgv/COPYING"
}
