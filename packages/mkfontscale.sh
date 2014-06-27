PACKAGE_VERSION="1.1.1"
PACKAGE_SOURCES="http://xorg.freedesktop.org/archive/individual/app/mkfontscale-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A tool for indexing scalable fonts"

mkfontscale_build() {
	[ -d mkfontscale-$PACKAGE_VERSION ] && rm -rf mkfontscale-$PACKAGE_VERSION
	tar -xjvf mkfontscale-$PACKAGE_VERSION.tar.bz2
	cd mkfontscale-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/mkfontscale-tiny.patch"

	autoconf
	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share
	$MAKE
}

mkfontscale_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/mkfontscale/README"
	install -m 644 ChangeLog "$1/usr/share/doc/mkfontscale/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/mkfontscale/COPYING"
}
