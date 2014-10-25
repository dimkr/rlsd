PACKAGE_VERSION="1.97"
PACKAGE_SOURCES="http://www.han.de/~werner/ytree-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A file manager"

build() {
	[ -d ytree-$PACKAGE_VERSION ] && rm -rf ytree-$PACKAGE_VERSION
	tar -xzvf ytree-$PACKAGE_VERSION.tar.gz
	cd ytree-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/ytree-musl.patch"
	patch -p 1 < "$BASE_DIR/patches/ytree-build.patch"

	$MAKE CC="$CC"
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/ytree/README"
	install -m 644 CHANGES "$1/usr/share/doc/ytree/CHANGES"
	install -m 644 THANKS "$1/usr/share/doc/ytree/THANKS"
	install -m 644 COPYING "$1/usr/share/doc/ytree/COPYING"
}
