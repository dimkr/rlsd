PACKAGE_VERSION="2.30"
PACKAGE_SOURCES="http://sethwklein.net/iana-etc-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="IANA data files"
PACKAGE_ARCH="all"

build() {
	[ -d iana-etc-$PACKAGE_VERSION ] && rm -rf iana-etc-$PACKAGE_VERSION
	tar -xjvf iana-etc-$PACKAGE_VERSION.tar.bz2
	cd iana-etc-$PACKAGE_VERSION

	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/iana-etc/README"
	install -m 644 NEWS "$1/usr/share/doc/iana-etc/NEWS"
	install -m 644 CREDITS "$1/usr/share/doc/iana-etc/CREDITS"
	install -m 644 COPYING "$1/usr/share/doc/iana-etc/COPYING"
}
