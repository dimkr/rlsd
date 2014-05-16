PACKAGE_VERSION="1.2.15"
PACKAGE_SOURCES="http://libsdl.org/release/SDL-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A graphics and audio abstraction layer library"

sdl_build() {
	[ -d SDL-$PACKAGE_VERSION ] && rm -rf SDL-$PACKAGE_VERSION
	tar -xzvf SDL-$PACKAGE_VERSION.tar.gz
	cd SDL-$PACKAGE_VERSION

	CFLAGS="-D_POSIX_SOURCE $CFLAGS" \
	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --disable-loadso \
	            --disable-oss \
	            --enable-alsa \
	            --disable-dummyaudio \
	            --enable-video-x11 \
	            --disable-video-dummy \
	            --enable-video-fbcon \
	            --disable-sdl-dlopen
	$MAKE
}

sdl_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/SDL/README"
	install -m 644 README-SDL.txt "$1/usr/share/doc/SDL/README-SDL.txt"
	install -m 644 CREDITS "$1/usr/share/doc/SDL/CREDITS"
	install -m 644 COPYING "$1/usr/share/doc/SDL/COPYING"
}
