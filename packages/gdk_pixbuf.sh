PACKAGE_VERSION="0.22.0"
PACKAGE_SOURCES="http://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/0.22/gdk-pixbuf-$PACKAGE_VERSION.tar.bz2 https://projects.archlinux.org/svntogit/community.git/plain/trunk/gdk-pixbuf-0.22.0.patch?h=packages/gdk-pixbuf,gdk-pixbuf-loaders.patch https://projects.archlinux.org/svntogit/community.git/plain/trunk/libpng15.patch?h=packages/gdk-pixbuf,gdk-pixbuf-libpng.patch"

gdk_pixbuf_build() {
	[ -d gdk-pixbuf-$PACKAGE_VERSION ] && rm -rf gdk-pixbuf-$PACKAGE_VERSION
	tar -xjvf gdk-pixbuf-$PACKAGE_VERSION.tar.bz2
	cd gdk-pixbuf-$PACKAGE_VERSION

	patch -p 1 < ../gdk-pixbuf-libpng.patch
	patch -p 0 < ../gdk-pixbuf-loaders.patch
	patch -p 1 < "$BASE_DIR/patches/gdk-pixbuf-static.patch"
	sed s~'SUBDIRS = gdk-pixbuf demo doc'~'SUBDIRS = gdk-pixbuf doc'~ \
	    -i Makefile.in
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
