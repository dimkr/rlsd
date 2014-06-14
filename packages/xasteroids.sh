PACKAGE_VERSION="5"
PACKAGE_SOURCES="http://www.ibiblio.org/pub/Linux/games/arcade/asteroids/xasteroids.tgz https://aur.archlinux.org/packages/xa/xasteroids/xasteroids.tar.gz,xasteroids-arch.tar.gz"
PACKAGE_DESC="An Asteroids clone"

xasteroids_build() {
	[ -d xasteroids ] && rm -rf xasteroids
	tar -xzvf xasteroids.tgz
	cd xasteroids
	tar -xzvf ../xasteroids-arch.tar.gz

	patch -p 1 < xasteroids/01_legacy.patch
	patch -p 0 < xasteroids/02_xast.patch
	patch -p 1 < "$BASE_DIR/patches/xasteroids-build.patch"

	$MAKE
}

xasteroids_package() {
	install -D -m 755 xast "$1/bin/xaos"
	install -D -m 644 xast.man "$1/usr/share/man/man6/xast.6"
	install -D -m 644 README "$1/usr/share/doc/xasteroids/README"
	install -m 644 xasteroids/COPYING "$1/usr/share/doc/xasteroids/COPYING"
}
