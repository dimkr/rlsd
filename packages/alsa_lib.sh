PACKAGE_VERSION="1.0.27.2"
PACKAGE_SOURCES="ftp://ftp.alsa-project.org/pub/lib/alsa-lib-$PACKAGE_VERSION.tar.bz2"

alsa_lib_build() {
	[ -d alsa-lib-$PACKAGE_VERSION ] && rm -rf alsa-lib-$PACKAGE_VERSION
	tar -xjvf alsa-lib-$PACKAGE_VERSION.tar.bz2
	cd alsa-lib-$PACKAGE_VERSION

	sed s~'#endif'~'&\n#include <sys/types.h>'~ -i include/pcm.h

	# hacks from https://github.com/rofl0r/sabotage/blob/master/pkg/alsa-lib
	rm -f src/compat/hsearch_r.c
	touch src/compat/hsearch_r.c
	CFLAGS="-D_POSIX_C_SOURCE=200809L $CFLAGS" \
	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --includedir=/usr/include \
	            --disable-shared \
	            --enable-static \
	            --disable-old-symbols \
	            --disable-python \
	            --without-debug
	make
}

alsa_lib_package() {
	make DESTDIR="$1" install
	install -D -m 644 ChangeLog "$1/usr/share/doc/alsa-lib/ChangeLog"
	install -D -m 644 COPYING "$1/usr/share/doc/alsa-lib/COPYING"
}
