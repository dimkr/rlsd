PACKAGE_VERSION="1.3.1"
PACKAGE_SOURCES="http://sourceforge.net/projects/libjpeg-turbo/files/$PACKAGE_VERSION/libjpeg-turbo-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A library for handling JPEG images"

libjpeg_turbo_build() {
	[ -d libjpeg-turbo-$PACKAGE_VERSION ] && rm -rf libjpeg-turbo-$PACKAGE_VERSION
	tar -xzvf libjpeg-turbo-$PACKAGE_VERSION.tar.gz
	cd libjpeg-turbo-$PACKAGE_VERSION

	sed -e s~'docdir = $(datadir)/doc'~'docdir = $(datadir)/doc/libjpeg-turbo'~ \
	    -e s~'exampledir = $(datadir)/doc'~'exampledir = $(docdir)/examples'~ \
	    -i Makefile.in
	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datadir=/usr/share \
	            --mandir=/usr/share/man \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --without-jpeg7 \
	            --without-jpeg8 \
	            --without-turbojpeg
	$MAKE
}

libjpeg_turbo_package() {
	$MAKE DESTDIR="$1" install
}
