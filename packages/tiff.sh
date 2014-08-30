PACKAGE_VERSION="4.0.3"
PACKAGE_SOURCES="ftp://ftp.remotesensing.org/pub/libtiff/tiff-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A library for handling TIFF images"

tiff_build() {
	[ -d tiff-$PACKAGE_VERSION ] && rm -rf tiff-$PACKAGE_VERSION
	tar -xzvf tiff-$PACKAGE_VERSION.tar.gz
	cd tiff-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/tiff-html.patch"

	./configure --host=$HOST \
	            --prefix=/usr \
	            --bindir=/bin \
	            --libdir=/lib \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --disable-lzma \
	            --disable-cxx \
	            --with-docdir="/usr/share/doc/tiff"
	$MAKE
}

tiff_package() {
	$MAKE DESTDIR="$1" install
}
