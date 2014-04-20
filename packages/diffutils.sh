PACKAGE_VERSION="3.3"
PACKAGE_SOURCES="http://ftp.gnu.org/gnu/diffutils/diffutils-$PACKAGE_VERSION.tar.xz"

diffutils_build() {
	[ -d diffutils-$PACKAGE_VERSION ] && rm -rf diffutils-$PACKAGE_VERSION
	tar -xJvf diffutils-$PACKAGE_VERSION.tar.xz
	cd diffutils-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-nls
	$MAKE
}

diffutils_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/diffutils/README"
	install -m 644 NEWS "$1/usr/share/doc/diffutils/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/diffutils/ChangeLog"
	install -m 644 ChangeLog-2008 "$1/usr/share/doc/diffutils/ChangeLog-2008"
	install -m 644 AUTHORS "$1/usr/share/doc/diffutils/AUTHORS"
	install -m 644 THANKS "$1/usr/share/doc/diffutils/THANKS"
	install -m 644 COPYING "$1/usr/share/doc/diffutils/COPYING"
}
