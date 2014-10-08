PACKAGE_VERSION="3.44.73"
COMMIT="3368929b5c44fd62e04219c6d2a5054b6b5e678f"
PACKAGE_SOURCES="https://github.com/wjaguar/mtPaint/archive/$COMMIT.zip,mtpaint-$PACKAGE_VERSION.zip"
PACKAGE_DESC="An image editor"

mtpaint_build() {
	[ -d mtPaint-$COMMIT ] && rm -rf mtPaint-$COMMIT
	unzip mtpaint-$PACKAGE_VERSION.zip
	cd mtPaint-$COMMIT

	patch -p1 < "$BASE_DIR/patches/mtpaint-gtk1.patch"
	patch -p1 < "$BASE_DIR/patches/mtpaint-giflib.patch"
	patch -p1 < "$BASE_DIR/patches/mtpaint-actions.patch"

	./configure --host=$HOST \
	            --prefix=/usr \
	            --bindir=/bin \
	            gtk1 \
	            gtkfilesel \
	            gtkcolsel \
	            thread \
	            cflags \
	            GIF \
	            jpeg \
	            tiff \
	            man
	$MAKE
}

mtpaint_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/mtpaint/README"
	install -m 644 NEWS "$1/usr/share/doc/mtpaint/NEWS"
	install -m 644 COPYING "$1/usr/share/doc/mtpaint/COPYING"
}
