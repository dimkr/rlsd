PACKAGE_VERSION="0.8"
PACKAGE_SOURCES="https://github.com/freedoom/freedoom/releases/download/v$PACKAGE_VERSION/freedoom-ultimate-v$PACKAGE_VERSION.zip"
PACKAGE_DESC="Game content for the Doom engine"
PACKAGE_ARCH="all"

freedoom_build() {
	[ -d freedoom-ultimate-v$PACKAGE_VERSION ] && rm -rf freedoom-ultimate-v$PACKAGE_VERSION
	unzip freedoom-ultimate-v$PACKAGE_VERSION.zip
	cd freedoom-ultimate-v$PACKAGE_VERSION

}

freedoom_package() {
	install -D -m 644 doom.wad "$1/usr/share/doom/doom.wad"
	install -D -m 644 README.html "$1/usr/share/doc/freedoom/README.html"
	install -m 644 CREDITS "$1/usr/share/doc/freedoom/CREDITS"
	install -m 644 COPYING "$1/usr/share/doc/freedoom/COPYING"
}
