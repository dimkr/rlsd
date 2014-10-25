PACKAGE_VERSION="3.6"
PACKAGE_SOURCES="http://sourceforge.net/projects/xaos/files/XaoS/$PACKAGE_VERSION/xaos-$PACKAGE_VERSION.tar.gz https://projects.archlinux.org/svntogit/packages.git/plain/trunk/xaos-3.5-build-fix-i686.patch?h=packages/xaos,xaos-3.5-build-fix-i686.patch"
PACKAGE_DESC="A fractal zoomer"

build() {
	[ -d xaos-$PACKAGE_VERSION ] && rm -rf xaos-$PACKAGE_VERSION
	tar -xzvf xaos-$PACKAGE_VERSION.tar.gz
	cd xaos-$PACKAGE_VERSION

	case "$ARCH" in
		i?86)
			patch -p 1 < ../xaos-3.5-build-fix-i686.patch
			;;
	esac

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-nls \
	            --without-sffe
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	mkdir -p "$1/usr/share/doc"
	ln -s ../XaoS/doc "$1/usr/share/doc/xaos"
}
