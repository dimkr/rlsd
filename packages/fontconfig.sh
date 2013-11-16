PACKAGE_VERSION="2.11.0"
PACKAGE_SOURCES="http://www.freedesktop.org/software/fontconfig/release/fontconfig-$PACKAGE_VERSION.tar.bz2"

fontconfig_build() {
	[ -d fontconfig-$PACKAGE_VERSION ] && rm -rf fontconfig-$PACKAGE_VERSION
	tar -xjvf fontconfig-$PACKAGE_VERSION.tar.bz2
	cd fontconfig-$PACKAGE_VERSION

	./configure --build=x$HOST \
	            --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS
	make
}

fontconfig_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/fontconfig/README"
	install -m 644 ChangeLog "$1/usr/share/doc/fontconfig/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/fontconfig/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/fontconfig/COPYING"
}
