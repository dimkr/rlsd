PACKAGE_VERSION="2.4.4"
PACKAGE_SOURCES="http://ftp.daper.net/pub/soft/moc/stable/moc-$PACKAGE_VERSION.tar.bz2"

moc_build() {
	[ -d moc-$PACKAGE_VERSION ] && rm -rf moc-$PACKAGE_VERSION
	tar -xjvf moc-$PACKAGE_VERSION.tar.bz2
	cd moc-$PACKAGE_VERSION
	# define _POSIX_SOURCE to allow building against musl and _GNU_SOURCE for
	# musl's SUN_LEN
	CFLAGS="$CFLAGS -D_POSIX_SOURCE -D_GNU_SOURCE" \
	./configure --host=$HOST --prefix= --datarootdir=/usr/share
	make
}

moc_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/moc/README"
	install -D -m 644 ChangeLog "$1/usr/share/doc/moc/ChangeLog"
	install -D -m 644 AUTHORS "$1/usr/share/doc/moc/AUTHORS"
	install -D -m 644 THANKS "$1/usr/share/doc/moc/THANKS"
	install -D -m 644 COPYING "$1/usr/share/doc/moc/COPYING"
}
