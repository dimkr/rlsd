PACKAGE_VERSION="6.1.0"
PACKAGE_SOURCES="http://roy.marples.name/downloads/dhcpcd/dhcpcd-$PACKAGE_VERSION.tar.bz2"

dhcpcd_build() {
	[ -d dhcpcd-$PACKAGE_VERSION ] && rm -rf dhcpcd-$PACKAGE_VERSION
	tar -xjvf dhcpcd-$PACKAGE_VERSION.tar.bz2
	cd dhcpcd-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/dhcpcd-musl.patch"
	./configure --host=$HOST \
	            --prefix=/ \
	            --sbindir=/bin \
	            --mandir=/usr/share/man \
	            --libexecdir=/lib/dhcpcd
	$MAKE
}

dhcpcd_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/dhcpcd/README"
}
