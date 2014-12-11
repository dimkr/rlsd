PACKAGE_VERSION="5.21"
PACKAGE_SOURCES="ftp://ftp.astron.com/pub/file/file-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A file type guessing tool"

build() {
	[ -d file-$PACKAGE_VERSION ] && rm -rf file-$PACKAGE_VERSION
	tar -xzvf file-$PACKAGE_VERSION.tar.gz
	cd file-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/file-locale.patch"
	patch -p 1 < "$BASE_DIR/patches/file-data.patch"
	autoconf

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/file/README"
	install -m 644 ChangeLog "$1/usr/share/doc/file/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/file/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/file/COPYING"
}
