PACKAGE_VERSION="0.1"
PACKAGE_SOURCES="http://www.ne.jp/asahi/linux/timecop/software/gtkcat-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A disk cataloger"

gtkcat_build() {
	[ -d gtkcat-$PACKAGE_VERSION ] && rm -rf gtkcat-$PACKAGE_VERSION
	tar -xzvf gtkcat-$PACKAGE_VERSION.tar.gz
	cd gtkcat-$PACKAGE_VERSION

	sed -e s~'CC		= .*'~"CC = $CC"~ \
	    -e s~'CFLAGS		= -O3 -Wall '~"CFLAGS = $CFLAGS "~ \
	    -e s~'LDFLAGS		= '~"&$LDFLAGS "~ \
	    -i Makefile
	$MAKE
}

gtkcat_package() {
	install -D -m 755 gtkcat "$1/bin/gtkcat"
	install -D -m 644 README "$1/usr/share/doc/gtkcat/README"
}
