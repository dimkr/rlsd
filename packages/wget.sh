PACKAGE_VERSION="1.16.1"
PACKAGE_SOURCES="http://ftp.gnu.org/gnu/wget/wget-$PACKAGE_VERSION.tar.xz"
PACKAGE_DESC="A HTTP and FTP client"

build() {
	[ -d wget-$PACKAGE_VERSION ] && rm -rf wget-$PACKAGE_VERSION
	tar -xJvf wget-$PACKAGE_VERSION.tar.xz
	cd wget-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/wget-libressl.patch"
	autoreconf

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-debug \
	            --disable-nls \
	            --with-ssl=openssl
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/wget/README"
	install -m 644 NEWS "$1/usr/share/doc/wget/NEWS"
	install -m 644 AUTHORS "$1/usr/share/doc/wget/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/wget/COPYING"
}
