PACKAGE_VERSION="3.6"
PACKAGE_SOURCES="http://sourceforge.net/projects/xaos/files/XaoS/$PACKAGE_VERSION/xaos-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A fractal zoomer"

xaos_build() {
	[ -d xaos-$PACKAGE_VERSION ] && rm -rf xaos-$PACKAGE_VERSION
	tar -xzvf xaos-$PACKAGE_VERSION.tar.gz
	cd xaos-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-nls
	$MAKE
}

xaos_package() {
	$MAKE DESTDIR="$1" install
	mkdir -p "$1/usr/share/doc"
	ln -s ../XaoS/doc "$1/usr/share/doc/xaos"
}
