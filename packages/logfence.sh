PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/dimkr/logfence/archive/master.zip,logfence-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A file system that prevents log tampering"

build() {
	[ -d logfence-master ] && rm -rf logfence-master
	unzip logfence-$PACKAGE_VERSION.zip
	cd logfence-master

	$MAKE
}

package() {
	$MAKE DESTDIR="$1" SBIN_DIR="bin" install
}
