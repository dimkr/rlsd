PACKAGE_VERSION="0.9"
PACKAGE_SOURCES="https://github.com/freedoom/freedoom/releases/download/v$PACKAGE_VERSION/freedoom-$PACKAGE_VERSION.zip"
PACKAGE_DESC="Game content for the Doom engine"
PACKAGE_ARCH="all"

build() {
	[ -d freedoom-$PACKAGE_VERSION ] && rm -rf freedoom-$PACKAGE_VERSION
	unzip freedoom-$PACKAGE_VERSION.zip
	cd freedoom-$PACKAGE_VERSION
}

package() {
	install -D -m 644 freedoom1.wad "$1/usr/share/doom/freedoom1.wad"
	install -m 644 freedoom2.wad "$1/usr/share/doom/freedoom2.wad"
	ln -s freedoom1.wad "$1/usr/share/doom/doom.wad"
	install -D -m 644 README.html "$1/usr/share/doc/freedoom/README.html"
	install -m 644 CREDITS "$1/usr/share/doc/freedoom/CREDITS"
	install -m 644 COPYING "$1/usr/share/doc/freedoom/COPYING"
}
