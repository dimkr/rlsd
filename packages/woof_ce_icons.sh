PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/puppylinux-woof-CE/woof-CE/archive/testing.zip,woof-CE-$PACKAGE_VERSION.zip"

woof_ce_icons_build() {
	[ -d woof-CE-testing ] && rm -rf woof-CE-testing
	unzip woof-CE-$PACKAGE_VERSION.zip
	cd woof-CE-testing

	cd woof-code/rootfs-skeleton/usr/share/pixmaps/puppy
	for i in *.svg
	do
		rsvg-convert -h 48 -w 48 "$i" -o "$(echo "$i" | sed s/svg\$/png/)"
	done
}

woof_ce_icons_package() {
	for i in *.png
	do
		install -D -m 644 "$i" "$1/usr/share/pixmaps/$i"
	done
	install -D -m 644 ../../../../../../LICENSE "$1/usr/share/doc/woof-CE/LICENSE"
}
