PACKAGE_VERSION="1.0"
PACKAGE_SOURCES="http://downloads.sourceforge.net/project/gtkedit1/gtkedit1/$PACKAGE_VERSION/gtkedit-$PACKAGE_VERSION-src.tar.gz"
PACKAGE_DESC="A text editor"

build() {
	[ -d gtkedit-$PACKAGE_VERSION ] && rm -rf gtkedit-$PACKAGE_VERSION
	tar -xzvf gtkedit-$PACKAGE_VERSION-src.tar.gz
	cd gtkedit-$PACKAGE_VERSION-src

	$CC $CFLAGS $(gtk-config --cflags) \
	    gtkedit.c \
	    $LDFLAGS $(gtk-config --libs) \
	    -o gtkedit
}

package() {
	install -D -m 755 gtkedit "$1/bin/gtkedit"
	install -D -m 644 readme.html "$1/usr/share/doc/gtkedit/readme.html"
	install -m 644 LICENSE.txt "$1/usr/share/doc/gtkedit/LICENSE.txt"
}
