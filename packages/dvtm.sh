PACKAGE_VERSION="0.12"
PACKAGE_SOURCES="http://www.brain-dump.org/projects/dvtm/dvtm-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A dynamic virtual terminal manager"

dvtm_build() {
	[ -d dvtm-$PACKAGE_VERSION ] && rm -rf dvtm-$PACKAGE_VERSION
	tar -xzvf dvtm-$PACKAGE_VERSION.tar.gz
	cd dvtm-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/dvtm-term.patch"
	patch -p 1 < "$BASE_DIR/patches/dvtm-build.patch"

	$MAKE
}

dvtm_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/dvtm/README"
	install -m 644 LICENSE "$1/usr/share/doc/dvtm/LICENSE"
}
