PACKAGE_VERSION="0.6"
PACKAGE_SOURCES="http://raffi.at/code/aop/aop-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="An arcade game"

build() {
	[ -d aop-$PACKAGE_VERSION ] && rm -rf aop-$PACKAGE_VERSION
	tar -xzvf aop-$PACKAGE_VERSION.tar.gz
	cd aop-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/aop-share.patch"
	patch -p 1 < "$BASE_DIR/patches/aop-insult.patch"

	$CC -o aop aop.c $CFLAGS $LDFLAGS -lncurses
}

package() {
	install -D -m 755 aop "$1/bin/aop"
	for i in *.txt
	do
		install -D -m 644 "$i" "$1/usr/share/aop/$i"
	done
	install -D -m 644 README "$1/usr/share/doc/aop/README"
	install -m 644 COPYING "$1/usr/share/doc/aop/COPYING"
}
