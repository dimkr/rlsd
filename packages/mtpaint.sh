PACKAGE_VERSION="master"
PACKAGE_SOURCES="https://github.com/wjaguar/mtPaint/archive/master.zip,mtpaint-master.zip"

mtpaint_build() {
	[ -d mtPaint-master ] && rm -rf mtPaint-master
	unzip mtpaint-master.zip
	cd mtPaint-master

	patch -p1 < "$BASE_DIR/patches/mtpaint-gtk1.patch"

	./configure --host=$HOST \
	            --prefix=/usr \
	            --bindir=/bin \
	            gtk1 \
	            gtkfilesel \
	            gtkcolsel \
	            thread \
	            cflags \
	            jpeg \
	            man
	make
}

mtpaint_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/mtpaint/README"
	install -m 644 NEWS "$1/usr/share/doc/mtpaint/NEWS"
	install -m 644 COPYING "$1/usr/share/doc/mtpaint/COPYING"
}
