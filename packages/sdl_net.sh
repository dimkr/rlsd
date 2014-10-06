PACKAGE_VERSION="1.2.8"
PACKAGE_SOURCES="http://www.libsdl.org/projects/SDL_net/release/SDL_net-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A network API"

sdl_net_build() {
	[ -d SDL_net-$PACKAGE_VERSION ] && rm -rf SDL_net-$PACKAGE_VERSION
	tar -xzvf SDL_net-$PACKAGE_VERSION.tar.gz
	cd SDL_net-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --disable-gui
	$MAKE
}

sdl_net_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/sdl_net/README"
	install -m 644 CHANGES "$1/usr/share/doc/sdl_net/CHANGES"
	install -m 644 COPYING "$1/usr/share/doc/sdl_net/COPYING"
}
