PACKAGE_VERSION="0.6.0b-1"
PACKAGE_SOURCES="http://sourceforge.net/projects/gtksee.berlios/files/gtksee-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="An image viewer"

build() {
	[ -d gtksee-$PACKAGE_VERSION ] && rm -rf gtksee-$PACKAGE_VERSION
	tar -xzvf gtksee-$PACKAGE_VERSION.tar.gz
	cd gtksee-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/gtksee-libpng.patch"
	./configure --host=$HOST \
	            --prefix= \
	            --datadir=/usr/share \
	            --disable-nls
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/gtksee/README"
	install -D -m 644 NEWS "$1/usr/share/doc/gtksee/NEWS"
	install -D -m 644 AUTHORS "$1/usr/share/doc/gtksee/AUTHORS"
	install -D -m 644 COPYING "$1/usr/share/doc/gtksee/COPYING"
}
