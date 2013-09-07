PACKAGE_VERSION="2.1.0"
PACKAGE_SOURCES="http://downloads.sourceforge.net/project/expat/expat/$PACKAGE_VERSION/expat-$PACKAGE_VERSION.tar.gz"

expat_build() {
	[ -d expat-$PACKAGE_VERSION ] && rm -rf expat-$PACKAGE_VERSION
	tar -xzvf expat-$PACKAGE_VERSION.tar.gz
	cd expat-$PACKAGE_VERSION
	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --includedir=/usr/include \
	            --disable-shared \
	            --enable-static
	make
}

expat_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/expat/README"
	install -D -m 644 Changes "$1/usr/share/doc/expat/Changes"
	install -D -m 644 COPYING "$1/usr/share/doc/expat/COPYING"
}
