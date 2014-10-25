PACKAGE_VERSION="1.3.0"
PACKAGE_SOURCES="http://xorg.freedesktop.org/archive/individual/font/font-util-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="X11 font utilities"

build() {
	[ -d font-util-$PACKAGE_VERSION ] && rm -rf font-util-$PACKAGE_VERSION
	tar -xjvf font-util-$PACKAGE_VERSION.tar.bz2
	cd font-util-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            --with-fontrootdir=/usr/share/fonts
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/font-util/README"
	install -m 644 ChangeLog "$1/usr/share/doc/font-util/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/font-util/COPYING"
}
