PACKAGE_VERSION="2.8"
PACKAGE_SOURCES="http://links.twibright.com/download/links-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A web browser"

build() {
	[ -d links-$PACKAGE_VERSION ] && rm -rf links-$PACKAGE_VERSION
	tar -xjvf links-$PACKAGE_VERSION.tar.bz2
	cd links-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/links-libressl.patch"

	LIBS="-lX11" \
	./configure --host=$HOST \
	            --prefix= \
	            --mandir=/usr/share/man \
	            --enable-graphics \
	            --with-x \
	            --without-libtiff
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/links/README"
	install -m 644 KEYS "$1/usr/share/doc/links/KEYS"
	install -m 644 ChangeLog "$1/usr/share/doc/links/ChangeLog"
	install -m 644 NEWS "$1/usr/share/doc/links/NEWS"
	install -m 644 AUTHORS "$1/usr/share/doc/links/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/links/COPYING"
}
