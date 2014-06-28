PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/emelfm/archive/master.zip,emelfm-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A two-pane file manager"

emelfm_build() {
	[ -d emelfm-master ] && rm -rf emelfm-master
	unzip emelfm-$PACKAGE_VERSION.zip
	cd emelfm-master
	
	patch -p 1 < "$BASE_DIR/patches/emelfm-build.patch"
	patch -p 1 < "$BASE_DIR/patches/emelfm-aterm.patch"
	patch -p 1 < "$BASE_DIR/patches/emelfm-font.patch"
	$MAKE
}

emelfm_package() {
	install -D -m 755 emelfm "$1/bin/emelfm"
	install -D -m 644 README "$1/usr/share/doc/emelfm/README"
	install -D -m 644 docs/help.txt \
	                  "$1/usr/share/doc/emelfm/docs/help.txt"
	install -m 644 COPYING "$1/usr/share/doc/emelfm/COPYING"
}
