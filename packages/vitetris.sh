PACKAGE_VERSION="0.57"
PACKAGE_SOURCES="http://www.victornils.net/tetris/vitetris-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A Tetris clone"

vitetris_build() {
	[ -d vitetris-$PACKAGE_VERSION ] && rm -rf vitetris-$PACKAGE_VERSION
	tar -xzvf vitetris-$PACKAGE_VERSION.tar.gz
	cd vitetris-$PACKAGE_VERSION

	./configure --prefix= --datarootdir=/usr/share curses=yes xlib=no
	$MAKE
}

vitetris_package() {
	$MAKE DESTDIR="$1" install
	install -m 644 changes.txt "$1/usr/share/doc/vitetris/changes.txt"
}
