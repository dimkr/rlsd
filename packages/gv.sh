PACKAGE_VERSION="3.7.4"
PACKAGE_SOURCES="http://ftp.gnu.org/gnu/gv/gv-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A viewer for PostScript and PDF documents"

build() {
	[ -d gv-$PACKAGE_VERSION ] && rm -rf gv-$PACKAGE_VERSION
	tar -xzvf gv-$PACKAGE_VERSION.tar.gz
	cd gv-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --enable-SIGCHLD-fallback
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/gv/README"
	install -m 644 ChangeLog "$1/usr/share/doc/gv/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/gv/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/gv/COPYING"
}
