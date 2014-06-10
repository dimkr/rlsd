PACKAGE_VERSION="1.0.3"
PACKAGE_SOURCES="http://xorg.freedesktop.org/archive/individual/font/font-adobe-75dpi-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="Adobe 75 DPI fonts"

font_adobe_75dpi_build() {
	[ -d font-adobe-75dpi-$PACKAGE_VERSION ] && rm -rf font-adobe-75dpi-$PACKAGE_VERSION
	tar -xjvf font-adobe-75dpi-$PACKAGE_VERSION.tar.bz2
	cd font-adobe-75dpi-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --with-fontdir=/usr/share/fonts/75dpi \
	            --with-compression=no
	$MAKE
}

font_adobe_75dpi_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/font-adobe-75dpi/README"
	install -m 644 ChangeLog "$1/usr/share/doc/font-adobe-75dpi/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/font-adobe-75dpi/COPYING"
}
