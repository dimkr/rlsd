PACKAGE_VERSION="1.0.3"
PACKAGE_SOURCES="http://xorg.freedesktop.org/archive/individual/font/font-adobe-100dpi-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="Adobe 100 DPI fonts"
PACKAGE_ARCH="all"

font_adobe_100dpi_build() {
	[ -d font-adobe-100dpi-$PACKAGE_VERSION ] && rm -rf font-adobe-100dpi-$PACKAGE_VERSION
	tar -xjvf font-adobe-100dpi-$PACKAGE_VERSION.tar.bz2
	cd font-adobe-100dpi-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/font_adobe_100dpi-tiny.patch"
	patch -p 1 < "$BASE_DIR/patches/font_adobe_100dpi-cache.patch"

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --with-fontdir=/usr/share/fonts/100dpi \
	            --with-compression=no
	$MAKE
}

font_adobe_100dpi_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/font-adobe-100dpi/README"
	install -m 644 ChangeLog "$1/usr/share/doc/font-adobe-100dpi/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/font-adobe-100dpi/COPYING"
}
