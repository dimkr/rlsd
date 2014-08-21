PACKAGE_VERSION="4.2.1"
PACKAGE_SOURCES="http://ftp.gnu.org/gnu/screen/screen-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A terminal multiplexer"

screen_build() {
	[ -d screen-$PACKAGE_VERSION ] && rm -rf screen-$PACKAGE_VERSION
	tar -xzvf screen-$PACKAGE_VERSION.tar.gz
	cd screen-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datadir=/usr/share \
	            --infodir=/usr/share/info \
	            --mandir=/usr/share/man \
	            --disable-socket-dir \
	            --disable-pam \
	            --disable-use-locale \
	            --disable-telnet \
	            --disable-colors256 \
	            --disable-rxvt_osc \
	            --with-sys-screenrc=/etc/screenrc
	$MAKE
}

screen_package() {
	mkdir -p "$1/bin"
	$MAKE DESTDIR="$1" install
	rm -f "$1/bin/screen"
	mv "$1/bin/screen-$PACKAGE_VERSION" "$1/bin/screen"
	install -D -m 644 README "$1/usr/share/doc/screen/README"
	install -m 644 NEWS "$1/usr/share/doc/screen/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/screen/ChangeLog"
	install -m 644 COPYING "$1/usr/share/doc/screen/COPYING"
}
