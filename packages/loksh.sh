PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/loksh/archive/master.zip,loksh-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A command-line shell"

loksh_build() {
	[ -d loksh-master ] && rm -rf loksh-master
	unzip loksh-$PACKAGE_VERSION.zip
	cd loksh-master

	$MAKE
}

loksh_package() {
	$MAKE DESTDIR="$1" BIN_DIR="/bin" install
	ln -s ksh "$1/bin/sh"
}
