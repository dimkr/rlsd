PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/packdude/archive/master.zip,packdude-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A package manager"

packdude_build() {
	[ -d packdude-master ] && rm -rf packdude-master
	unzip packdude-$PACKAGE_VERSION.zip
	cd packdude-master

	$MAKE
}

packdude_package() {
	$MAKE DESTDIR="$1" install
}
