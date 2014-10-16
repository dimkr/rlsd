PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/dimkr/gdk-pixbuf/archive/master.zip,gdk-pixbuf-$PACKAGE_VERSION.zip"
PACKAGE_DESC="An image loading library"

gdk_pixbuf_build() {
	[ -d gdk-pixbuf-master ] && rm -rf gdk-pixbuf-master
	unzip gdk-pixbuf-$PACKAGE_VERSION.zip
	cd gdk-pixbuf-master

	patch -p 1 < "$BASE_DIR/patches/gdk_pixbuf-tiff.patch"
	patch -p 1 < "$BASE_DIR/patches/gdk_pixbuf-demo.patch"

	./configure --host=$HOST \
	            --prefix=/usr \
	            --bindir=/bin \
	            --libdir=/lib \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --disable-modules
	$MAKE
}

gdk_pixbuf_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/gdk-pixbuf/README"
	install -m 644 NEWS "$1/usr/share/doc/gdk-pixbuf/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/gdk-pixbuf/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/gdk-pixbuf/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/gdk-pixbuf/COPYING"
	install -m 644 COPYING.LIB "$1/usr/share/doc/gdk-pixbuf/COPYING.LIB"
}
