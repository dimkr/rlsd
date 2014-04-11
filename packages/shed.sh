PACKAGE_VERSION="1.15"
PACKAGE_SOURCES="http://sourceforge.net/projects/shed/files/shed/shed%201.15/shed-$PACKAGE_VERSION.tar.gz"

shed_build() {
	[ -d shed-$PACKAGE_VERSION ] && rm -rf shed-$PACKAGE_VERSION
	tar -xzvf shed-$PACKAGE_VERSION.tar.gz
	cd shed-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share
	$MAKE
}

shed_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/shed/README"
	install -m 644 ChangeLog "$1/usr/share/doc/shed/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/shed/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/shed/COPYING"
}
