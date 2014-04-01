PACKAGE_VERSION="1.8.9"
PACKAGE_SOURCES="http://xchat.org/files/source/1.8/xchat-$PACKAGE_VERSION.tar.bz2"

xchat_build() {
	[ -d xchat-$PACKAGE_VERSION ] && rm -rf xchat-$PACKAGE_VERSION
	tar -xjvf xchat-$PACKAGE_VERSION.tar.bz2
	cd xchat-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/xchat-root.patch"
	patch -p 1 < "$BASE_DIR/patches/xchat-font.patch"
	./configure --host=$HOST \
	            --prefix= \
	            --datadir=/usr/share \
	            --disable-nls \
	            --enable-ipv6 \
	            --disable-textfe \
	            --disable-perl \
	            --disable-plugin
	$MAKE
}

xchat_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/xchat/README"
	install -m 644 FAQ "$1/usr/share/doc/xchat/FAQ"
	install -m 644 AUTHORS "$1/usr/share/doc/xchat/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/xchat/COPYING"
}
