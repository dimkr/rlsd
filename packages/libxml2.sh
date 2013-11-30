PACKAGE_VERSION="2.9.1"
PACKAGE_SOURCES="ftp://ftp.xmlsoft.org/libxml2/libxml2-$PACKAGE_VERSION.tar.gz"

libxml2_build() {
	[ -d libxml2-$PACKAGE_VERSION ] && rm -rf libxml2-$PACKAGE_VERSION
	tar -xzvf libxml2-$PACKAGE_VERSION.tar.gz
	cd libxml2-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --without-debug \
	            --without-python \
	            --without-threads \
	            --without-modules
	make
}

libxml2_package() {
	make DESTDIR="$1" install
	mv "$1/usr/share/doc/libxml2-$PACKAGE_VERSION" "$1/usr/share/doc/libxml2"
	install -D -m 644 README "$1/usr/share/doc/libxml2/README"
	install -m 644 CHANGES "$1/usr/share/doc/libxml2/CHANGES"
	install -m 644 LICENSE "$1/usr/share/doc/libxml2/LICENSE"
}
