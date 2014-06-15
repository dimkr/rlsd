PACKAGE_VERSION="1.6.2"
PACKAGE_SOURCES="http://xorg.freedesktop.org/archive/individual/lib/libXaw3d-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A graphical toolkit"

libxaw3d_build() {
	[ -d libXaw3d-$PACKAGE_VERSION ] && rm -rf libXaw3d-$PACKAGE_VERSION
	tar -xjvf libXaw3d-$PACKAGE_VERSION.tar.bz2
	cd libXaw3d-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/libxaw3d-tinyxlib.patch"

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --disable-internationalization
	$MAKE
}

libxaw3d_package() {
	$MAKE DESTDIR="$1" install
	install -m 644 ChangeLog "$1/usr/share/doc/libXaw3d/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/libXaw3d/COPYING"
}
