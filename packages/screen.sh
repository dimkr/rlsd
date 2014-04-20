PACKAGE_VERSION="4.2.0"
PACKAGE_SOURCES="http://mirror.rackdc.com/savannah//screen/screen-$PACKAGE_VERSION.tar.gz"

screen_build() {
	[ -d screen-$PACKAGE_VERSION ] && rm -rf screen-$PACKAGE_VERSION
	tar -xzvf screen-$PACKAGE_VERSION.tar.gz
	cd screen-$PACKAGE_VERSION

	./autogen.sh
	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-socket-dir \
	            --disable-pam \
	            --disable-locale \
	            --disable-telnet \
	            --disable-colors256 \
	            --disable-rxvt_osc \
	            --with-sys-screenrc=/etc/screenrc
	$MAKE
}

screen_package() {
	$MAKE DESTDIR="$1" install
	rm -f "$1/bin/screen"
	mv "$1/bin/screen-$PACKAGE_VERSION" "$1/bin/screen"
	install -D -m 644 README "$1/usr/share/doc/screen/README"
	install -D -m 644 NEWS "$1/usr/share/doc/screen/NEWS"
	install -D -m 644 ChangeLog "$1/usr/share/doc/screen/ChangeLog"
	install -D -m 644 COPYING "$1/usr/share/doc/screen/COPYING"
}
