PACKAGE_VERSION="3.8.8"
PACKAGE_REAL_VERSION="3080800"
PACKAGE_SOURCES="http://www.sqlite.org/2015/sqlite-autoconf-$PACKAGE_REAL_VERSION.tar.gz https://projects.archlinux.org/svntogit/packages.git/plain/trunk/license.txt?h=packages/sqlite,license.txt"
PACKAGE_DESC="An embedded database"

build() {
	[ -d sqlite-autoconf-$PACKAGE_REAL_VERSION ] && rm -rf sqlite-autoconf-$PACKAGE_REAL_VERSION
	tar -xzvf sqlite-autoconf-$PACKAGE_REAL_VERSION.tar.gz
	cd sqlite-autoconf-$PACKAGE_REAL_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --disable-dynamic-extensions
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/sqlite/README"
	install -m 644 ../license.txt "$1/usr/share/doc/sqlite/license.txt"
}

