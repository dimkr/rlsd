PACKAGE_VERSION="2.2.6"
PACKAGE_SOURCES="http://www.nano-editor.org/dist/v2.2/nano-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A text editor"

build() {
	[ -d nano-$PACKAGE_VERSION ] && rm -rf nano-$PACKAGE_VERSION
	tar -xzvf nano-$PACKAGE_VERSION.tar.gz
	cd nano-$PACKAGE_VERSION
	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-nls \
	            --disable-utf8 \
	            --without-slang
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/nano/README"
	install -D -m 644 NEWS "$1/usr/share/doc/nano/NEWS"
	install -D -m 644 AUTHORS "$1/usr/share/doc/nano/AUTHORS"
	install -D -m 644 THANKS "$1/usr/share/doc/nano/THANKS"
	install -D -m 644 COPYING "$1/usr/share/doc/nano/COPYING"
}
