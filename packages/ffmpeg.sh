PACKAGE_VERSION="2.2.7"
PACKAGE_SOURCES="http://www.ffmpeg.org/releases/ffmpeg-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A complete multimedia solution"

ffmpeg_build() {
	[ -d ffmpeg-$PACKAGE_VERSION ] && rm -rf ffmpeg-$PACKAGE_VERSION
	tar -xjvf ffmpeg-$PACKAGE_VERSION.tar.bz2
	cd ffmpeg-$PACKAGE_VERSION

	./configure --prefix=/usr \
	            --bindir=/bin \
	            --libdir=/lib \
	            --shlibdir=/lib \
	            --enable-gpl \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --enable-small \
	            --disable-ffserver \
	            --enable-postproc \
	            --disable-network \
	            --cc="$CC" \
	            --ld="$CC" \
	            --cpu="$ARCH" \
	            --extra-cflags="$CFLAGS" \
	            --extra-ldflags="$LDFLAGS" \
	            --disable-debug
	$MAKE
}

ffmpeg_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/ffmpeg/README"
	install -m 644 LICENSE "$1/usr/share/doc/ffmpeg/LICENSE"
	install -m 644 COPYING.GPLv2 "$1/usr/share/doc/ffmpeg/COPYING.GPLv2"
	install -m 644 COPYING.GPLv3 "$1/usr/share/doc/ffmpeg/COPYING.GPLv3"
	install -m 644 COPYING.LGPLv2.1 "$1/usr/share/doc/ffmpeg/COPYING.LGPLv2.1"
	install -m 644 COPYING.LGPLv3 "$1/usr/share/doc/ffmpeg/COPYING.LGPLv3"
	install -m 644 Changelog "$1/usr/share/doc/ffmpeg/Changelog"
	install -m 644 CREDITS "$1/usr/share/doc/ffmpeg/CREDITS"
	install -m 644 MAINTAINERS "$1/usr/share/doc/ffmpeg/MAINTAINERS"
}
