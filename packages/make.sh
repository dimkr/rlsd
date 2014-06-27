PACKAGE_VERSION="4.0"
PACKAGE_SOURCES="ftp://ftp.gnu.org/gnu/make/make-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A program building tool"

make_build() {
	[ -d make-$PACKAGE_VERSION ] && rm -rf make-$PACKAGE_VERSION
	tar -xjvf make-$PACKAGE_VERSION.tar.bz2
	cd make-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            --disable-nls
	$MAKE
}

make_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/make/README"
	install -m 644 ChangeLog "$1/usr/share/doc/make/ChangeLog"
	install -m 644 NEWS "$1/usr/share/doc/make/NEWS"
	install -m 644 AUTHORS "$1/usr/share/doc/make/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/make/COPYING"
}
