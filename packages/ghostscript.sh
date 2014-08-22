PACKAGE_VERSION="9.14"
PACKAGE_SOURCES="http://downloads.ghostscript.com/public/ghostscript-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A PostScript and PDF interpreter"

ghostscript_build() {
	[ -d ghostscript-$PACKAGE_VERSION ] && rm -rf ghostscript-$PACKAGE_VERSION
	tar -xzvf ghostscript-$PACKAGE_VERSION.tar.gz
	cd ghostscript-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/ghostscript-tinyxlib.patch"
	patch -p 1 < "$BASE_DIR/patches/ghostscript-build.patch"

	autoconf
	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-fontconfig \
	            --disable-freetype \
	            --disable-gtk \
	            --disable-dynamic \
	            --with-system-libtiff \
	            --with-fontpath="/usr/share/fonts/75dpi:/usr/share/fonts/100dpi:/usr/share/fonts/misc:/usr/share/fonts/truetype:/usr/share/fonts/cyrillic"
	$MAKE
}

ghostscript_package() {
	$MAKE DESTDIR="$1" install
	mkdir -p "$1/usr/share/doc"
	ln -s ../ghostscript/$PACKAGE_VERSION/doc "$1/usr/share/doc/ghostscript"
	install -m 644 jpegxr/COPYRIGHT.txt "$1/usr/share/doc/ghostscript/COPYRIGHT.jpegxr"
	install -m 644 LICENSE "$1/usr/share/doc/ghostscript/LICENSE"
}
