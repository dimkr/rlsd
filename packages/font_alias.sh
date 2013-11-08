PACKAGE_VERSION="1.0.3"
PACKAGE_SOURCES="http://xorg.freedesktop.org/releases/individual/font/font-alias-$PACKAGE_VERSION.tar.bz2"

font_alias_build() {
	[ -d font-alias-$PACKAGE_VERSION ] && rm -rf font-alias-$PACKAGE_VERSION
	tar -xjvf font-alias-$PACKAGE_VERSION.tar.bz2
	cd font-alias-$PACKAGE_VERSION

	./configure --host=$HOST --with-fontrootdir=/usr/share/fonts
	make
}

font_alias_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/font-alias/README"
	install -m 644 ChangeLog "$1/usr/share/doc/font-alias/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/font-alias/COPYING"
}
