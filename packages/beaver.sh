PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/dimkr/beaver/archive/master.zip,beaver-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A text editor"

build() {
	[ -d beaver-master ] && rm -rf beaver-master
	unzip beaver-$PACKAGE_VERSION.zip
	cd beaver-master

	patch -p 1 < "$BASE_DIR/patches/beaver-build.patch"

	cd src
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 ../README "$1/usr/share/doc/beaver/README"
	install -m 644 ../NEWS "$1/usr/share/doc/beaver/NEWS"
	install -m 644 ../ChangeLog "$1/usr/share/doc/beaver/ChangeLog"
	install -m 644 ../AUTHORS "$1/usr/share/doc/beaver/AUTHORS"
	install -m 644 ../THANKS "$1/usr/share/doc/beaver/THANKS"
	install -m 644 ../COPYING "$1/usr/share/doc/beaver/COPYING"
}
