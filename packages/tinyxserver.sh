PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/iguleder/tinyxserver/archive/master.zip,tinyxserver-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A display server"

tinyxserver_build() {
	[ -d tinyxserver-master ] && rm -rf tinyxserver-master
	unzip tinyxserver-$PACKAGE_VERSION.zip
	cd tinyxserver-master

	case "$HOST" in
		*64*)
			CFLAGS="-D_XSERVER64=1 $CFLAGS"
			;;
	esac

	$MAKE clean
	$MAKE CC="$CC" \
	      EXTRA_CFLAGS="$CFLAGS" \
	      LDFLAGS="$LDFLAGS" \
	      FONTDIR="/usr/share/fonts"
}

tinyxserver_package() {
	$MAKE DESTDIR="$1" BINDIR="/bin" install
}
