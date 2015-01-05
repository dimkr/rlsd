PACKAGE_VERSION="1.87"
PACKAGE_SOURCES="http://www.lcdf.org/gifsicle/gifsicle-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A GIF image manipulation tool"

build() {
	[ -d gifsicle-$PACKAGE_VERSION ] && rm -rf gifsicle-$PACKAGE_VERSION
	tar -xzvf gifsicle-$PACKAGE_VERSION.tar.gz
	cd gifsicle-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            --disable-gifview \
	            --disable-gifdiff
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README.md "$1/usr/share/doc/gifsicle/README.md"
	install -m 644 NEWS "$1/usr/share/doc/gifsicle/NEWS"
	install -m 644 COPYING "$1/usr/share/doc/gifsicle/COPYING"
}
