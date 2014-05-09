PACKAGE_VERSION="2.2.2"
PACKAGE_SOURCES="http://joewing.net/projects/jwm/releases/jwm-$PACKAGE_VERSION.tar.xz"

jwm_build() {
	[ -d jwm-$PACKAGE_VERSION ] && rm -rf jwm-$PACKAGE_VERSION
	tar -xJvf jwm-$PACKAGE_VERSION.tar.xz
	cd jwm-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/jwm-config.patch"

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-jpeg \
	            --disable-xrender \
	            --disable-shape \
	            --disable-xmu \
	            --disable-nls
	$MAKE
}

jwm_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README.md "$1/usr/share/doc/jwm/README.md"
	install -m 644 ChangeLog "$1/usr/share/doc/jwm/ChangeLog"
	install -m 644 LICENSE "$1/usr/share/doc/jwm/LICENSE"
}
