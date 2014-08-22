PACKAGE_VERSION="1.0.28"
PACKAGE_SOURCES="ftp://ftp.alsa-project.org/pub/lib/alsa-lib-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="Core audio library"

alsa_lib_build() {
	[ -d alsa-lib-$PACKAGE_VERSION ] && rm -rf alsa-lib-$PACKAGE_VERSION
	tar -xjvf alsa-lib-$PACKAGE_VERSION.tar.bz2
	cd alsa-lib-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/alsa-lib-build.patch"

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --includedir=/usr/include \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --disable-old-symbols \
	            --without-debug
	$MAKE
}

alsa_lib_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 ChangeLog "$1/usr/share/doc/alsa-lib/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/alsa-lib/COPYING"
}
