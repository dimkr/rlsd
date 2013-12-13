PACKAGE_VERSION="1.4.6"
PACKAGE_SOURCES="http://download.savannah.nongnu.org/releases/ratpoison/ratpoison-1.4.6.tar.xz"

ratpoison_build() {
	[ -d ratpoison-$PACKAGE_VERSION ] && rm -rf ratpoison-$PACKAGE_VERSION
	tar -xJvf ratpoison-$PACKAGE_VERSION.tar.xz
	cd ratpoison-$PACKAGE_VERSION

	patch -p1 < "$BASE_DIR/patches/ratpoison-quit.patch"
	patch -p1 < "$BASE_DIR/patches/ratpoison-font.patch"
	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --with-xterm=aterm
	$MAKE
}

ratpoison_package() {
	$MAKE DESTDIR="$1" install
}
