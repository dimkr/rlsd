PACKAGE_VERSION="0.5.4"
PACKAGE_SOURCES="http://prdownloads.sourceforge.net/materm/mrxvt-$PACKAGE_VERSION.tar.gz"

mrxvt_build() {
	[ -d mrxvt-$PACKAGE_VERSION ] && rm -rf mrxvt-$PACKAGE_VERSION
	tar -xzvf mrxvt-$PACKAGE_VERSION.tar.gz
	cd mrxvt-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-rxvt-scroll \
	            --enable-next-scroll \
	            --disable-xterm-scroll \
	            --disable-plain-scroll \
	            --disable-sgi-scroll \
	            --disable-utmp \
	            --disable-wtmp \
	            --disable-lastlog \
	            --disable-xrender \
	            --disable-jpeg \
	            --enable-xft
	$MAKE
}

mrxvt_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/mrxvt/README"
	install -m 644 NEWS "$1/usr/share/doc/mrxvt/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/mrxvt/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/mrxvt/AUTHORS"
	install -m 644 CREDITS "$1/usr/share/doc/mrxvt/CREDITS"
	install -m 644 COPYING "$1/usr/share/doc/mrxvt/COPYING"
}
