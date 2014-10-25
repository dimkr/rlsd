PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/dimkr/shus/archive/master.zip,shus-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A web server"

build() {
	[ -d shus-master ] && rm -rf shus-master
	unzip shus-$PACKAGE_VERSION.zip
	cd shus-master

	USER="nobody" $MAKE
}

package() {
	$MAKE DESTDIR="$1" SBIN_DIR="/bin" install
}
