PACKAGE_VERSION="3.6.1"
PACKAGE_SOURCES="http://fossies.org/linux/misc/siag-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A spreadsheet"

siag_build() {
	[ -d siag-$PACKAGE_VERSION ] && rm -rf siag-$PACKAGE_VERSION
	tar -xzvf siag-$PACKAGE_VERSION.tar.gz
	cd siag-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datadir=/usr/share \
	            --mandir=/usr/share/man \
	            --disable-kdeinst \
	            --with-xawm=Xaw \
	            --with-docdir=/usr/share/doc/siag
	$MAKE
}

siag_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/siag/README"
	install -m 644 ChangeLog "$1/usr/share/doc/siag/ChangeLog"
	install -m 644 NEWS "$1/usr/share/doc/siag/NEWS"
	install -m 644 AUTHORS "$1/usr/share/doc/siag/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/siag/COPYING"
}
