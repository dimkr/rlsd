PACKAGE_VERSION="1.3.15"
PACKAGE_SOURCES="http://sourceforge.net/projects/calcoo/files/calcoo/$PACKAGE_VERSION/calcoo-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A calculator"

build() {
	[ -d calcoo-$PACKAGE_VERSION ] && rm -rf calcoo-$PACKAGE_VERSION
	tar -xzvf calcoo-$PACKAGE_VERSION.tar.gz
	cd calcoo-$PACKAGE_VERSION

	./configure --host=$HOST --prefix= --mandir=/usr/share/man
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/calcoo/README"
	install -m 644 ChangeLog "$1/usr/share/doc/calcoo/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/calcoo/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/calcoo/COPYING"
}
