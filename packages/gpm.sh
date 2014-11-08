PACKAGE_VERSION="1.20.7"
PACKAGE_SOURCES="http://www.nico.schottelius.org/software/gpm/archives/gpm-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A mouse server"

build() {
	[ -d gpm-$PACKAGE_VERSION ] && rm -rf gpm-$PACKAGE_VERSION
	tar -xjvf gpm-$PACKAGE_VERSION.tar.bz2
	cd gpm-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/gpm-musl.patch"
	patch -p 1 < "$BASE_DIR/patches/gpm-static.patch"
	patch -p 1 < "$BASE_DIR/patches/gpm-run.patch"
	patch -p 1 < "$BASE_DIR/patches/gpm-build.patch"

	./autogen.sh
	./configure --host=$HOST \
	            --prefix= \
	            --localstatedir=/run
	cd src
	$MAKE gpm
	cd ../doc
	$MAKE gpm.8
}

package() {
	install -D -m 755 ../src/gpm "$1/bin/gpm"
	install -D -m 755 gpm.8 "$1/usr/share/man/man8/gpm.8"
	install -D -m 644 ../README "$1/usr/share/doc/gpm/README"
	install -m 644 ../COPYING "$1/usr/share/doc/gpm/COPYING"
}
