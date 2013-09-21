PACKAGE_VERSION="4.2.5-P1"
PACKAGE_SOURCES="ftp://ftp.isc.org/isc/dhcp/$PACKAGE_VERSION/dhcp-$PACKAGE_VERSION.tar.gz"

dhcp_build() {
	[ -d dhcp-$PACKAGE_VERSION ] && rm -rf dhcp-$PACKAGE_VERSION
	tar -xzvf dhcp-$PACKAGE_VERSION.tar.gz
	cd dhcp-$PACKAGE_VERSION

	sed s~'#include <net/if_packet.h>'~'#include <linux/if_packet.h>'~ \
	    -i common/lpf.c
	sed s~'#define _ARPA_NAMESER_H_'~'&\n#include <sys/types.h>'~ \
	    -i includes/arpa/nameser.h
	sed s~'"/sbin/dhclient-script"'~'"/bin/dhclient-script"'~ \
	   -i includes/dhcpd.h

	./configure --host=$HOST \
	            --prefix= \
	            --sbindir=/bin \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share
	make
}

dhcp_package() {
	make DESTDIR="$1" install
	install -m 755 client/scripts/linux "$1/bin/dhclient-script"
	install -D -m 644 README "$1/usr/share/doc/dhcp/README"
	install -m 644 RELNOTES "$1/usr/share/doc/dhcp/RELNOTES"
	install -m 644 LICENSE "$1/usr/share/doc/dhcp/LICENSE"
}
