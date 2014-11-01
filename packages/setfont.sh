PACKAGE_VERSION="2.0.2"
PACKAGE_SOURCES="http://www.kbd-project.org/download/kbd-$PACKAGE_VERSION.tar.xz"
PACKAGE_DESC="A utility for setting the console font"

build() {
	[ -d kbd-$PACKAGE_VERSION ] && rm -rf kbd-$PACKAGE_VERSION
	tar -xJvf kbd-$PACKAGE_VERSION.tar.xz
	cd kbd-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/setfont-musl.patch"
	patch -p 1 < "$BASE_DIR/patches/setfont-build.patch"
	autoconf

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-nls \
	            --disable-vlock
	cd src/libkeymap
	$MAKE
	cd ..
	$MAKE setfont
}

package() {
	install -D -m 755 setfont "$1/bin/setfont"
	install -D -m 644 ../docs/man/man8/setfont.8 "$1/usr/share/man/man8/setfont.8"
	install -D -m 644 ../README "$1/usr/share/doc/setfont/README"
	install -m 644 ../ChangeLog "$1/usr/share/doc/setfont/ChangeLog"
	install -m 644 ../NEWS "$1/usr/share/doc/setfont/NEWS"
	install -m 644 ../AUTHORS "$1/usr/share/doc/setfont/AUTHORS"
	install -m 644 ../CREDITS "$1/usr/share/doc/setfont/CREDITS"
	install -m 644 ../COPYING "$1/usr/share/doc/setfont/COPYING"
}
