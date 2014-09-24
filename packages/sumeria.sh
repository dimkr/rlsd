PACKAGE_VERSION="1"
PACKAGE_SOURCES="http://www.mipmip.org/C_games/sumeria.c"
PACKAGE_DESC="A strategy game"

sumeria_build() {
	$CC -o sumeria sumeria.c $CFLAGS $LDFLAGS -lm
}

sumeria_package() {
	install -D -m 755 sumeria "$1/bin/sumeria"
	install -d -D -m 755 "$1/usr/share/doc/sumeria"
	head -n 4 sumeria.c  | cut -c 7- > "$1/usr/share/doc/sumeria/README"
	chmod 644 "$1/usr/share/doc/sumeria/README"
}
