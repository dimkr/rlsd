PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/visit1985/mdp/archive/master.zip,mdp-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A presentation tool"

build() {
	[ -d mdp-master ] && rm -rf mdp-master
	unzip mdp-$PACKAGE_VERSION.zip
	cd mdp-master

	patch -p 1 < "$BASE_DIR/patches/mdp-build.patch"

	$MAKE
}

package() {
	$MAKE DESTDIR="$1" PREFIX="" install
	install -D -m 644 README.md "$1/usr/share/doc/mdp/README.md"
	install -m 644 CREDITS "$1/usr/share/doc/mdp/CREDITS"
	install -m 644 AUTHORS "$1/usr/share/doc/mdp/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/mdp/COPYING"
}
