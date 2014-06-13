PACKAGE_VERSION="1.3.6.pl01"
REAL_PACKAGE_VERSION="1.3.6"
PACKAGE_SOURCES="http://www.gnu.org/software/xorriso/xorriso-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="An ISO 9660 file system manipulation tool"

xorriso_build() {
	[ -d xorriso-$PACKAGE_VERSION ] && rm -rf xorriso-$PACKAGE_VERSION
	tar -xzvf xorriso-$PACKAGE_VERSION.tar.gz
	cd xorriso-$REAL_PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-debug
	$MAKE
}

xorriso_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/xorriso/README"
	install -m 644 ChangeLog "$1/usr/share/doc/xorriso/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/xorriso/AUTHORS"
	install -m 644 CONTRIBUTORS "$1/usr/share/doc/xorriso/CONTRIBUTORS"
	install -m 644 COPYRIGHT "$1/usr/share/doc/xorriso/COPYRIGHT"
	install -m 644 COPYING "$1/usr/share/doc/xorriso/COPYING"
	install -m 644 libburn/COPYRIGHT "$1/usr/share/doc/xorriso/COPYRIGHT.libburn"
	install -m 644 libisoburn/COPYRIGHT "$1/usr/share/doc/xorriso/COPYRIGHT.libisoburn"
	install -m 644 libisofs/COPYRIGHT "$1/usr/share/doc/xorriso/COPYRIGHT.libisofs"
	install -m 644 libjte/COPYRIGHT "$1/usr/share/doc/xorriso/COPYRIGHT.libjte"
}
