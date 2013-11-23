PACKAGE_VERSION="4.38"
PACKAGE_SOURCES="http://sourceforge.net/projects/terminus-font/files/terminus-font-$PACKAGE_VERSION/terminus-font-$PACKAGE_VERSION.tar.gz"

terminus_font_build() {
	[ -d terminus-font-$PACKAGE_VERSION ] && rm -rf terminus-font-$PACKAGE_VERSION
	tar -xzvf terminus-font-$PACKAGE_VERSION.tar.gz
	cd terminus-font-$PACKAGE_VERSION

	sh configure --psfdir=/usr/share/fonts/console \
	             --x11dir=/usr/share/fonts/misc
	make
}

terminus_font_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/terminus-font/README"
	install -m 644 CHANGES "$1/usr/share/doc/terminus-font/CHANGES"
	install -m 644 LICENSE "$1/usr/share/doc/terminus-font/LICENSE"
	install -m 644 AUTHORS "$1/usr/share/doc/terminus-font/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/terminus-font/COPYING"
	install -m 644 OFL.TXT "$1/usr/share/doc/terminus-font/OFL.TXT"
}
