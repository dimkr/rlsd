PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/loksh/archive/master.zip,loksh-$PACKAGE_VERSION.zip"

loksh_build() {
	[ -d loksh-master ] && rm -rf loksh-master
	unzip loksh-$PACKAGE_VERSION.zip
	cd loksh-master

	$CC $CFLAGS -I. *.c -o loksh
}

loksh_package() {
	install -D -m 755 loksh "$1/bin/loksh"
	install -D -m 644 ksh.1 "$1/usr/share/man/man1/loksh.1"
	install -D -m 644 README "$1/usr/share/doc/loksh/README"
	install -m 644 README.upstream "$1/usr/share/doc/loksh/README.upstream"
	install -m 644 ChangeLog "$1/usr/share/doc/loksh/ChangeLog"
	install -m 644 ChangeLog.0 "$1/usr/share/doc/loksh/ChangeLog.0"
	install -m 644 CONTRIBUTORS "$1/usr/share/doc/loksh/CONTRIBUTORS"
	install -m 644 LEGAL "$1/usr/share/doc/loksh/LEGAL"
}
