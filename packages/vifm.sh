PACKAGE_VERSION="0.7.7"
PACKAGE_SOURCES="http://prdownloads.sourceforge.net/vifm/vifm-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A two-pane file manager"

vifm_build() {
	[ -d vifm-$PACKAGE_VERSION ] && rm -rf vifm-$PACKAGE_VERSION
	tar -xjvf vifm-$PACKAGE_VERSION.tar.bz2
	cd vifm-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/vifm-elvis.patch"
	patch -p 1 < "$BASE_DIR/patches/vifm-converter.patch"

	LIBS="-lmagic -lz" \
	./configure --host=$HOST \
		    --prefix=/usr \
	            --bindir=/bin \
	            --disable-desktop-files \
	            --with-curses-name=ncurses
	$MAKE
}

vifm_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/vifm/README"
	install -m 644 FAQ "$1/usr/share/doc/vifm/FAQ"
	install -m 644 NEWS "$1/usr/share/doc/vifm/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/vifm/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/vifm/AUTHORS"
	install -m 644 THANKS "$1/usr/share/doc/vifm/THANKS"
	install -m 644 COPYING "$1/usr/share/doc/vifm/COPYING"
}
