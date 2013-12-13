PACKAGE_VERSION="2.4"
PACKAGE_SOURCES="https://alioth.debian.org/frs/download.php/file/3016/axel-$PACKAGE_VERSION.tar.bz2"

axel_build() {
	[ -d axel-$PACKAGE_VERSION ] && rm -rf axel-$PACKAGE_VERSION
	tar -xjvf axel-$PACKAGE_VERSION.tar.bz2
	cd axel-$PACKAGE_VERSION

	./configure --prefix=/usr \
	            --bindir=/bin \
	            --i18n=0 \
	            --debug=0 \
	            --strip=0
	$MAKE
}

axel_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/axel/README"
	install -m 644 CHANGES "$1/usr/share/doc/axel/CHANGES"
	install -m 644 CREDITS "$1/usr/share/doc/axel/CREDITS"
	install -m 644 COPYING "$1/usr/share/doc/axel/COPYING"
}
