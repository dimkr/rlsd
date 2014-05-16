PACKAGE_VERSION="1.9.0"
PACKAGE_SOURCES="http://sourceforge.net/projects/conky/files/conky/$PACKAGE_VERSION/conky-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A system monitor"

conky_build() {
	[ -d conky-$PACKAGE_VERSION ] && rm -rf conky-$PACKAGE_VERSION
	tar -xjvf conky-$PACKAGE_VERSION.tar.bz2
	cd conky-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/conky-bool.patch"
	patch -p 1 < "$BASE_DIR/patches/conky-config.patch"
	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-ncurses \
	            --disable-lua \
	            --disable-portmon \
	            --disable-xdamage \
	            --disable-xft
	$MAKE
}

conky_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/conky/README"
	install -m 644 NEWS "$1/usr/share/doc/conky/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/conky/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/conky/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/conky/COPYING"
}
