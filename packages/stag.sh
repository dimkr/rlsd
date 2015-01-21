PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/seenaburns/stag/archive/master.zip,stag-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A bar graph generator"

build() {
	[ -d stag-master ] && rm -rf stag-master
	unzip stag-$PACKAGE_VERSION.zip
	cd stag-master

	patch -p 1 < "$BASE_DIR/patches/stag-build.patch"

	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
}
