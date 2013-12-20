PACKAGE_VERSION="0.26"
PACKAGE_SOURCES="http://distro.ibiblio.org/amigolinux/download/Applications/Filers/uxplor-$PACKAGE_VERSION/uxplor-$PACKAGE_VERSION.tar.bz2"

uxplor_build() {
	[ -d uxplor-$PACKAGE_VERSION ] && rm -rf uxplor-$PACKAGE_VERSION
	tar -xjvf uxplor-$PACKAGE_VERSION.tar.bz2
	cd uxplor-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/uxplor-global.patch"
	patch -p 1 < "$BASE_DIR/patches/uxplor-menu.patch"
	patch -p 1 < "$BASE_DIR/patches/uxplor-build.patch"
	$MAKE CC="$CC" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS"
}

uxplor_package() {
	install -D -m 755 uxplor "$1/bin/uxplor"
	install -D -m 644 README "$1/usr/share/doc/uxplor/README"
	install -m 644 CHANGELOG "$1/usr/share/doc/uxplor/CHANGELOG"
	install -m 644 LICENSE "$1/usr/share/doc/uxplor/LICENSE"
}