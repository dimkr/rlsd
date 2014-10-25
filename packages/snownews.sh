PACKAGE_VERSION="1.5.12"
PACKAGE_SOURCES="https://kiza.eu/media/software/snownews/snownews-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A news reader"

build() {
	[ -d snownews-$PACKAGE_VERSION ] && rm -rf snownews-$PACKAGE_VERSION
	tar -xzvf snownews-$PACKAGE_VERSION.tar.gz
	cd snownews-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/snownews-build.patch"
	./configure --prefix= --disable-nls
	EXTRA_CFLAGS="$CFLAGS" \
	EXTRA_LDFLAGS="$LDFLAGS" \
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/snownews/README"
	install -m 644 Changelog "$1/usr/share/doc/snownews/Changelog"
	install -m 644 AUTHOR "$1/usr/share/doc/snownews/AUTHOR"
	install -m 644 CREDITS "$1/usr/share/doc/snownews/CREDITS"
	install -m 644 COPYING "$1/usr/share/doc/snownews/COPYING"
}
