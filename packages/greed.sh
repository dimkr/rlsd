PACKAGE_VERSION="3.10"
PACKAGE_SOURCES="http://www.catb.org/~esr/greed/greed-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A strategy game"

greed_build() {
	[ -d greed-$PACKAGE_VERSION ] && rm -rf greed-$PACKAGE_VERSION
	tar -xzvf greed-$PACKAGE_VERSION.tar.gz
	cd greed-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/greed-build.patch"

	$MAKE
}

greed_package() {
	install -D -m 755 greed "$1/bin/greed"
	install -D -m 644 greed.6 "$1/usr/share/man/man6/greed.6"
	install -d -D -m 755 "$1/var/games/greed"
	install -D -m 644 README "$1/usr/share/doc/greed/README"
	install -m 644 NEWS "$1/usr/share/doc/greed/NEWS"
	install -m 644 COPYING "$1/usr/share/doc/greed/COPYING"
}
