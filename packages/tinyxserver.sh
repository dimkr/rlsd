PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/tinyxserver/archive/master.zip,tinyxserver-$PACKAGE_VERSION.zip"

tinyxserver_build() {
	[ -d tinyxserver-master ] && rm -rf tinyxserver-master
	unzip tinyxserver-$PACKAGE_VERSION.zip
	cd tinyxserver-master

	case "$HOST" in
		*64*)
			CFLAGS="-D_XSERVER64=1 $CFLAGS"
			;;
	esac

	make clean
	make CC="$CC" \
	     EXTRA_CFLAGS="$CFLAGS" \
	     LDFLAGS="$LDFLAGS" \
	     FONTDIRS="/usr/share/fonts/misc/,/usr/share/fonts/truetype/,/usr/share/fonts/100dpi/,/usr/share/fonts/75dpi/,/usr/share/fonts/cyrillic"
}

tinyxserver_package() {
	install -D -m 755 Xfbdev "$1/bin/Xfbdev"
	install -m 755 xinit "$1/bin/xinit"
	install -D -m 644 init/xinit.1 "$1/usr/share/man/man1/xinit.1"
	install -D -m 644 README "$1/usr/share/doc/tinyxserver/README"
	install -m 644 changelog "$1/usr/share/doc/tinyxserver/changelog"
	install -D -m 644 init/README "$1/usr/share/doc/xinit/README"
	install -m 644 init/README.upstream "$1/usr/share/doc/xinit/README.upstream"
	install -m 644 init/ChangeLog "$1/usr/share/doc/xinit/ChangeLog"
	install -m 644 init/AUTHORS "$1/usr/share/doc/xinit/AUTHORS"
	install -m 644 init/COPYING "$1/usr/share/doc/xinit/COPYING"
}
