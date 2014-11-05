PACKAGE_VERSION="1.2"
PACKAGE_SOURCES="http://fbgrab.monells.se/fbgrab-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A screenshot taking tool"

build() {
	[ -d fbgrab ] && rm -rf fbgrab
	tar -xzvf fbgrab-$PACKAGE_VERSION.tar.gz
	cd fbgrab

	patch -p 1 < "$BASE_DIR/patches/fbgrab-build.patch"

	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 COPYING "$1/usr/share/doc/fbgrab/COPYING"
}
