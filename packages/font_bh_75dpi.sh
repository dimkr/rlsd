PACKAGE_VERSION="1.0.3"
PACKAGE_SOURCES="http://xorg.freedesktop.org/archive/individual/font/font-bh-75dpi-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="Extra 75 DPI fonts"

font_bh_75dpi_build() {
	[ -d font-bh-75dpi-$PACKAGE_VERSION ] && rm -rf font-bh-75dpi-$PACKAGE_VERSION
	tar -xjvf font-bh-75dpi-$PACKAGE_VERSION.tar.bz2
	cd font-bh-75dpi-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --with-fontdir=/usr/share/fonts/75dpi \
	            --with-compression=no
	$MAKE
}

font_bh_75dpi_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/font-bh-75dpi/README"
	install -m 644 ChangeLog "$1/usr/share/doc/font-bh-75dpi/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/font-bh-75dpi/COPYING"
	install -m 644 LU_LEGALNOTICE "$1/usr/share/doc/font-bh-75dpi/LU_LEGALNOTICE"
}
