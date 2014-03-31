PACKAGE_VERSION="2.5.3"
PACKAGE_SOURCES="http://download.savannah.gnu.org/releases/freetype/freetype-$PACKAGE_VERSION.tar.bz2"

freetype_build() {
	[ -d freetype-$PACKAGE_VERSION ] && rm -rf freetype-$PACKAGE_VERSION
	tar -xjvf freetype-$PACKAGE_VERSION.tar.bz2
	cd freetype-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --without-bzip2 \
	            --without-png \
	            --without-harfbuzz
	$MAKE
}

freetype_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/freetype/README"
	install -m 644 docs/CHANGES "$1/usr/share/doc/freetype/CHANGES"
	install -m 644 docs/LICENSE.TXT "$1/usr/share/doc/freetype/LICENSE.TXT"
	install -m 644 docs/FTL.TXT "$1/usr/share/doc/freetype/FTL.TXT"
	install -m 644 docs/GPLv2.TXT "$1/usr/share/doc/freetype/GPLv2.TXT"
}
