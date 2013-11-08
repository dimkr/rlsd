PACKAGE_VERSION="master"
PACKAGE_SOURCES="https://github.com/iguleder/tinyxserver/archive/master.zip,tinyxserver-master.zip"

tinyxserver_build() {
	[ -d tinyxserver-master ] && rm -rf tinyxserver-master
	unzip tinyxserver-master.zip
	cd tinyxserver-master

	make CC="$CC" \
	     EXTRA_CFLAGS="$CFLAGS" \
	     LDFLAGS="$LDFLAGS" \
	     FONTDIRS="/usr/share/fonts/misc/,/usr/share/fonts/truetype/,/usr/share/fonts/X11/100dpi/,/usr/share/fonts/X11/75dpi/"
}

tinyxserver_package() {
	install -D -m 755 Xfbdev "$1/bin/Xfbdev"
	install -D -m 644 README "$1/usr/share/doc/tinyxserver/README"
	install -m 644 changelog "$1/usr/share/doc/tinyxserver/changelog"
}