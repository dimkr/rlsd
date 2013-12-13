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
	$MAKE
}

libxml2_package() {
	$MAKE DESTDIR="$1" install
	mv "$1/usr/share/doc/libxml2-$PACKAGE_VERSION" "$1/usr/share/doc/libxml2"
	install -D -m 644 README "$1/usr/share/doc/libxml2/README"
	install -m 644 ChangeLog "$1/usr/share/doc/libxml2/ChangeLog"
	install -m 644 NEWS "$1/usr/share/doc/libxml2/NEWS"
	install -m 644 AUTHORS "$1/usr/share/doc/libxml2/AUTHORS"
	install -m 644 Copyright "$1/usr/share/doc/libxml2/Copyright"
	install -m 644 COPYING "$1/usr/share/doc/libxml2/COPYING"
}
