PACKAGE_VERSION="0.1"
PACKAGE_SOURCES="http://www.ne.jp/asahi/linux/timecop/software/gtkcat-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A disk cataloger"

build() {
	[ -d gtkcat-$PACKAGE_VERSION ] && rm -rf gtkcat-$PACKAGE_VERSION
	tar -xzvf gtkcat-$PACKAGE_VERSION.tar.gz
	cd gtkcat-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/gtkcat-build.patch"

	$MAKE
}

package() {
	$MAKE PREFIX="$1" install
	install -D -m 644 README "$1/usr/share/doc/gtkcat/README"
}
