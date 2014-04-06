PACKAGE_VERSION="1.2.10"
PACKAGE_SOURCES="http://ftp.gnome.org/pub/gnome/sources/gtk+/1.2/gtk+-$PACKAGE_VERSION.tar.gz https://projects.archlinux.org/svntogit/packages.git/plain/trunk/aclocal-fixes.patch?h=packages/gtk,gtk-aclocal-fixes.patch"

gtk_build() {
	[ -d gtk+-$PACKAGE_VERSION ] && rm -rf gtk+-$PACKAGE_VERSION
	tar -xzvf gtk+-$PACKAGE_VERSION.tar.gz
	cd gtk+-$PACKAGE_VERSION

	patch -p 0 < ../gtk-aclocal-fixes.patch
	cp /usr/share/libtool/config/config.guess .
	cp /usr/share/libtool/config/config.sub .
	patch -p 0 < "$BASE_DIR/patches/gtk+-1.2.10.diff"
	patch -p 1 < "$BASE_DIR/patches/gtk-font.patch"

	./configure --host=$HOST \
	            --target=$HOST \
	            --prefix= \
	            --datadir=/usr/share \
	            --includedir=/usr/include \
	            --infodir=/usr/share/info \
	            --mandir=/usr/share/man \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --enable-debug=no \
	            --disable-nls \
	            --disable-glibtest
	$MAKE
}

gtk_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/gtk+/README"
	install -m 644 ChangeLog "$1/usr/share/doc/gtk+/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/gtk+/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/gtk+/COPYING"
}
