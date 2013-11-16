PACKAGE_VERSION="2.1.0"
PACKAGE_SOURCES="http://sourceforge.net/projects/expat/files/expat/$PACKAGE_VERSION/expat-$PACKAGE_VERSION.tar.gz"

expat_build() {
	[ -d expat-$PACKAGE_VERSION ] && rm -rf expat-$PACKAGE_VERSION
	tar -xzvf expat-$PACKAGE_VERSION.tar.gz
	cd expat-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS
	make
}

expat_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/expat/README"
	install -m 644 Changes "$1/usr/share/doc/expat/Changes"
	install -m 644 COPYING "$1/usr/share/doc/expat/COPYING"
}
