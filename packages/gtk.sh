PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/gtk/archive/master.zip,gtk-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A graphical toolkit"

gtk_build() {
	[ -d gtk-master ] && rm -rf gtk-master
	unzip gtk-$PACKAGE_VERSION.zip
	cd gtk-master

	patch -p 1 < "$BASE_DIR/patches/gtk-font.patch"

	./configure --host=$HOST \
	            --target=$HOST \
	            --prefix= \
	            --datadir=/usr/share \
	            --includedir=/usr/include \
	            --infodir=/usr/share/info \
	            --mandir=/usr/share/man \
	            $CONFIGURE_LIBRARY_FLAGS \
	            --enable-debug=no \
	            --disable-nls \
	            --disable-glibtest
	$MAKE
}

gtk_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/gtk+/README"
	install -m 644 ChangeLog "$1/usr/share/doc/gtk+/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/gtk+/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/gtk+/COPYING"
}
