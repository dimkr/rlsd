PACKAGE_VERSION="1.4.32"
PACKAGE_SOURCES="http://sourceforge.net/projects/msmtp/files/msmtp/$PACKAGE_VERSION/msmtp-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="An e-mail sending tool"

msmtp_build() {
	[ -d msmtp-$PACKAGE_VERSION ] && rm -rf msmtp-$PACKAGE_VERSION
	tar -xjvf msmtp-$PACKAGE_VERSION.tar.bz2
	cd msmtp-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-nls \
	            --with-ssl=openssl \
	            --without-libidn
	$MAKE
}

msmtp_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/msmtp/README"
	install -m 644 NEWS "$1/usr/share/doc/msmtp/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/msmtp/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/msmtp/AUTHORS"
	install -m 644 THANKS "$1/usr/share/doc/msmtp/THANKS"
	install -m 644 COPYING "$1/usr/share/doc/msmtp/COPYING"
}
