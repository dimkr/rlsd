PACKAGE_VERSION="trunk"
PACKAGE_SOURCES="svn://svn.openwrt.org/openwrt/trunk/package/libs/libnl-tiny,libnl-tiny-$PACKAGE_VERSION"

libnl_tiny_build() {
	[ -d libnl-tiny-$PACKAGE_VERSION ] && rm -rf libnl-tiny-$PACKAGE_VERSION
	tar -xJvf libnl-tiny-$PACKAGE_VERSION.tar.xz
	cd libnl-tiny-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/libnl_tiny-build.patch"
	cd src

	$MAKE CC="$CC" CFLAGS="$CFLAGS"
}

libnl_tiny_package() {
	install -D -m 644 libnl-tiny.a "$1/lib/libnl-tiny.a"
	mkdir -p "$1/usr/include"
	cp -r include "$1/usr/include/libnl-tiny"
	install -D -m 644 ../files/libnl-tiny.pc "$1/lib/pkgconfig/libnl-tiny.pc"
}
