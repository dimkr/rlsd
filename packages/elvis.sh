PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/mbert/elvis/archive/master.zip,elvis-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A text editor"

build() {
	[ -d elvis-master ] && rm -rf elvis-master
	unzip elvis-$PACKAGE_VERSION.zip
	cd elvis-master

	patch -p 1 < "$BASE_DIR/patches/elvis-build.patch"

	./configure --bindir="/bin" \
	            --datadir="/usr/share/elvis" \
	            --without-x \
	            --without-gnome \
	            --libs="-lncurses $LDFLAGS"
	$MAKE elvis
}

package() {
	install -D -m 755 elvis "$1/bin/elvis"
	ln -s elvis "$1/bin/vi"
	install -D -m 644 doc/elvis.man "$1/usr/share/man/man1/elvis.1"
	install -D -m 644 COPYING "$1/usr/share/doc/elvis/COPYING"
	install -m 644 doc/license.html "$1/usr/share/doc/elvis/license.html"
}
