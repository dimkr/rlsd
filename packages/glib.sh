PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/glib/archive/master.zip,glib-$PACKAGE_VERSION.zip"
PACKAGE_DESC="Common C functions"

glib_build() {
	[ -d glib-master ] && rm -rf glib-master
	unzip glib-$PACKAGE_VERSION.zip
	cd glib-master

	autoreconf --force --install
	CFLAGS="$CFLAGS -D_LARGEFILE64_SOURCE" \
	./configure --host=$HOST \
	            --target=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --enable-debug=no
	$MAKE
}

glib_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/glib/README"
	install -m 644 NEWS "$1/usr/share/doc/glib/NEWS"
	install -m 644 AUTHORS "$1/usr/share/doc/glib/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/glib/COPYING"
}
