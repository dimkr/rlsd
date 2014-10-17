PACKAGE_VERSION="2.9.3"
PACKAGE_SOURCES="http://downloads.sourceforge.net/project/fuse/fuse-2.X/$PACKAGE_VERSION/fuse-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="An interface for user-mode file systems"

fuse_build() {
	[ -d fuse-$PACKAGE_VERSION ] && rm -rf fuse-$PACKAGE_VERSION
	tar -xzvf fuse-$PACKAGE_VERSION.tar.gz
	cd fuse-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/fuse-musl.patch"
	patch -p 1 < "$BASE_DIR/patches/fuse-extra.patch"

	MOUNT_FUSE_PATH="/bin" \
	./configure --host=$HOST \
	            --prefix=/usr \
	            --bindir=/bin \
	            --libdir=/lib \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --disable-example \
	            --disable-mtab
	$MAKE
}

fuse_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/fuse/README"
	install -m 644 README.NFS "$1/usr/share/doc/fuse/README.NFS"
	install -m 644 NEWS "$1/usr/share/doc/fuse/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/fuse/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/fuse/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/fuse/COPYING"
	install -m 644 COPYING.LIB "$1/usr/share/doc/fuse/COPYING.LIB"
}
