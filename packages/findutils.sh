PACKAGE_VERSION="4.4.2"
PACKAGE_SOURCES="http://ftp.gnu.org/pub/gnu/findutils/findutils-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="File search tools"

findutils_build() {
	[ -d findutils-$PACKAGE_VERSION ] && rm -rf findutils-$PACKAGE_VERSION
	tar -xzvf findutils-$PACKAGE_VERSION.tar.gz
	cd findutils-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/findutils-musl.patch"

	./configure --host=$HOST \
	            --prefix= \
	            --libexecdir=/lib/findutils \
	            --datarootdir=/usr/share \
	            --disable-nls
	$MAKE
}

findutils_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/findutils/README"
	install -m 644 NEWS "$1/usr/share/doc/findutils/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/findutils/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/findutils/AUTHORS"
	install -m 644 THANKS "$1/usr/share/doc/findutils/THANKS"
	install -m 644 COPYING "$1/usr/share/doc/findutils/COPYING"
}
