PACKAGE_VERSION="5.4.4"
PACKAGE_SOURCES="http://rogue.rogueforge.net/files/rogue5.4/rogue$PACKAGE_VERSION-src.tar.gz"
PACKAGE_DESC="A dungeon crawling game"

build() {
	[ -d rogue$PACKAGE_VERSION ] && rm -rf rogue$PACKAGE_VERSION
	tar -xzvf rogue$PACKAGE_VERSION-src.tar.gz
	cd rogue$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --docdir=/usr/share/doc/rogue
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
}
