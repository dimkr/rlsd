PACKAGE_VERSION="1.1"
PACKAGE_SOURCES="http://distro.ibiblio.org/amigolinux/download/Applications/Graphics/gtkfontsel-$PACKAGE_VERSION/gtkfontsel-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A font chooser"

build() {
	[ -d gtkfontsel-$PACKAGE_VERSION ] && rm -rf gtkfontsel-$PACKAGE_VERSION
	tar -xjvf gtkfontsel-$PACKAGE_VERSION.tar.bz2
	cd gtkfontsel-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datadir=/usr/share
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/gtkfontsel/README"
	install -m 644 NEWS "$1/usr/share/doc/gtkfontsel/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/gtkfontsel/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/gtkfontsel/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/gtkfontsel/COPYING"
}
