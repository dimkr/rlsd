PACKAGE_VERSION="1.13.2"
PACKAGE_SOURCES="http://mdocml.bsd.lv/snapshots/mdocml-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A man page formatting tool"

build() {
	[ -d mdocml-$PACKAGE_VERSION ] && rm -rf mdocml-$PACKAGE_VERSION
	tar -xzvf mdocml-$PACKAGE_VERSION.tar.gz
	cd mdocml-$PACKAGE_VERSION

	./configure
	$MAKE CC="$CC" CFLAGS="$CFLAGS"
}

package() {
	install -D -m 755 mandoc "$1/bin/mandoc"
	install -D -m 644 mandoc.1 "$1/usr/share/man/man1/mandoc.1"
	install -D -m 644 NEWS "$1/usr/share/doc/mandoc/NEWS"
	install -m 644 LICENSE "$1/usr/share/doc/mandoc/LICENSE"
}
