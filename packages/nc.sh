PACKAGE_VERSION="110"
PACKAGE_SOURCES="http://downloads.sourceforge.net/project/nc110/unix%20netcat%201.10%20by%20_Hobbit_/%5BUnnamed%20release%5D/nc$PACKAGE_VERSION.tgz"
PACKAGE_DESC="A generic TCP client or server"

build() {
	[ -d nc-$PACKAGE_VERSION ] && rm -rf nc-$PACKAGE_VERSION
	mkdir nc-$PACKAGE_VERSION
	cd nc-$PACKAGE_VERSION
	tar -xzvf ../nc$PACKAGE_VERSION.tgz

	patch -p 1 < "$BASE_DIR/patches/nc-build.patch"
	$MAKE linux LD="$CC"
}

package() {
	install -D -m 755 nc "$1/bin/nc"
	install -D -m 644 README "$1/usr/share/doc/nc/README"
	install -m 644 Changelog "$1/usr/share/doc/nc/Changelog"
}
