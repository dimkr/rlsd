PACKAGE_VERSION="7.37.0"
PACKAGE_SOURCES="http://curl.haxx.se/download/curl-$PACKAGE_VERSION.tar.bz2 http://mxr.mozilla.org/mozilla/source/security/nss/COPYING?raw=1,COPYING.certdata"
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

	cd lib
	./mk-ca-bundle.pl ../cert.pem
}

curl_package() {
	cd ..
	$MAKE DESTDIR="$1" install
	install -D -m 644 cert.pem "$1/etc/ssl/cert.pem"
	install -D -m 644 README "$1/usr/share/doc/curl/README"
	install -m 644 RELEASE-NOTES "$1/usr/share/doc/curl/RELEASE-NOTES"
	install -m 644 CHANGES "$1/usr/share/doc/curl/CHANGES"
	install -m 644 COPYING "$1/usr/share/doc/curl/COPYING"
	install -m 644 ../COPYING.certdata "$1/usr/share/doc/curl/COPYING.certdata"
}

