PACKAGE_VERSION="1.2.12"
PACKAGE_SOURCES="http://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="An audio mixer library"

build() {
	[ -d SDL_mixer-$PACKAGE_VERSION ] && rm -rf SDL_mixer-$PACKAGE_VERSION
	tar -xzvf SDL_mixer-$PACKAGE_VERSION.tar.gz
	cd SDL_mixer-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --disable-music-mod-shared \
	            --disable-music-fluidsynth-shared \
	            --disable-music-ogg-shared \
	            --disable-music-flac-shared \
	            --disable-music-mp3-shared
	$MAKE
}

package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/sdl_mixer/README"
	install -D -m 644 CHANGES $"$1/usr/share/doc/sdl_mixer/CHANGES"
	install -m 644 COPYING "$1/usr/share/doc/sdl_mixer/COPYING"
}
