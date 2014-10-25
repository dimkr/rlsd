PACKAGE_VERSION="1.1.2"
PACKAGE_SOURCES="http://xorg.freedesktop.org/archive/individual/lib/libfontenc-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A font encoding library"

build() {
	[ -d libfontenc-$PACKAGE_VERSION ] && rm -rf libfontenc-$PACKAGE_VERSION
	tar -xjvf libfontenc-$PACKAGE_VERSION.tar.bz2
	cd libfontenc-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --with-fontrootdir=/usr/share/fonts
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/libfontenc/README"
	install -m 644 ChangeLog "$1/usr/share/doc/libfontenc/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/libfontenc/COPYING"
}
