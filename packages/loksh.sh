PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/dimkr/loksh/archive/master.zip,loksh-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A command-line shell"

loksh_build() {
	[ -d loksh-master ] && rm -rf loksh-master
	unzip loksh-$PACKAGE_VERSION.zip
	cd loksh-master

	patch -p 1 < "$BASE_DIR/patches/loksh-packdude.patch"
	patch -p 1 < "$BASE_DIR/patches/loksh-boss.patch"
	patch -p 1 < "$BASE_DIR/patches/loksh-build.patch"

	$MAKE
}

loksh_package() {
	$MAKE DESTDIR="$1" BIN_DIR="/bin" install
	ln -s ksh "$1/bin/sh"
}
