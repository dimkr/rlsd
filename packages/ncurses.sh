PACKAGE_VERSION="5.9"
PACKAGE_SOURCES="http://ftp.gnu.org/pub/gnu/ncurses/ncurses-$PACKAGE_VERSION.tar.gz"

ncurses_build() {
	[ -d ncurses-$PACKAGE_VERSION ] && rm -rf ncurses-$PACKAGE_VERSION
	tar -xzvf ncurses-$PACKAGE_VERSION.tar.gz
	cd ncurses-$PACKAGE_VERSION

	# force the installation of pkg-config files
	patch -p 1 < "$BASE_DIR/patches/ncurses-pkg-config.patch"

	# building with "--enable-glob" fails against musl 0.9.12
	if [ 1 -eq $STATIC ]
	then
		library_flags="--without-shared --with-normal"
	else
		library_flags="--with-shared --without-normal"
	fi
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
	            $library_flags \
	            --without-debug \
	            --without-profile \
	            --with-manpage-format=normal
	$MAKE
}

ncurses_package() {
	$MAKE DESTDIR="$1" install
	mv "$1/usr/lib/pkgconfig" "$1/lib/"
	rmdir "$1/usr/lib"
	ln -s libncurses.a "$1/lib/libtinfo.a"
	install -D -m 644 README "$1/usr/share/doc/ncurses/README"
	install -D -m 644 NEWS "$1/usr/share/doc/ncurses/NEWS"
	install -D -m 644 ANNOUNCE "$1/usr/share/doc/ncurses/ANNOUNCE"
	install -D -m 644 AUTHORS "$1/usr/share/doc/ncurses/AUTHORS"
}
