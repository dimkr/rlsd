PACKAGE_VERSION="4.0.0"
PACKAGE_SOURCES="http://downloads.sourceforge.net/project/unnethack/unnethack/$PACKAGE_VERSION/unnethack-4.0.0-20120401.tar.gz"

unnethack_build() {
	[ -d unnethack-4.0.0-20120401 ] && rm -rf unnethack-4.0.0-20120401
	tar -xzvf unnethack-4.0.0-20120401.tar.gz
	cd unnethack-4.0.0-20120401

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-curses-graphics \
	            --enable-tty-graphics \
	            --enable-utf8-glyphs=no \
	            --enable-wizmode=root \
	            --with-owner=root \
	            --with-group=root \
	            --with-gamesdir=/var/lib/unnethack
	make
}

unnethack_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/unnethack/README"
	install -m 644 doc/Guidebook.txt "$1/usr/share/doc/unnethack/Guidebook.txt"
	install -m 644 dat/license "$1/usr/share/doc/unnethack/license"
}
