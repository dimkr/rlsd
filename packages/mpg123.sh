PACKAGE_VERSION="1.21.0"
PACKAGE_SOURCES="http://downloads.sourceforge.net/project/mpg123/mpg123/$PACKAGE_VERSION/mpg123-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A MP3 player"

mpg123_build() {
	[ -d mpg123-$PACKAGE_VERSION ] && rm -rf mpg123-$PACKAGE_VERSION
	tar -xjvf mpg123-$PACKAGE_VERSION.tar.bz2
	cd mpg123-$PACKAGE_VERSION

	CFLAGS="$CFLAGS -D_POSIX_SOURCE -D_GNU_SOURCE" \
	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --enable-debug=no \
	            --enable-gapless=no \
	            --enable-ipv6=yes \
	            --enable-network=yes \
	            --with-audio=tinyalsa \
	            --with-default-audio=tinyalsa \
	            --with-optimization=0
	$MAKE
}

mpg123_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/mpg123/README"
	install -D -m 644 ChangeLog "$1/usr/share/doc/mpg123/ChangeLog"
	install -D -m 644 NEWS "$1/usr/share/doc/mpg123/NEWS"
	install -D -m 644 NEWS.libmpg123 "$1/usr/share/doc/mpg123/NEWS.libmpg123"
	install -D -m 644 AUTHORS "$1/usr/share/doc/mpg123/AUTHORS"
	install -D -m 644 COPYING "$1/usr/share/doc/mpg123/COPYING"
}
