PACKAGE_VERSION="0.4"
PACKAGE_SOURCES="http://downloads.sourceforge.net/project/gcolor/gcolor/$PACKAGE_VERSION/gcolor-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A color chooser"

gcolor_build() {
	[ -d gcolor-$PACKAGE_VERSION ] && rm -rf gcolor-$PACKAGE_VERSION
	tar -xzvf gcolor-$PACKAGE_VERSION.tar.gz
	cd gcolor-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/gcolor-title.patch"

	./configure --host=$HOST \
	            --prefix= \
	            --datadir=/usr/share \
	            --disable-nls
	$MAKE
}

gcolor_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 AUTHORS "$1/usr/share/doc/gcolor/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/gcolor/COPYING"
}
