PACKAGE_VERSION="20131230"
PACKAGE_SOURCES="http://ircii.warped.com/ircii-$PACKAGE_VERSION.tar.bz2"

ircii_build() {
	[ -d ircii-$PACKAGE_VERSION ] && rm -rf ircii-$PACKAGE_VERSION
	tar -xjvf ircii-$PACKAGE_VERSION.tar.bz2
	cd ircii-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/ircii-xargs.patch"

	./configure --host=$HOST \
	            --prefix= \
	            --libexecdir=/lib/ircii \
	            --datadir=/usr/share \
	            --mandir=/usr/share/man \
	            --enable-ipv6
	$MAKE
}

ircii_package() {
	$MAKE DESTDIR="$1" install
	rm -f "$1/bin/irc"
	mv "$1/bin/irc-$PACKAGE_VERSION" "$1/bin/irc"
	install -D -m 644 README "$1/usr/share/doc/ircii/README"
	install -D -m 644 ChangeLog "$1/usr/share/doc/ircii/ChangeLog"
	install -D -m 644 doc/Copyright "$1/usr/share/doc/ircii/Copyright"
}
