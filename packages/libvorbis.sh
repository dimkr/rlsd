PACKAGE_VERSION="1.3.3"
PACKAGE_SOURCES="http://downloads.xiph.org/releases/vorbis/libvorbis-$PACKAGE_VERSION.tar.xz"

libvorbis_build() {
	[ -d libvorbis-$PACKAGE_VERSION ] && rm -rf libvorbis-$PACKAGE_VERSION
	tar -xJvf libvorbis-$PACKAGE_VERSION.tar.xz
	cd libvorbis-$PACKAGE_VERSION

	sed s~'-O20'~''~g -i configure
	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS
	make
}

libvorbis_package() {
	make DESTDIR="$1" install
	mv "$1/usr/share/doc/libvorbis-$PACKAGE_VERSION" \
	   "$1/usr/share/doc/libvorbis"
	install -D -m 644 README "$1/usr/share/doc/libvorbis/README"
	install -D -m 644 CHANGES "$1/usr/share/doc/libvorbis/CHANGES"
	install -D -m 644 AUTHORS "$1/usr/share/doc/libvorbis/AUTHORS"
	install -D -m 644 COPYING "$1/usr/share/doc/libvorbis/COPYING"
}
