PACKAGE_VERSION="1.0.8"
PACKAGE_SOURCES="http://xorg.freedesktop.org/archive/individual/app/xmodmap-$PACKAGE_VERSION.tar.bz2"

xmodmap_build() {
	[ -d xmodmap-$PACKAGE_VERSION ] && rm -rf xmodmap-$PACKAGE_VERSION
	tar -xjvf xmodmap-$PACKAGE_VERSION.tar.bz2
	cd xmodmap-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share
	$MAKE
}

xmodmap_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/xmodmap/README"
	install -m 644 ChangeLog "$1/usr/share/doc/xmodmap/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/xmodmap/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/xmodmap/COPYING"
}
