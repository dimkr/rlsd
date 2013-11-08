PACKAGE_VERSION="1.0.3"
PACKAGE_SOURCES="http://xorg.freedesktop.org/releases/individual/font/font-cursor-misc-$PACKAGE_VERSION.tar.bz2"

font_cursor_misc_build() {
	[ -d font-cursor-misc-$PACKAGE_VERSION ] && rm -rf font-cursor-misc-$PACKAGE_VERSION
	tar -xjvf font-cursor-misc-$PACKAGE_VERSION.tar.bz2
	cd font-cursor-misc-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --with-fontdir=/usr/share/fonts/misc \
	            --without-compression
	make
}

font_cursor_misc_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/font-cursor-misc/README"
	install -m 644 ChangeLog "$1/usr/share/doc/font-cursor-misc/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/font-cursor-misc/COPYING"
}
