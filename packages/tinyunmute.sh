PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/tinyunmute/archive/master.zip,tinyunmute-$PACKAGE_VERSION.zip"
PACKAGE_DESC="An audio volume unmuting tool"

tinyunmute_build() {
	[ -d tinyunmute-master ] && rm -rf tinyunmute-master
	unzip tinyunmute-$PACKAGE_VERSION.zip
	cd tinyunmute-master

	$MAKE CC="$CC" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS"
}

tinyunmute_package() {
	$MAKE DESTDIR="$1" BIN_DIR="/bin" install
}
