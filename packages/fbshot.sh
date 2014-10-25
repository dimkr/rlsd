PACKAGE_VERSION="0.3"
PACKAGE_SOURCES="http://www.sfires.net/stuff/fbshot/fbshot-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A screenshot taking tool"

build() {
	[ -d fbshot-$PACKAGE_VERSION ] && rm -rf fbshot-$PACKAGE_VERSION
	tar -xzvf fbshot-$PACKAGE_VERSION.tar.gz
	cd fbshot-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/fbshot-zlib.patch"

	$CC -o fbshot fbshot.c $CFLAGS $LDFLAGS $(pkg-config --cflags --libs libpng)
}

package() {
	install -D -m 755 fbshot "$1/bin/fbshot"
	install -D -m 644 fbshot.1.man "$1/usr/share/man/man1/fbshot.1"
	install -D -m 644 README "$1/usr/share/doc/fbshot/README"
	install -m 644 ChangeLog "$1/usr/share/doc/fbshot/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/fbshot/AUTHORS"
	install -m 644 CREDITS "$1/usr/share/doc/fbshot/CREDITS"
	install -m 644 COPYING "$1/usr/share/doc/fbshot/COPYING"
}
