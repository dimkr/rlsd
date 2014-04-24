PACKAGE_VERSION="4.0.3"
PACKAGE_SOURCES="ftp://ftp.remotesensing.org/pub/libtiff/tiff-$PACKAGE_VERSION.tar.gz"

tiff_build() {
	[ -d tiff-$PACKAGE_VERSION ] && rm -rf tiff-$PACKAGE_VERSION
	tar -xzvf tiff-$PACKAGE_VERSION.tar.gz
	cd tiff-$PACKAGE_VERSION

	sed s~'LIBTIFF_DOCDIR=\${prefix}/share/doc/${PACKAGE}-${LIBTIFF_VERSION}'~'LIBTIFF_DOCDIR=\${prefix}/share/doc/${PACKAGE}'~ -i configure
	./configure --host=$HOST \
	            --prefix=/usr \
	            --bindir=/bin \
	            --libdir=/lib \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --disable-lzma \
	            --disable-cxx
	$MAKE
}

tiff_package() {
	$MAKE DESTDIR="$1" install
}
