PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/dimkr/xplayargs/archive/master.zip,xplayargs-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A xargs-like audio player"

build() {
	[ -d xplayargs-master ] && rm -rf xplayargs-master
	unzip xplayargs-$PACKAGE_VERSION.zip
	cd xplayargs-master

	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
}
