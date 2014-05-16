PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/dillo/archive/master.zip,dillo-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A web browser"

dillo_build() {
	[ -d dillo-master ] && rm -rf dillo-master
	unzip dillo-$PACKAGE_VERSION.zip
	cd dillo-master

	./configure --host=$HOST \
	            --prefix= \
	            --datadir=/usr/share \
	            --enable-ipv6 \
	            --disable-dlgui
	$MAKE
}

dillo_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/dillo/README"
	install -m 644 NEWS "$1/usr/share/doc/dillo/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/dillo/ChangeLog"
	install -m 644 ChangeLog.old "$1/usr/share/doc/dillo/ChangeLog.old"
	install -m 644 AUTHORS "$1/usr/share/doc/dillo/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/dillo/COPYING"
}
