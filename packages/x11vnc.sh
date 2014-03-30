PACKAGE_VERSION="0.9.13"
PACKAGE_SOURCES="http://sourceforge.net/projects/libvncserver/files/x11vnc/$PACKAGE_VERSION/x11vnc-$PACKAGE_VERSION.tar.gz"

x11vnc_build() {
	[ -d x11vnc-$PACKAGE_VERSION ] && rm -rf x11vnc-$PACKAGE_VERSION
	tar -xzvf x11vnc-$PACKAGE_VERSION.tar.gz
	cd x11vnc-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix=/usr \
	            --bindir=/bin \
	            --datadir=/usr/share \
	            --without-xkeyboard \
	            --without-avahi
	$MAKE
}

x11vnc_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/x11vnc/README"
	install -m 644 README.LibVNCServer "$1/usr/share/doc/x11vnc/README.LibVNCServer"
	install -m 644 NEWS "$1/usr/share/doc/x11vnc/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/x11vnc/ChangeLog"
	install -m 644 RELEASE-NOTES "$1/usr/share/doc/x11vnc/RELEASE-NOTES"
	install -m 644 AUTHORS "$1/usr/share/doc/x11vnc/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/x11vnc/COPYING"
}
