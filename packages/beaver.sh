PACKAGE_VERSION="0.2.7"
PACKAGE_SOURCES="http://download.savannah.gnu.org/releases/beaver/archive/beaver-$PACKAGE_VERSION.tar.gz"

beaver_build() {
	[ -d beaver-$PACKAGE_VERSION ] && rm -rf beaver-$PACKAGE_VERSION
	tar -xzvf beaver-$PACKAGE_VERSION.tar.gz
	cd beaver-$PACKAGE_VERSION/src

	sed -e s~'CC      = .*'~"CC      = $CC"~ \
	    -e s~'DESTDIR = .*'~'DESTDIR ?= /'~ \
	    -e s~'OPTI    = .*'~"OPTI    = $CFLAGS"~ \
	    -e s~'LDFLAGS = '~"LDFLAGS = $LDFLAGS"~ \
	    -e s~'\$(DESTDIR)/share'~'$(DESTDIR)/usr/share'~g \
	    -e s~'\$(DESTDIR)/man'~'$(DESTDIR)/usr/share/man'~g \
	    -i Makefile
	$MAKE
}

beaver_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 ../README "$1/usr/share/doc/beaver/README"
	install -m 644 ../NEWS "$1/usr/share/doc/beaver/NEWS"
	install -m 644 ../ChangeLog "$1/usr/share/doc/beaver/ChangeLog"
	install -m 644 ../AUTHORS "$1/usr/share/doc/beaver/AUTHORS"
	install -m 644 ../THANKS "$1/usr/share/doc/beaver/THANKS"
	install -m 644 ../COPYING "$1/usr/share/doc/beaver/COPYING"
}