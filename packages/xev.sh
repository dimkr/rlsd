PACKAGE_VERSION="1.1.0"
PACKAGE_SOURCES="http://xorg.freedesktop.org/archive/individual/app/xev-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A X11 events inspection tool"

build() {
	[ -d xev-$PACKAGE_VERSION ] && rm -rf xev-$PACKAGE_VERSION
	tar -xjvf xev-$PACKAGE_VERSION.tar.bz2
	cd xev-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/xev/README"
	install -m 644 ChangeLog "$1/usr/share/doc/xev/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/xev/COPYING"
}
