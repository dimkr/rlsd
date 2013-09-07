PACKAGE_VERSION="master"
PACKAGE_SOURCES="https://github.com/gentoo/eudev/archive/master.zip,eudev-master.zip"

eudev_build() {
	[ -d eudev-master ] && rm -rf eudev-master
	unzip master.zip
	cd eudev-master

	./autogen.sh
	CFLAGS="$CFLAGS -D_GNU_SOURCE -D_POSIX_SOURCE" \
	./configure --host=$HOST \
	            --prefix= \
	            --bindir=/bin \
	            --sbindir=/bin \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            --disable-shared \
	            --enable-static \
	            --disable-split-usr \
	            --enable-introspection=no \
	            --disable-gudev \
	            --disable-libkmod \
	            --disable-rule-generator
	make
}

eudev_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/eudev/README"
	install -D -m 644 COPYING "$1/usr/share/doc/eudev/COPYING"
}
