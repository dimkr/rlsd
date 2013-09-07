PACKAGE_VERSION="1.6g"
PACKAGE_SOURCES="http://primates.ximian.com/~flucifredi/man/man-$PACKAGE_VERSION.tar.gz"

man_build() {
	[ -d man-$PACKAGE_VERSION ] && rm -rf man-$PACKAGE_VERSION
	tar -xzvf man-$PACKAGE_VERSION.tar.gz
	cd man-$PACKAGE_VERSION

	sed s~'usr/bin'~'bin'~ -i man2html/Makefile.in
	./configure -d -bindir=/bin -sbindir=/bin -confdir=/etc
	make
}

man_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/man/README"
	install -m 644 HISTORY "$1/usr/share/doc/man/HISTORY"
	install -m 644 COPYING "$1/usr/share/doc/man/COPYING"
}
