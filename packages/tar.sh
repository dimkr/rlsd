PACKAGE_VERSION="1.27.1"
PACKAGE_SOURCES="http://ftp.gnu.org/gnu/tar/tar-$PACKAGE_VERSION.tar.xz"

tar_build() {
	[ -d tar-$PACKAGE_VERSION ] && rm -rf tar-$PACKAGE_VERSION
	tar -xJvf tar-$PACKAGE_VERSION.tar.xz
	cd tar-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix=/ \
	            --libexecdir=/lib/tar \
	            --datarootdir=/usr/share \
	            --without-included-regex \
	            --disable-nls
	make
}

tar_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/tar/README"
	install -m 644 ChangeLog "$1/usr/share/doc/tar/ChangeLog"
	install -m 644 NEWS "$1/usr/share/doc/tar/NEWS"
	install -m 644 AUTHORS "$1/usr/share/doc/tar/AUTHORS"
	install -m 644 THANKS "$1/usr/share/doc/tar/THANKS"
	install -m 644 COPYING "$1/usr/share/doc/tar/COPYING"
}
