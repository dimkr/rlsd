PACKAGE_VERSION="1.0.6"
PACKAGE_SOURCES="http://sylpheed.sraoss.jp/sylpheed/v1.0/sylpheed-$PACKAGE_VERSION.tar.bz2"

sylpheed_build() {
	[ -d sylpheed-$PACKAGE_VERSION ] && rm -rf sylpheed-$PACKAGE_VERSION
	tar -xjvf sylpheed-$PACKAGE_VERSION.tar.bz2
	cd sylpheed-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/sylpheed-build.patch"
	./configure --host=$HOST --prefix=/ --datadir=/usr/share --disable-nls
	$MAKE
}

sylpheed_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/sylpheed/README"
	install -m 644 NEWS "$1/usr/share/doc/sylpheed/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/sylpheed/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/sylpheed/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/sylpheed/COPYING"
}
