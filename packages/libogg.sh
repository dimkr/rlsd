PACKAGE_VERSION="1.3.1"
PACKAGE_SOURCES="http://downloads.xiph.org/releases/ogg/libogg-$PACKAGE_VERSION.tar.xz"

libogg_build() {
	[ -d libogg-$PACKAGE_VERSION ] && rm -rf libogg-$PACKAGE_VERSION
	tar -xJvf libogg-$PACKAGE_VERSION.tar.xz
	cd libogg-$PACKAGE_VERSION

	sed s~'-O20'~''~g -i configure
	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            --disable-shared \
	            --enable-static
	make
}

libogg_package() {
	make DESTDIR="$1" install
	install -D -m 644 ChangeLog "$1/usr/share/doc/libogg/ChangeLog"
	install -D -m 644 COPYING "$1/usr/share/doc/libogg/COPYING"
}
