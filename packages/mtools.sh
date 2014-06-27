PACKAGE_VERSION="4.0.18"
PACKAGE_SOURCES="ftp://ftp.gnu.org/gnu/mtools/mtools-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="Tools for FAT file systems access"

mtools_build() {
	[ -d mtools-$PACKAGE_VERSION ] && rm -rf mtools-$PACKAGE_VERSION
	tar -xjvf mtools-$PACKAGE_VERSION.tar.bz2
	cd mtools-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-floppyd
	$MAKE
}

mtools_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/mtools/README"
	install -m 644 LICENSE "$1/usr/share/doc/mtools/LICENSE"
}
