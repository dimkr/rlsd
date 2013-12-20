PACKAGE_VERSION="0.2"
PACKAGE_SOURCES="http://ordiluc.net/gtklepin/gtklepin-$PACKAGE_VERSION.tar.bz2"

gtklepin_build() {
	[ -d gtklepin-$PACKAGE_VERSION ] && rm -rf gtklepin-$PACKAGE_VERSION
	tar -xjvf gtklepin-$PACKAGE_VERSION.tar.bz2
	cd gtklepin-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/gtklepin-getline.patch"
	./configure --host=$HOST \
	            --prefix=/usr \
	            --bindir=/bin \
	            --mandir=/usr/share/man \
	            --disable-nls
	$MAKE
}

gtklepin_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/gtklepin/README"
	install -m 644 AUTHORS "$1/usr/share/doc/gtklepin/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/gtklepin/COPYING"
}