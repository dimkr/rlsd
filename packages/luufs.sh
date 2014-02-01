PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/luufs/archive/master.zip,luufs-$PACKAGE_VERSION.zip"

luufs_build() {
	[ -d luufs-master ] && rm -rf luufs-master
	unzip luufs-$PACKAGE_VERSION.zip
	cd luufs-master

	make clean
	$MAKE CC="$CC" CFLAGS="$CFLAGS"
}

luufs_package() {
	$MAKE DESTDIR="$1" SBIN_DIR="bin" install
}
