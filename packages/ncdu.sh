PACKAGE_VERSION="1.10"
PACKAGE_SOURCES="http://dev.yorhel.nl/download/ncdu-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A disk usage analyzer"

ncdu_build() {
	[ -d ncdu-$PACKAGE_VERSION ] && rm -rf ncdu-$PACKAGE_VERSION
	tar -xzvf ncdu-$PACKAGE_VERSION.tar.gz
	cd ncdu-$PACKAGE_VERSION
	./configure --host=$HOST --prefix= --datarootdir=/usr/share --with-ncurses
	$MAKE
}

ncdu_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/ncdu/README"
	install -D -m 644 ChangeLog "$1/usr/share/doc/ncdu/ChangeLog"
	install -D -m 644 COPYING "$1/usr/share/doc/ncdu/COPYING"
}
