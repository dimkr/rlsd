PACKAGE_VERSION="3.2.24"
PACKAGE_SOURCES="http://www.carisma.slowglass.com/~tgr/libnl/files/libnl-$PACKAGE_VERSION.tar.gz"

libnl_build() {
	[ -d libnl-$PACKAGE_VERSION ] && rm -rf libnl-$PACKAGE_VERSION
	tar -xzvf libnl-$PACKAGE_VERSION.tar.gz
	cd libnl-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --includedir=/usr/include \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --disable-cli
	$MAKE
}

libnl_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 ChangeLog "$1/usr/share/doc/libnl/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/libnl/COPYING"
}
