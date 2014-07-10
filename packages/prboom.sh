PACKAGE_VERSION="2.5.0"
PACKAGE_SOURCES="http://sourceforge.net/projects/prboom/files/prboom%20stable/2.5.0/prboom-2.5.0.tar.gz"
PACKAGE_DESC="A first-person shooter"

prboom_build() {
	[ -d prboom-$PACKAGE_VERSION ] && rm -rf prboom-$PACKAGE_VERSION
	tar -xzvf prboom-$PACKAGE_VERSION.tar.gz
	cd prboom-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/prboom-build.patch"

	LIBS="-lasound $(pkg-config --libs SDL_mixer)" \
	./configure --host=$HOST \
	            --prefix=/usr \
	            --bindir=/bin \
	            --datarootdir=/usr/share \
	            --disable-debug \
	            --disable-gl \
	            --with-waddir=/usr/share/doom
	$MAKE
}

prboom_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/prboom/README"
	install -m 644 NEWS "$1/usr/share/doc/prboom/NEWS"
	install -m 644 AUTHORS "$1/usr/share/doc/prboom/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/prboom/COPYING"
}
