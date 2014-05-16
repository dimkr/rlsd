PACKAGE_VERSION="0.6.0"
PACKAGE_SOURCES="http://distro.ibiblio.org/amigolinux/download/Applications/Misc/gcalendar-$PACKAGE_VERSION/gcalendar-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A calendar"

gcalendar_build() {
	[ -d gcalendar-$PACKAGE_VERSION ] && rm -rf gcalendar-$PACKAGE_VERSION
	tar -xjvf gcalendar-$PACKAGE_VERSION.tar.bz2
	cd gcalendar-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/gcalendar-build.patch"

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datadir=/usr/share
	$MAKE
}

gcalendar_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/gcalendar/README"
	install -m 644 ChangeLog "$1/usr/share/doc/gcalendar/ChangeLog"
	install -m 644 NEWS "$1/usr/share/doc/gcalendar/NEWS"
	install -m 644 AUTHORS "$1/usr/share/doc/gcalendar/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/gcalendar/COPYING"
	install -m 644 COPYING.LIB "$1/usr/share/doc/gcalendar/COPYING.LIB"
}
