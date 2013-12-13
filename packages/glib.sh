PACKAGE_VERSION="1.2.10"
PACKAGE_SOURCES="http://ftp.gnome.org/pub/gnome/sources/glib/1.2/glib-$PACKAGE_VERSION.tar.gz https://projects.archlinux.org/svntogit/packages.git/plain/trunk/glib1-autotools.patch?h=packages/glib,glib-autotools.patch https://projects.archlinux.org/svntogit/packages.git/plain/trunk/gcc340.patch?h=packages/glib,glib-gcc340.patch https://projects.archlinux.org/svntogit/packages.git/plain/trunk/aclocal-fixes.patch?h=packages/glib,glib-aclocal-fixes.patch"

glib_build() {
	[ -d glib-$PACKAGE_VERSION ] && rm -rf glib-$PACKAGE_VERSION
	tar -xzvf glib-$PACKAGE_VERSION.tar.gz
	cd glib-$PACKAGE_VERSION

	patch -p0 < ../glib-aclocal-fixes.patch
	patch -p1 < ../glib-autotools.patch
	patch -p1 < ../glib-gcc340.patch
	patch -p0 < "$BASE_DIR/patches/glib-1.2.10-gstrfuncs.diff"
	patch -p1 < "$BASE_DIR/patches/glib-1.2.10-musl.patch"

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
