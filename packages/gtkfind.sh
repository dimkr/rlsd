PACKAGE_VERSION="1.1"
PACKAGE_SOURCES="http://distro.ibiblio.org/amigolinux/download/Applications/Search/gtkfind-$PACKAGE_VERSION/gtkfind-$PACKAGE_VERSION.tar.bz2"

gtkfind_build() {
	[ -d gtkfind-$PACKAGE_VERSION ] && rm -rf gtkfind-$PACKAGE_VERSION
	tar -xjvf gtkfind-$PACKAGE_VERSION.tar.bz2
	cd gtkfind-$PACKAGE_VERSION

	patch -p1 < "$BASE_DIR/patches/gtkfind-cflags.patch"
	CONFIG_XTERM="/bin/aterm" \
	./configure --host=$HOST --prefix= --mandir=/usr/share/man
	$MAKE
}

gtkfind_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/gtkfind/README"
	install -m 644 COPYING "$1/usr/share/doc/gtkfind/COPYING"
}
