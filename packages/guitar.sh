PACKAGE_VERSION="0.1.4"
PACKAGE_SOURCES="http://ibiblio.org/pub/linux/utils/compress/guiTAR-$PACKAGE_VERSION.tar.gz"

guitar_build() {
	[ -d guiTAR-$PACKAGE_VERSION ] && rm -rf guiTAR-$PACKAGE_VERSION
	tar -xzvf guiTAR-$PACKAGE_VERSION.tar.gz
	cd guiTAR-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix=/usr \
	            --bindir=/bin \
	            --mandir=/usr/share/man \
	            --disable-myfilesel
	$MAKE
}

guitar_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/guitar/README"
	install -m 644 ChangeLog "$1/usr/share/doc/guitar/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/guitar/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/guitar/COPYING"
}