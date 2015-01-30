PACKAGE_VERSION="1.11"
PACKAGE_SOURCES="http://www.fial.com/~scott/tamsyn-font/download/tamsyn-font-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A monospace, programming font"
PACKAGE_ARCH="all"

build() {
	[ -d tamsyn-font-$PACKAGE_VERSION ] && rm -rf tamsyn-font-$PACKAGE_VERSION
	tar -xzvf tamsyn-font-$PACKAGE_VERSION.tar.gz
	cd tamsyn-font-$PACKAGE_VERSION

	gunzip *.gz
}

package() {
	for i in *.psf
	do
		install -D -m 644 $i "$1/usr/share/consolefonts/$i"
	done
	install -D -m 644 README "$1/usr/share/doc/tamsyn-font/README"
	install -m 644 LICENSE "$1/usr/share/doc/tamsyn-font/LICENSE"
}
