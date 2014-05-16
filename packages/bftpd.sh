PACKAGE_VERSION="4.2"
PACKAGE_SOURCES="http://sourceforge.net/projects/bftpd/files/bftpd/bftpd-$PACKAGE_VERSION/bftpd-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="An FTP server"

bftpd_build() {
	[ -d bftpd ] && rm -rf bftpd
	tar -xzvf bftpd-$PACKAGE_VERSION.tar.gz
	cd bftpd

	patch -p 1 < "$BASE_DIR/patches/bftpd-build.patch"
	./configure --host=$HOST \
	            --prefix=/ \
	            --sbindir=/bin \
	            --mandir=/usr/share/man \
	            --enable-libz
	$MAKE
}

bftpd_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/bftpd/README"
	install -m 644 CHANGELOG "$1/usr/share/doc/bftpd/CHANGELOG"
	install -m 644 COPYING "$1/usr/share/doc/bftpd/COPYING"
}
