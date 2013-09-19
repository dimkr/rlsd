PACKAGE_VERSION="1.12.1"
PACKAGE_SOURCES="http://mdocml.bsd.lv/snapshots/mdocml-$PACKAGE_VERSION.tar.gz"

mandoc_build() {
	[ -d mdocml-$PACKAGE_VERSION ] && rm -rf mdocml-$PACKAGE_VERSION
	tar -xzvf mdocml-$PACKAGE_VERSION.tar.gz
	cd mdocml-$PACKAGE_VERSION

	make CC="$CC" CFLAGS="-D__BEGIN_DECLS=\; -D__END_DECLS=\; -DVERSION=\'\"$PACKAGE_VERSION\"\' $CFLAGS" mandoc
}

mandoc_package() {
	install -D -m 755 mandoc "$1/bin/mandoc"
	install -D -m 644 mandoc.1 "$1/usr/share/man/man1/mandoc.1"
}
