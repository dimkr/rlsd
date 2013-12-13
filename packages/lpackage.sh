PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/lpackage/archive/master.zip,lpackage-$PACKAGE_VERSION.zip"

lpackage_build() {
	[ -d lpackage-master ] && rm -rf lpackage-master
	unzip lpackage-$PACKAGE_VERSION.zip
	cd lpackage-master

	$MAKE CC="$CC" CFLAGS="$CFLAGS"
}

lpackage_package() {
	$MAKE DESTDIR="$1" BIN_DIR="bin" install
}
