PACKAGE_VERSION="0.57"
PACKAGE_SOURCES="http://www.victornils.net/tetris/vitetris-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A Tetris clone"

vitetris_build() {
	[ -d vitetris-$PACKAGE_VERSION ] && rm -rf vitetris-$PACKAGE_VERSION
	tar -xzvf vitetris-$PACKAGE_VERSION.tar.gz
	cd vitetris-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/vitetris-build.patch"

	./configure --prefix= \
	            --datarootdir=/usr/share \
	            --desktopdir="" \
	            curses=yes \
	            xlib=no
	$MAKE
}

vitetris_package() {
	$MAKE DESTDIR="$1" install
	install -d -D -m 755 "$1/var/games/vitetris"
	install -m 644 changes.txt "$1/usr/share/doc/vitetris/changes.txt"
}
