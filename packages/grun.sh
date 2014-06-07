PACKAGE_VERSION="0.8.1"
PACKAGE_SOURCES="http://distro.ibiblio.org/amigolinux/download/DeskTop/Launchers/grun-$PACKAGE_VERSION/grun-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="An application launcher"

grun_build() {
	[ -d grun-$PACKAGE_VERSION ] && rm -rf grun-$PACKAGE_VERSION
	tar -xjvf grun-$PACKAGE_VERSION.tar.bz2
	cd grun-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/grun-build.patch"
	./configure --host=$HOST --prefix= --mandir=/usr/share/man
	$MAKE
}

grun_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 grun2.xpm "$1/usr/share/pixmaps/grun.xpm"
	install -D -m 644 README "$1/usr/share/doc/grun/README"
	install -m 644 NEWS "$1/usr/share/doc/grun/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/grun/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/grun/AUTHORS"
	install -m 644 README "$1/usr/share/doc/grun/README"
	install -m 644 COPYING "$1/usr/share/doc/grun/COPYING"
}
