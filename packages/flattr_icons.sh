PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/NitruxSA/flattr-icons/archive/master.zip,flattr-icons-$PACKAGE_VERSION.zip"

flattr_icons_build() {
	[ -d flattr-icons-master ] && rm -rf flattr-icons-master
	unzip flattr-icons-$PACKAGE_VERSION.zip
	cd flattr-icons-master

	for i in */*/*.svg
	do
		rsvg-convert -h 48 -w 48 "$i" -o "$(echo "$i" | sed s/svg\$/png/)"
	done
}

flattr_icons_package() {
	for i in */*/*.png
	do
		install -D -m 644 "$i" "$1/usr/share/pixmaps/$(basename "$i")"
	done
	install -D -m 644 CONTRIBUTORS "$1/usr/share/doc/flattr-icons/CONTRIBUTORS"
	install -m 644 CREDITS "$1/usr/share/doc/flattr-icons/CREDITS"
	install -m 644 COPYING "$1/usr/share/doc/flattr-icons/COPYING"
	install -m 644 LICENSE.txt "$1/usr/share/doc/flattr-icons/LICENSE.txt"
}
