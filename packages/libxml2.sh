PACKAGE_VERSION="2.9.2"
PACKAGE_SOURCES="ftp://ftp.xmlsoft.org/libxml2/libxml2-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A XML parsing library"

build() {
	[ -d libxml2-$PACKAGE_VERSION ] && rm -rf libxml2-$PACKAGE_VERSION
	tar -xzvf libxml2-$PACKAGE_VERSION.tar.gz
	cd libxml2-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/libxml2-doc.patch"
	patch -p 1 < "$BASE_DIR/patches/libxml2-examples.patch"
	patch -p 1 < "$BASE_DIR/patches/libxml2-cmake.patch"
	patch -p 1 < "$BASE_DIR/patches/libxml2-config.patch"

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --without-debug \
	            --without-html-dir \
	            --without-python \
	            --without-threads \
	            --without-modules \
	            --without-lzma
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -m 644 README "$1/usr/share/doc/libxml2/README"
	install -m 644 ChangeLog "$1/usr/share/doc/libxml2/ChangeLog"
	install -m 644 NEWS "$1/usr/share/doc/libxml2/NEWS"
	install -m 644 AUTHORS "$1/usr/share/doc/libxml2/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/libxml2/COPYING"
}
