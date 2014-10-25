PACKAGE_VERSION="3.4.3"
PACKAGE_VERSION_NO_DOTS="$(echo $PACKAGE_VERSION | sed s/\\.//g)"
PACKAGE_SOURCES="http://sourceforge.net/projects/nethack/files/nethack/$PACKAGE_VERSION/nethack-$PACKAGE_VERSION_NO_DOTS-src.tgz"
PACKAGE_DESC="A dungeon crawling game"

build() {
	[ -d nethack-$PACKAGE_VERSION ] && rm -rf nethack-$PACKAGE_VERSION
	tar -xzvf nethack-$PACKAGE_VERSION_NO_DOTS-src.tgz
	cd nethack-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/nethack-build.patch"
	patch -p 1 < "$BASE_DIR/patches/nethack-empty_files.patch"

	sh sys/unix/setup.sh x
	$MAKE
}

package() {
	$MAKE PREFIX="$1" install
	cd doc
	mkdir -p "$1/usr/share/man/man6"
	$MAKE PREFIX="$1" manpages

	# move executables to /lib/nethack
	mkdir -p "$1/lib/nethack"
	mv "$1/var/games/nethack/nethack" "$1/lib/nethack/"
	mv "$1/var/games/nethack/recover" "$1/lib/nethack/"
	sed -e s~"$1"~~ \
	    -e s~'HACK=$HACKDIR/nethack'~'HACK=/lib/nethack/nethack'~ \
	    -i "$1/bin/nethack"

	install -D -m 644 Guidebook.txt "$1/usr/share/doc/nethack/Guidebook.txt"
	ln -s ../../../../var/games/nethack/license \
	      "$1/usr/share/doc/nethack/license"
}
