PACKAGE_VERSION="C1.001A"
PACKAGE_SOURCES="http://www.mipmip.org/chimaera/chimaera.tgz"
PACKAGE_DESC="An adventure game"

chimaera_build() {
	[ -d chimaera ] && rm -rf chimaera
	tar -xzvf chimaera.tgz
	cd chimaera

	patch -p 1 < "$BASE_DIR/patches/chimaera-getline.patch"

	$CC -o chimaera chimaera.c $CFLAGS $LDFLAGS -lm
}

chimaera_package() {
	install -D -m 755 chimaera "$1/bin/chimaera"
	install -D -m 644 README.txt "$1/usr/share/doc/chimaera/README.txt"
	install -m 644 chimaera.html "$1/usr/share/doc/chimaera/chimaera.html"
}
