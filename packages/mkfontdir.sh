PACKAGE_VERSION="1.0.7"
PACKAGE_SOURCES="http://xorg.freedesktop.org/archive/individual/app/mkfontdir-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A tool for indexing fonts"

mkfontdir_build() {
	[ -d mkfontdir-$PACKAGE_VERSION ] && rm -rf mkfontdir-$PACKAGE_VERSION
	tar -xjvf mkfontdir-$PACKAGE_VERSION.tar.bz2
	cd mkfontdir-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share
	$MAKE
}

mkfontdir_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/mkfontdir/README"
	install -m 644 ChangeLog "$1/usr/share/doc/mkfontdir/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/mkfontdir/COPYING"
}
