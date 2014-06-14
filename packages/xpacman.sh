PACKAGE_VERSION="0.11"
PACKAGE_SOURCES="http://www.ibiblio.org/pub/X11/contrib/games/xpacman.tar.gz"
PACKAGE_DESC="A Pac-Man clone"

xpacman_build() {
	[ -d xpacman ] && rm -rf xpacman
	tar -xzvf xpacman.tar.gz
	cd xpacman

	patch -p 1 < "$BASE_DIR/patches/xpacman-build.patch"
	patch -p 1 < "$BASE_DIR/patches/xpacman-keys.patch"

	$CC $CFLAGS xpacman.c -o xpacman $LDFLAGS $(pkg-config --libs x11)
}

xpacman_package() {
	install -D -m 755 xpacman "$1/bin/xpacman"
	install -D -m 644 xpacman.README "$1/usr/share/doc/xpacman/xpacman.README"
}
