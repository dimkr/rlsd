PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/dimkr/lok/archive/master.zip,lok-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A text processing tool"

build() {
	[ -d lok-master ] && rm -rf lok-master
	unzip lok-$PACKAGE_VERSION.zip
	cd lok-master

	$MAKE
}

package() {
	$MAKE DESTDIR="$1" PREFIX="" MANDIR="/usr/share/man" install
	install -D -m 644 README "$1/usr/share/doc/lok/README"
	install -m 644 README.upstream "$1/usr/share/doc/lok/README.upstream"
}
