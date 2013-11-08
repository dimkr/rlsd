PACKAGE_VERSION="master"
PACKAGE_SOURCES="https://github.com/iguleder/tinyxlib/archive/master.zip,tinyxlib-master.zip"

tinyxlib_build() {
	[ -d tinyxlib-master ] && rm -rf tinyxlib-master
	unzip tinyxlib-master
	cd tinyxlib-master

	make clean
	make CC="$CC" \
	     EXTRA_CFLAGS="$CFLAGS" \
	     LDFLAGS="$LDFLAGS" \
	     LIBDIR="/lib" \
	     PREDIR="/" \
	     INCDIR="/usr/include"
}

tinyxlib_package() {
	mkdir -p "$1/lib" "$1/usr/include"
	make LIBDIR="$1/lib" PREDIR="$1" INCDIR="$1/usr/include" install
	install -D -m 644 README "$1/usr/share/doc/tinyxlib/README"
	install -m 644 libXau/README "$1/usr/share/doc/tinyxlib/README.libXau"
	install -m 644 libXmu/README "$1/usr/share/doc/tinyxlib/README.libXmu"
	install -m 644 changelog "$1/usr/share/doc/tinyxlib/changelog"
}