PACKAGE_VERSION="1.1.2"
PACKAGE_SOURCES="http://xorg.freedesktop.org/releases/individual/font/font-misc-misc-$PACKAGE_VERSION.tar.bz2"

font_misc_misc_build() {
	[ -d font-misc-misc-$PACKAGE_VERSION ] && rm -rf font-misc-misc-$PACKAGE_VERSION
	tar -xjvf font-misc-misc-$PACKAGE_VERSION.tar.bz2
	cd font-misc-misc-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --with-fontdir=/usr/share/fonts/misc \
	            --without-compression
	make
}

font_misc_misc_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/font-misc-misc/README"
	install -m 644 ChangeLog "$1/usr/share/doc/font-misc-misc/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/font-misc-misc/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/font-misc-misc/COPYING"
}
