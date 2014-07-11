PACKAGE_VERSION="2.0.0"
PACKAGE_SOURCES="http://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="An encryption and privacy library"

libressl_build() {
	[ -d libressl-$PACKAGE_VERSION ] && rm -rf libressl-$PACKAGE_VERSION
	tar -xzvf libressl-$PACKAGE_VERSION.tar.gz
	cd libressl-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/libressl-build.patch"
	patch -p 1 < "$BASE_DIR/patches/libressl-musl.patch"
	patch -p 1 < "$BASE_DIR/patches/libressl-static.patch"
	autoconf

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS
	$MAKE
}

libressl_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/libressl/README"
	install -m 644 NEWS "$1/usr/share/doc/libressl/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/libressl/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/libressl/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/libressl/COPYING"
}
