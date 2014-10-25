PACKAGE_VERSION="4.6.2"
PACKAGE_SOURCES="http://www.tcpdump.org/release/tcpdump-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A packet capture and analysis tool"

build() {
	[ -d tcpdump-$PACKAGE_VERSION ] && rm -rf tcpdump-$PACKAGE_VERSION
	tar -xzvf tcpdump-$PACKAGE_VERSION.tar.gz
	cd tcpdump-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/tcpdump-binary.patch"

	./configure --host=$HOST \
	            --prefix= \
	            --sbindir=/bin \
	            --datarootdir=/usr/share \
	            --enable-ipv6 \
	            --with-crypto
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README.md "$1/usr/share/doc/tcpdump/README.md"
	install -m 644 CHANGES "$1/usr/share/doc/tcpdump/CHANGES"
	install -m 644 CREDITS "$1/usr/share/doc/tcpdump/CREDITS"
	install -m 644 LICENSE "$1/usr/share/doc/tcpdump/LICENSE"
}
