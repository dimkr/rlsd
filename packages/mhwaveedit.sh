PACKAGE_VERSION="1.4.23"
PACKAGE_SOURCES="http://download.gna.org/mhwaveedit/mhwaveedit-$PACKAGE_VERSION.tar.bz2"

mhwaveedit_build() {
	[ -d mhwaveedit-$PACKAGE_VERSION ] && rm -rf mhwaveedit-$PACKAGE_VERSION
	tar -xjvf mhwaveedit-$PACKAGE_VERSION.tar.bz2
	cd mhwaveedit-$PACKAGE_VERSION

	patch -p1 < "$BASE_DIR/patches/mhwaveedit-musl.patch"
	CFLAGS="-D_POSIX_C_SOURCE=200809L $CFLAGS" \
	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-nls \
	            --disable-gtk2 \
	            --disable-ladspa \
	            --with-default-driver=alsa \
	            --with-default-mixerapp="aterm -e alsamixer" \
	            --without-libsndfile \
	            --without-libsamplerate \
	            --without-oss \
	            --without-jack \
	            --without-pulse \
	            --without-esound \
	            --without-sun \
	            --without-arts
	$MAKE
}

mhwaveedit_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/mhwaveedit/README"
	install -m 644 NEWS "$1/usr/share/doc/mhwaveedit/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/mhwaveedit/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/mhwaveedit/AUTHORS"
	install -m 644 copynotice "$1/usr/share/doc/mhwaveedit/copynotice"
	install -m 644 COPYING "$1/usr/share/doc/mhwaveedit/COPYING"
}
