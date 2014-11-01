PACKAGE_VERSION="4.39"
PACKAGE_SOURCES="http://sourceforge.net/projects/terminus-font/files/terminus-font-$PACKAGE_VERSION/terminus-font-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A monospace font"
PACKAGE_ARCH="all"

build() {
	[ -d terminus-font-$PACKAGE_VERSION ] && rm -rf terminus-font-$PACKAGE_VERSION
	tar -xzvf terminus-font-$PACKAGE_VERSION.tar.gz
	cd terminus-font-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/terminus-font-build.patch"

	./configure
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" prefix="/usr" install
	install -D -m 644 README "$1/usr/share/doc/terminus-font/README"
	install -m 644 CHANGES "$1/usr/share/doc/terminus-font/CHANGES"
	install -m 644 NEWS "$1/usr/share/doc/terminus-font/NEWS"
	install -m 644 AUTHORS "$1/usr/share/doc/terminus-font/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/terminus-font/COPYING"
	install -m 644 OFL.TXT "$1/usr/share/doc/terminus-font/OFL.TXT"
}
