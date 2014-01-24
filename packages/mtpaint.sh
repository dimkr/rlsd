PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/wjaguar/mtPaint/archive/master.zip,mtpaint-$PACKAGE_VERSION.zip"

mtpaint_build() {
	[ -d mtPaint-master ] && rm -rf mtPaint-master
	unzip mtpaint-$PACKAGE_VERSION.zip
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
	            man
	$MAKE
}

mtpaint_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/mtpaint/README"
	install -m 644 NEWS "$1/usr/share/doc/mtpaint/NEWS"
	install -m 644 COPYING "$1/usr/share/doc/mtpaint/COPYING"
}
