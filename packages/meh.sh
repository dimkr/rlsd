PACKAGE_VERSION="0.3"
PACKAGE_SOURCES="http://web.uvic.ca/%7Ejhawthor/meh-$PACKAGE_VERSION.tar.gz"

meh_build() {
	[ -d meh-$PACKAGE_VERSION ] && rm -rf meh-$PACKAGE_VERSION
	tar -xzvf meh-$PACKAGE_VERSION.tar.gz
	cd meh-$PACKAGE_VERSION

	patch -p1 < "$BASE_DIR/patches/meh-musl.patch"
	patch -p1 < "$BASE_DIR/patches/meh-giflib.patch"
	patch -p1 < "$BASE_DIR/patches/meh-build.patch"
	make
}

meh_package() {
	make PREFIX="$1" install
	install -D -m 644 README "$1/usr/share/doc/meh/README"
	install -m 644 NEWS "$1/usr/share/doc/meh/NEWS"
	install -m 644 AUTHORS "$1/usr/share/doc/meh/AUTHORS"
	install -m 644 THANKS "$1/usr/share/doc/meh/THANKS"
	install -m 644 COPYING "$1/usr/share/doc/meh/COPYING"
}
