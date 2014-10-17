PACKAGE_VERSION="1.6"
PACKAGE_SOURCES="http://download.savannah.gnu.org/releases/lzip/clzip/clzip-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A compression tool"

clzip_build() {
	[ -d clzip-$PACKAGE_VERSION ] && rm -rf clzip-$PACKAGE_VERSION
	tar -xzvf clzip-$PACKAGE_VERSION.tar.gz
	cd clzip-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/clzip-info.patch"

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            CC="$CC" \
	            CFLAGS="$CFLAGS" \
	            LDFLAGS="$LDFLAGS"
	$MAKE
}

clzip_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/clzip/README"
	install -m 644 NEWS "$1/usr/share/doc/clzip/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/clzip/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/clzip/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/clzip/COPYING"
}
