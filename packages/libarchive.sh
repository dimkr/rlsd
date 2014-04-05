PACKAGE_VERSION="3.1.2"
PACKAGE_SOURCES="http://www.libarchive.org/downloads/libarchive-$PACKAGE_VERSION.tar.gz"

libarchive_build() {
	[ -d libarchive-$PACKAGE_VERSION ] && rm -rf libarchive-$PACKAGE_VERSION
	tar -xzvf libarchive-$PACKAGE_VERSION.tar.gz
	cd libarchive-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --includedir=/usr/include \
	            $CONFIGURE_LIBRARY_FLAGS
	$MAKE
}

libarchive_package() {
	$MAKE DESTDIR="$1" install
	ln -s bsdtar "$1/bin/tar"
	ln -s bsdcpio "$1/bin/cpio"
	install -D -m 644 README "$1/usr/share/doc/libarchive/README"
	install -m 644 NEWS "$1/usr/share/doc/libarchive/NEWS"
	install -m 644 COPYING "$1/usr/share/doc/libarchive/COPYING"
}
