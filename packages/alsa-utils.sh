PACKAGE_VERSION="1.0.28"
PACKAGE_SOURCES="ftp://ftp.alsa-project.org/pub/utils/alsa-utils-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="Audio tools"

build() {
	[ -d alsa-utils-$PACKAGE_VERSION ] && rm -rf alsa-utils-$PACKAGE_VERSION
	tar -xjvf alsa-utils-$PACKAGE_VERSION.tar.bz2
	cd alsa-utils-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/alsa-utils-sounds.patch"
	autoconf

	./configure --host=$HOST \
	            --prefix= \
	            --sbindir=/bin \
	            --datarootdir=/usr/share \
	            --disable-nls \
	            --disable-xmlto \
	            --without-udev-rules-dir \
	            --with-curses=ncurses \
	            --with-asound-state-dir=/etc \
	            --with-alsactl-pidfile-dir=/run
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/alsa-utils/README"
	install -m 644 ChangeLog "$1/usr/share/doc/alsa-utils/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/alsa-utils/COPYING"
}
