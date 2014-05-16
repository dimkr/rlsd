PACKAGE_VERSION="0.2"
PACKAGE_SOURCES="http://downloads.sourceforge.net/project/gdmap/gdmap/$PACKAGE_VERSION/gdmap-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A disk usage visualizer"

gdmap_build() {
	[ -d gdmap-$PACKAGE_VERSION ] && rm -rf gdmap-$PACKAGE_VERSION
	tar -xzvf gdmap-$PACKAGE_VERSION.tar.gz
	cd gdmap-$PACKAGE_VERSION

	./configure --host=$HOST --prefix= --datadir=/usr/share
	$MAKE
}

gdmap_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/gdmap/README"
	install -m 644 AUTHORS "$1/usr/share/doc/gdmap/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/gdmap/COPYING"
}
