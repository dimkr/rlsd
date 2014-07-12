PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/dimkr/tinyxlib/archive/master.zip,tinyxlib-$PACKAGE_VERSION.zip"
PACKAGE_DESC="Core graphics library"

tinyxlib_build() {
	[ -d tinyxlib-master ] && rm -rf tinyxlib-master
	unzip tinyxlib-$PACKAGE_VERSION.zip
	cd tinyxlib-master

	$MAKE clean
	$MAKE CC="$CC" \
	      EXTRA_CFLAGS="$CFLAGS" \
	      LDFLAGS="$LDFLAGS" \
	      BINDIR="/bin" \
	      LIBDIR="/lib" \
	      STATIC="$STATIC" \
	      FONT_ENCODINGS_DIRECTORY="/usr/share/fonts/encodings/encodings.dir"
}

tinyxlib_package() {
	$MAKE DESTDIR="$1" BINDIR="/bin" LIBDIR="/lib" STATIC="$STATIC" install
	install -D -m 644 README "$1/usr/share/doc/tinyxlib/README"
	install -m 644 libXau/README "$1/usr/share/doc/tinyxlib/README.libXau"
	install -m 644 libXmu/README "$1/usr/share/doc/tinyxlib/README.libXmu"
	install -m 644 changelog "$1/usr/share/doc/tinyxlib/changelog"
}
