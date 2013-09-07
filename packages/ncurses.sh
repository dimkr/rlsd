PACKAGE_VERSION="5.9"
PACKAGE_SOURCES="http://ftp.gnu.org/pub/gnu/ncurses/ncurses-$PACKAGE_VERSION.tar.gz"

ncurses_build() {
	[ -d ncurses-$PACKAGE_VERSION ] && rm -rf ncurses-$PACKAGE_VERSION
	tar -xzvf ncurses-$PACKAGE_VERSION.tar.gz
	cd ncurses-$PACKAGE_VERSION

	# building with "--enable-glob" fails against musl 0.9.12
	./configure --host=$HOST \
	            --prefix= \
	            --datadir=/usr/share \
	            --includedir=/usr/include \
	            --mandir=/usr/share/man \
	            --without-cxx \
	            --without-cxx-binding \
	            --without-ada \
	            --without-progs \
	            --without-tests \
	            --enable-pc-files \
	            --without-libtool \
	            --without-shared \
	            --with-normal \
	            --without-debug \
	            --without-profile
	make
}

ncurses_package() {
	make DESTDIR="$1" install
	mv "$1/usr/lib/pkgconfig" "$1/lib/"
	rmdir "$1/usr/lib"
	install -D -m 644 README "$1/usr/share/doc/ncurses/README"
	install -D -m 644 NEWS "$1/usr/share/doc/ncurses/NEWS"
	install -D -m 644 ANNOUNCE "$1/usr/share/doc/ncurses/ANNOUNCE"
	install -D -m 644 AUTHORS "$1/usr/share/doc/ncurses/AUTHORS"
}
