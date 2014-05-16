PACKAGE_VERSION="1.1.0"
PACKAGE_SOURCES="http://www.6809.org.uk/evilwm/evilwm-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A window manager"

evilwm_build() {
	[ -d evilwm-$PACKAGE_VERSION ] && rm -rf evilwm-$PACKAGE_VERSION
	tar -xzvf evilwm-$PACKAGE_VERSION.tar.gz
	cd evilwm-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/evilwm-build.patch"
	patch -p 1 < "$BASE_DIR/patches/evilwm-config.patch"
	$MAKE
}

evilwm_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/evilwm/README"
	install -m 644 ChangeLog "$1/usr/share/doc/evilwm/ChangeLog"
}
