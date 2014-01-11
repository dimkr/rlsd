PACKAGE_VERSION="0.8.6"
PACKAGE_SOURCES="http://www.dillo.org/download/dillo-$PACKAGE_VERSION.tar.bz2"

dillo_build() {
	[ -d dillo-$PACKAGE_VERSION ] && rm -rf dillo-$PACKAGE_VERSION
	tar -xjvf dillo-$PACKAGE_VERSION.tar.bz2
	cd dillo-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/dillo-musl.patch"
	patch -p 1 < "$BASE_DIR/patches/dillo-linker.patch"

	./configure --host=$HOST \
	            --prefix= \
	            --datadir=/usr/share \
	            --enable-ipv6 \
	            --disable-dlgui
	$MAKE
}

dillo_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/dillo/README"
	install -m 644 NEWS "$1/usr/share/doc/dillo/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/dillo/ChangeLog"
	install -m 644 ChangeLog.old "$1/usr/share/doc/dillo/ChangeLog.old"
	install -m 644 AUTHORS "$1/usr/share/doc/dillo/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/dillo/COPYING"
}
