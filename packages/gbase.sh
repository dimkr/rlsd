PACKAGE_VERSION="0.5"
PACKAGE_SOURCES="http://fluxcode.net/files/gbase-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A base converter"

build() {
	[ -d gbase-$PACKAGE_VERSION ] && rm -rf gbase-$PACKAGE_VERSION
	tar -xzvf gbase-$PACKAGE_VERSION.tar.gz
	cd gbase-$PACKAGE_VERSION

	$CC $CFLAGS $(gtk-config --cflags) \
	    gbase.c \
	    $LDFLAGS $(gtk-config --libs) \
	    -o gbase
}

package() {
	install -D -m 755 gbase "$1/bin/gbase"
	install -D -m 644 README "$1/usr/share/doc/gbase/README"
	install -m 644 Artistic "$1/usr/share/doc/gbase/Artistic"
}
