PACKAGE_VERSION="3.2.3"
PACKAGE_SOURCES="http://roy.marples.name/downloads/dhcpcd/dhcpcd-$PACKAGE_VERSION.tar.bz2 http://ftp.de.debian.org/debian/pool/main/d/dhcpcd/dhcpcd_3.2.3-11.diff.gz"
PACKAGE_DESC="A DHCP client"

dhcpcd_build() {
	[ -d dhcpcd-$PACKAGE_VERSION ] && rm -rf dhcpcd-$PACKAGE_VERSION
	tar -xjvf dhcpcd-$PACKAGE_VERSION.tar.bz2
	cd dhcpcd-$PACKAGE_VERSION

	cat ../dhcpcd_3.2.3-11.diff.gz | gzip -d | patch -p 1
	patch -p 1 < "$BASE_DIR/patches/dhcpcd-musl.patch"

	$MAKE CC="$CC" CFLAGS="-Icompat $CFLAGS" LDFLAGS="$LDFLAGS" INFODIR="/run"
}

dhcpcd_package() {
	$MAKE DESTDIR="$1" BINDIR="/bin" install
	install -D -m 644 README "$1/usr/share/doc/dhcpcd/README"
}
