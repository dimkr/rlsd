PACKAGE_VERSION="3.5"
PACKAGE_SOURCES="ftp://ftp.gnu.org/gnu/xhippo/xhippo-$PACKAGE_VERSION.tar.gz"

xhippo_build() {
	[ -d xhippo-$PACKAGE_VERSION ] && rm -rf xhippo-$PACKAGE_VERSION
	tar -xzvf xhippo-$PACKAGE_VERSION.tar.gz
	cd xhippo-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --infodir=/usr/share/info \
	            --mandir=/usr/share/man
	$MAKE
}

xhippo_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/xhippo/README"
	install -m 644 NEWS "$1/usr/share/doc/xhippo/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/xhippo/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/xhippo/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/xhippo/COPYING"
}