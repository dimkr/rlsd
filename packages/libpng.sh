PACKAGE_VERSION="1.6.16"
PACKAGE_SOURCES="ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng16/libpng-$PACKAGE_VERSION.tar.xz"
PACKAGE_DESC="A library for handling PNG images"

build() {
	[ -d libpng-$PACKAGE_VERSION ] && rm -rf libpng-$PACKAGE_VERSION
	tar -xJvf libpng-$PACKAGE_VERSION.tar.xz
	cd libpng-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --without-binconfigs
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/libpng/README"
	install -m 644 CHANGES "$1/usr/share/doc/libpng/CHANGES"
	install -m 644 LICENSE "$1/usr/share/doc/libpng/LICENSE"
}
