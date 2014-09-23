PACKAGE_VERSION="1.0"
PACKAGE_SOURCES="http://m.seehuhn.de/programs/moon-buggy-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A moon-patrol clone"

moon_buggy_build() {
	[ -d moon-buggy-$PACKAGE_VERSION ] && rm -rf moon-buggy-$PACKAGE_VERSION
	tar -xzvf moon-buggy-$PACKAGE_VERSION.tar.gz
	cd moon-buggy-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --infodir=/usr/share/info \
	            --mandir=/usr/share/man \
	            --sharedstatedir=/var/games
	$MAKE
}

moon_buggy_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/moon-buggy/README"
	install -m 644 ChangeLog "$1/usr/share/doc/moon-buggy/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/moon-buggy/AUTHORS"
	install -m 644 THANKS "$1/usr/share/doc/moon-buggy/THANKS"
	install -m 644 COPYING "$1/usr/share/doc/moon-buggy/COPYING"
}
