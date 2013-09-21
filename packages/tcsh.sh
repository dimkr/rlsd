PACKAGE_VERSION="6.18.01"
PACKAGE_SOURCES="ftp://ftp.astron.com/pub/tcsh/tcsh-$PACKAGE_VERSION.tar.gz"

tcsh_build() {
	[ -d tcsh-$PACKAGE_VERSION ] && rm -rf tcsh-$PACKAGE_VERSION
	tar -xzvf tcsh-$PACKAGE_VERSION.tar.gz
	cd tcsh-$PACKAGE_VERSION

	CFLAGS="-D__ANDROID__ $CFLAGS" \
	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-nls \
	            --disable-nls-catalogs
	make
}

tcsh_package() {
	install -D -m755 "$1/bin/tcsh"
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/tcsh/README"
	install -D -m 644 FAQ "$1/usr/share/doc/tcsh/FAQ"
	install -D -m 644 NewThings "$1/usr/share/doc/tcsh/NewThings"
	install -D -m 644 Fixes "$1/usr/share/doc/tcsh/Fixes"
	install -D -m 644 Copyright "$1/usr/share/doc/tcsh/Copyright"
}
