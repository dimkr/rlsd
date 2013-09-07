PACKAGE_VERSION="0.5.7"
PACKAGE_SOURCES="http://gondor.apana.org.au/~herbert/dash/files/dash-$PACKAGE_VERSION.tar.gz"

dash_build() {
	[ -d dash-$PACKAGE_VERSION ] && rm -rf dash-$PACKAGE_VERSION
	tar -xzvf dash-$PACKAGE_VERSION.tar.gz
	cd dash-$PACKAGE_VERSION

	# building with "--enable-glob" fails against musl 0.9.12
	./configure --host=$HOST \
	            --prefix= \
	            --mandir=/usr/share/man \
	            --enable-fnmatch \
	            --disable-glob \
	            --without-libedit
	make
}

dash_package() {
	make DESTDIR="$1" install
	install -D -m 644 ChangeLog "$1/usr/share/doc/dash/ChangeLog"
	install -D -m 644 COPYING "$1/usr/share/doc/dash/COPYING"
}
