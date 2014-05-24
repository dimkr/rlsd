PACKAGE_VERSION="2.17"
PACKAGE_SOURCES="http://landley.net/aboriginal/mirror/binutils-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="Assembly tools"

binutils_build() {
	[ -d binutils-$PACKAGE_VERSION ] && rm -rf binutils-$PACKAGE_VERSION
	tar -xjvf binutils-$PACKAGE_VERSION.tar.bz2
	cd binutils-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix=/usr \
	            --bindir=/bin \
	            --libdir=/lib \
	            --datadir=/usr/share \
	            --includedir=/usr/include \
	            --infodir=/usr/share/info \
	            --mandir=/usr/share/man
	$MAKE tooldir="/"
}

binutils_package() {
	$MAKE DESTDIR="$1" tooldir="/" install
	install -D -m 644 README "$1/usr/share/doc/binutils/README"
	install -m 644 COPYING "$1/usr/share/doc/binutils/COPYING"
	install -m 644 COPYING.LIB "$1/usr/share/doc/binutils/COPYING.LIB"
}
