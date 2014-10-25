PACKAGE_VERSION="2.2.5"
PACKAGE_SOURCES="ftp://ftp.figlet.org/pub/figlet/program/unix/figlet-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A text banner generator"

build() {
	[ -d figlet-$PACKAGE_VERSION ] && rm -rf figlet-$PACKAGE_VERSION
	tar -xzvf figlet-$PACKAGE_VERSION.tar.gz
	cd figlet-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/figlet-build.patch"

	LD="$CC" CFLAGS="-D__BEGIN_DECLS=\; -D__END_DECLS=\; $CFLAGS" $MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/figlet/README"
	install -m 644 CHANGES "$1/usr/share/doc/figlet/CHANGES"
	install -m 644 LICENSE "$1/usr/share/doc/figlet/LICENSE"
}
