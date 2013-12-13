PACKAGE_VERSION="1.6"
PACKAGE_SOURCES="http://ftp.gnu.org/gnu/gzip/gzip-$PACKAGE_VERSION.tar.xz"

gzip_build() {
	[ -d gzip-$PACKAGE_VERSION ] && rm -rf gzip-$PACKAGE_VERSION
	tar -xJvf gzip-$PACKAGE_VERSION.tar.xz
	cd gzip-$PACKAGE_VERSION

	./configure --host=$HOST --prefix=/ --datarootdir=/usr/share
	$MAKE
}

gzip_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/gzip/README"
	install -m 644 ChangeLog "$1/usr/share/doc/gzip/ChangeLog"
	install -m 644 NEWS "$1/usr/share/doc/gzip/NEWS"
	install -m 644 AUTHORS "$1/usr/share/doc/gzip/AUTHORS"
	install -m 644 THANKS "$1/usr/share/doc/gzip/THANKS"
	install -m 644 COPYING "$1/usr/share/doc/gzip/COPYING"
}
