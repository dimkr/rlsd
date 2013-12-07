PACKAGE_VERSION="20130513"
PACKAGE_SOURCES="http://tukaani.org/xz/xz-embedded-$PACKAGE_VERSION.tar.gz"

xz_embedded_build() {
	[ -d xz-embedded-$PACKAGE_VERSION ] && rm -rf xz-embedded-$PACKAGE_VERSION
	tar -xzvf xz-embedded-$PACKAGE_VERSION.tar.gz
	cd xz-embedded-$PACKAGE_VERSION/userspace

	sed -e s~'CC =.*'~"CC = $CC"~ \
	    -e s~'CFLAGS =.*'~"CFLAGS = $CFLAGS"~ \
	    -i Makefile
	make LDFLAGS="$LDFLAGS"
}

xz_embedded_package() {
	install -D -m 755 xzminidec "$1/bin/xzminidec"
	install -D -m 644 ../README "$1/usr/share/doc/xz-embedded/README"
	install -m 644 ../COPYING "$1/usr/share/doc/xz-embedded/COPYING"
}
