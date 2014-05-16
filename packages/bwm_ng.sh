PACKAGE_VERSION="0.6"
PACKAGE_SOURCES="http://www.gropp.org/bwm-ng/bwm-ng-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A network monitor"

bwm_ng_build() {
	[ -d bwm-ng-$PACKAGE_VERSION ] && rm -rf bwm-ng-$PACKAGE_VERSION
	tar -xzvf bwm-ng-$PACKAGE_VERSION.tar.gz
	cd bwm-ng-$PACKAGE_VERSION
	./configure --host=$HOST --prefix= --datarootdir=/usr/share
	$MAKE
}

bwm_ng_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/bwm-ng/README"
	install -D -m 644 NEWS "$1/usr/share/doc/bwm-ng/NEWS"
	install -D -m 644 AUTHORS "$1/usr/share/doc/bwm-ng/AUTHORS"
	install -D -m 644 THANKS "$1/usr/share/doc/bwm-ng/THANKS"
	install -D -m 644 COPYING "$1/usr/share/doc/bwm-ng/COPYING"
}
