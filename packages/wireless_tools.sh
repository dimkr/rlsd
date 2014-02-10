PACKAGE_VERSION="29"
PACKAGE_SOURCES="http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/wireless_tools.$PACKAGE_VERSION.tar.gz"

wireless_tools_build() {
	[ -d wireless_tools.$PACKAGE_VERSION ] && rm -rf wireless_tools.$PACKAGE_VERSION
	tar -xzvf wireless_tools.$PACKAGE_VERSION.tar.gz
	cd wireless_tools.$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/wireless_tools-build.patch"
	$MAKE CC="$CC" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" BUILD_STATIC=1
}

wireless_tools_package() {
	$MAKE PREFIX="$1" BUILD_STATIC=1 install
	install -D -m 644 README "$1/usr/share/doc/wireless_tools/README"
	install -m 644 CHANGELOG.h "$1/usr/share/doc/wireless_tools/CHANGELOG.h"
	install -m 644 COPYING "$1/usr/share/doc/wireless_tools/COPYING"
}
