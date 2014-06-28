PACKAGE_VERSION="0.9.2"
PACKAGE_SOURCES="http://emelfm.sourceforge.net/emelfm-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A two-pane file manager"

emelfm_build() {
	[ -d emelfm-$PACKAGE_VERSION ] && rm -rf emelfm-$PACKAGE_VERSION
	tar -xzvf emelfm-$PACKAGE_VERSION.tar.gz
	cd emelfm-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/emelfm-build.patch"
	patch -p 1 < "$BASE_DIR/patches/emelfm-aterm.patch"
	$MAKE
}

emelfm_package() {
	install -D -m 755 emelfm "$1/bin/emelfm"
	install -D -m 644 README "$1/usr/share/doc/emelfm/README"
	install -D -m 644 docs/help.txt \
	                  "$1/usr/share/doc/emelfm/docs/help.txt"
	install -m 644 COPYING "$1/usr/share/doc/emelfm/COPYING"
}
