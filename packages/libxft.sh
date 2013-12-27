PACKAGE_VERSION="2.3.1"
PACKAGE_SOURCES="http://xorg.freedesktop.org/releases/individual/lib/libXft-$PACKAGE_VERSION.tar.bz2 http://cgit.freedesktop.org/xorg/lib/libXft/patch/?id=4acfdaf95adb0a05c2a25550bdde036c865902f4,libXft-freetype-2.5.patch"

libxft_build() {
	[ -d libXft-$PACKAGE_VERSION ] && rm -rf libXft-$PACKAGE_VERSION
	tar -xjvf libXft-$PACKAGE_VERSION.tar.bz2
	cd libXft-$PACKAGE_VERSION

	patch -p 1 < ../libXft-freetype-2.5.patch
	patch -p 1 < "$BASE_DIR/patches/libXft-tinyxlib.patch"
	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS
	$MAKE
}

libxft_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/libXft/README"
	install -D -m 644 ChangeLog "$1/usr/share/doc/libXft/ChangeLog"
	install -D -m 644 AUTHORS "$1/usr/share/doc/libXft/AUTHORS"
	install -D -m 644 COPYING "$1/usr/share/doc/libXft/COPYING"
}
