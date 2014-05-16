PACKAGE_VERSION="5.0.5"
PACKAGE_SOURCES="http://tukaani.org/xz/xz-$PACKAGE_VERSION.tar.xz"
PACKAGE_DESC="Compression tools"

xz_build() {
	[ -d xz-$PACKAGE_VERSION ] && rm -rf xz-$PACKAGE_VERSION
	tar -xJvf xz-$PACKAGE_VERSION.tar.xz
	cd xz-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --disable-xzdec \
	            --disable-lzmadec \
	            --disable-scripts \
	            --disable-nls
	$MAKE
}

xz_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/xz/README"
	install -m 644 ChangeLog "$1/usr/share/doc/xz/ChangeLog"
	install -m 644 NEWS "$1/usr/share/doc/xz/NEWS"
	install -m 644 THANKS "$1/usr/share/doc/xz/THANKS"
	install -m 644 AUTHORS "$1/usr/share/doc/xz/AUTHORS"
	install -m 644 COPYING.GPLv2 "$1/usr/share/doc/xz/COPYING.GPLv2"
	install -m 644 COPYING.GPLv3 "$1/usr/share/doc/xz/COPYING.GPLv3"
	install -m 644 COPYING.LGPLv2.1 "$1/usr/share/doc/xz/COPYING.LGPLv2.1"
	install -m 644 COPYING "$1/usr/share/doc/xz/COPYING"
}
