PACKAGE_VERSION="1.06"
PACKAGE_SOURCES="http://ftp.gnu.org/pub/gnu/bc/bc-$PACKAGE_VERSION.tar.gz"

bc_build() {
	[ -d bc-$PACKAGE_VERSION ] && rm -rf bc-$PACKAGE_VERSION
	tar -xzvf bc-$PACKAGE_VERSION.tar.gz
	cd bc-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --mandir=/usr/share/man \
	            --infodir=/usr/share/info
	$MAKE
}

bc_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/bc/README"
	install -m 644 ChangeLog "$1/usr/share/doc/bc/ChangeLog"
	install -m 644 NEWS "$1/usr/share/doc/bc/NEWS"
	install -m 644 AUTHORS "$1/usr/share/doc/bc/AUTHORS"
	install -m 644 COPYING.LIB "$1/usr/share/doc/bc/COPYING.LIB"
	install -m 644 COPYING "$1/usr/share/doc/bc/COPYING"
}
