PACKAGE_VERSION="1.0.27.2"
PACKAGE_SOURCES="ftp://ftp.alsa-project.org/pub/utils/alsa-utils-$PACKAGE_VERSION.tar.bz2"

alsa_utils_build() {
	[ -d alsa-utils-$PACKAGE_VERSION ] && rm -rf alsa-utils-$PACKAGE_VERSION
	tar -xjvf alsa-utils-$PACKAGE_VERSION.tar.bz2
	cd alsa-utils-$PACKAGE_VERSION

	CFLAGS="-D_POSIX_C_SOURCE=200809L -D_GNU_SOURCE $CFLAGS" \
	./configure --host=$HOST \
	            --prefix= \
	            --sbindir=/bin \
	            --datarootdir=/usr/share \
	            --disable-nls \
	            --disable-alsatest \
	            --disable-alsaconf \
	            --disable-alsaloop \
	            --disable-xmlto \
	            --without-udev-rules-dir
	make
}

alsa_utils_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/alsa-utils/README"
	install -D -m 644 ChangeLog "$1/usr/share/doc/alsa-utils/ChangeLog"
	install -D -m 644 COPYING "$1/usr/share/doc/alsa-utils/COPYING"
}
