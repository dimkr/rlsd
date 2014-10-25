PACKAGE_VERSION="1.6.2"
PACKAGE_SOURCES="http://www.tcpdump.org/release/libpcap-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A packet capture library"

build() {
	[ -d libpcap-$PACKAGE_VERSION ] && rm -rf libpcap-$PACKAGE_VERSION
	tar -xzvf libpcap-$PACKAGE_VERSION.tar.gz
	cd libpcap-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/libpcap/README"
	install -m 644 CHANGES "$1/usr/share/doc/libpcap/CHANGES"
	install -m 644 CREDITS "$1/usr/share/doc/libpcap/CREDITS"
	install -m 644 LICENSE "$1/usr/share/doc/libpcap/LICENSE"
}
