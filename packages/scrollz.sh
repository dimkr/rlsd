PACKAGE_VERSION="2.2.3"
PACKAGE_SOURCES="http://www.scrollz.info/download/ScrollZ-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="An IRC client"

build() {
	[ -d ScrollZ-$PACKAGE_VERSION ] && rm -rf ScrollZ-$PACKAGE_VERSION
	tar -xzvf ScrollZ-$PACKAGE_VERSION.tar.gz
	cd ScrollZ-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/scrollz-binary.patch"

	./configure --host=$HOST \
	            --prefix=/usr \
	            --bindir=/bin \
	            --libexecdir=/lib/ScrollZ \
	            --datadir=/usr/share \
	            --mandir=/usr/share/man \
	            --enable-ipv6 \
	            --with-openssl
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/scrollz/README"
	install -m 644 README.ircII "$1/usr/share/doc/scrollz/README.ircII"
	install -m 644 NEWS "$1/usr/share/doc/scrollz/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/scrollz/ChangeLog"
	install -m 644 ChangeLog.ircii "$1/usr/share/doc/scrollz/ChangeLog.ircii"
	install -m 644 COPYRIGHT "$1/usr/share/doc/scrollz/COPYRIGHT"
}
