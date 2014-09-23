PACKAGE_VERSION="2.9"
PACKAGE_SOURCES="http://www.catb.org/~esr/bs/bs-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A Battleships clone"

bs_build() {
	[ -d bs-$PACKAGE_VERSION ] && rm -rf bs-$PACKAGE_VERSION
	tar -xzvf bs-$PACKAGE_VERSION.tar.gz
	cd bs-$PACKAGE_VERSION

	$MAKE CC="$CC" TERMLIB="$LDFLAGS -lncurses"
}

bs_package() {
	install -D -m 755 bs "$1/bin/bs"
	install -D -m 644 bs.6 "$1/usr/share/man/man6/bs.6"
	install -D -m 644 README "$1/usr/share/doc/bs/README"
	install -m 644 NEWS "$1/usr/share/doc/bs/NEWS"
	install -m 644 COPYING "$1/usr/share/doc/bs/COPYING"
}
