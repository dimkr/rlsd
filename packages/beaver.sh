PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/beaver/archive/master.zip,beaver-$PACKAGE_VERSION.zip"

beaver_build() {
	[ -d beaver-master ] && rm -rf beaver-master
	unzip beaver-$PACKAGE_VERSION.zip
	cd beaver-master

	patch -p 1 < "$BASE_DIR/patches/beaver-font.patch"

	cd src

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
