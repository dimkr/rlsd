PACKAGE_VERSION="1.8"
PACKAGE_SOURCES="http://www.interq.or.jp/libra/oohara/xsoldier/xsoldier-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A space-based shooter game"

xsoldier_build() {
	[ -d xsoldier-$PACKAGE_VERSION ] && rm -rf xsoldier-$PACKAGE_VERSION
	tar -xzvf xsoldier-$PACKAGE_VERSION.tar.gz
	cd xsoldier-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/xsoldier-build.patch"

	LIBS="$(pkg-config --libs x11 xpm)" \
	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-debug \
	            --without-sdl
	$MAKE
}

xsoldier_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/xsoldier/README"
	install -m 644 ChangeLog "$1/usr/share/doc/xsoldier/ChangeLog"
	install -m 644 GPL "$1/usr/share/doc/xsoldier/GPL"
	install -m 644 LICENSE "$1/usr/share/doc/xsoldier/LICENSE"
}
