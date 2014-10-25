PACKAGE_VERSION="5.1.0"
PACKAGE_SOURCES="http://downloads.sourceforge.net/project/giflib/giflib-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A library for handling of GIF images"

build() {
	[ -d giflib-$PACKAGE_VERSION ] && rm -rf giflib-$PACKAGE_VERSION
	tar -xjvf giflib-$PACKAGE_VERSION.tar.bz2
	cd giflib-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/giflib/README"
	install -m 644 NEWS "$1/usr/share/doc/giflib/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/giflib/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/giflib/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/giflib/COPYING"
}
