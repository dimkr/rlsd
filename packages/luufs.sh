PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/dimkr/luufs/archive/master.zip,luufs-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A union file system"

build() {
	[ -d luufs-master ] && rm -rf luufs-master
	unzip luufs-$PACKAGE_VERSION.zip
	cd luufs-master

	$MAKE CC="$CC" CFLAGS="$CFLAGS"
}

package() {
	$MAKE DESTDIR="$1" SBIN_DIR="bin" install
}
