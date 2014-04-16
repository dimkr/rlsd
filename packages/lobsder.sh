PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/lobsder/archive/master.zip,lobsder-$PACKAGE_VERSION.zip"

lobsder_build() {
	[ -d lobsder-master ] && rm -rf lobsder-master
	unzip lobsder-$PACKAGE_VERSION.zip
	cd lobsder-master

	$MAKE
}

lobsder_package() {
	$MAKE DESTDIR="$1" LIB_DIR="/lib" install
}
