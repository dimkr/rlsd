PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/dimkr/lazy-utils/archive/master.zip,lazy-utils-$PACKAGE_VERSION.zip"
PACKAGE_DESC="System tools"

build() {
	[ -d lazy-utils-master ] && rm -rf lazy-utils-master
	unzip lazy-utils-$PACKAGE_VERSION.zip
	cd lazy-utils-master

	$MAKE
}

package() {
	$MAKE DESTDIR="$1" SBIN_DIR="/bin" install
}
