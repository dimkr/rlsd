PACKAGE_VERSION="0.1"
PACKAGE_SOURCES="http://ordiluc.net/guiftp/guiftp-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A FTP client"

build() {
	[ -d guiftp-$PACKAGE_VERSION ] && rm -rf guiftp-$PACKAGE_VERSION
	tar -xjvf guiftp-$PACKAGE_VERSION.tar.bz2
	cd guiftp-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/guiftp-getline.patch"
	./configure --host=$HOST --prefix= --mandir=/usr/share/man --disable-nls
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/guiftp/README"
	install -m 644 ChangeLog "$1/usr/share/doc/guiftp/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/guiftp/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/guiftp/COPYING"
}
