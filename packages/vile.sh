PACKAGE_VERSION="9.8"
PACKAGE_SOURCES="ftp://invisible-island.net/vile/vile-$PACKAGE_VERSION.tgz"

vile_build() {
	[ -d vile-$PACKAGE_VERSION ] && rm -rf vile-$PACKAGE_VERSION
	tar -xzvf vile-$PACKAGE_VERSION.tgz
	cd vile-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datadir=/usr/share \
	            --mandir=/usr/share/man \
	            --disable-plugins \
	            --without-pkg-config \
	            --with-ncurses \
	            --without-locale \
	            --without-icondir \
	            --disable-desktop
	$MAKE
}

vile_package() {
	$MAKE DESTDIR="$1" install
	ln -s vile "$1/bin/vi"
	install -D -m 644 README "$1/usr/share/doc/vile/README"
	for i in CHANGES*
	do
		install -D -m 644 $i "$1/usr/share/doc/vile/$i"
	done
	install -D -m 644 AUTHORS "$1/usr/share/doc/vile/AUTHORS"
	install -D -m 644 COPYING "$1/usr/share/doc/vile/COPYING"
}
