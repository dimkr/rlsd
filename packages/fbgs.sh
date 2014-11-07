PACKAGE_VERSION="2.09"
PACKAGE_SOURCES="https://www.kraxel.org/releases/fbida/fbida-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A PDF viewer"

build() {
	[ -d fbida-$PACKAGE_VERSION ] && rm -rf fbida-$PACKAGE_VERSION
	tar -xzvf fbida-$PACKAGE_VERSION.tar.gz
	cd fbida-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/fbgs-rlsd.patch"
}

package() {
	install -D -m 755 fbgs "$1/bin/fbgs"
	install -D -m 644 fbgs.man "$1/usr/share/man/man1/fbgs.1"
	install -D -m 644 COPYING "$1/usr/share/doc/fbida/COPYING"
}
