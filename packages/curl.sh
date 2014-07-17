PACKAGE_VERSION="7.37.1"
PACKAGE_SOURCES="http://curl.haxx.se/download/curl-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A file transfer library"

curl_build() {
	[ -d curl-$PACKAGE_VERSION ] && rm -rf curl-$PACKAGE_VERSION
	tar -xjvf curl-$PACKAGE_VERSION.tar.bz2
	cd curl-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --disable-debug \
	            --with-ca-bundle=/etc/ssl/cert.pem \
	            --disable-rtsp \
	            --enable-ipv6
	$MAKE
}

curl_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/curl/README"
	install -m 644 RELEASE-NOTES "$1/usr/share/doc/curl/RELEASE-NOTES"
	install -m 644 CHANGES "$1/usr/share/doc/curl/CHANGES"
	install -m 644 COPYING "$1/usr/share/doc/curl/COPYING"
}

