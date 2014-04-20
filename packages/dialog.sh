PACKAGE_VERSION="1.2-20140219"
PACKAGE_SOURCES="ftp://invisible-island.net/dialog/dialog-$PACKAGE_VERSION.tgz"

dialog_build() {
	[ -d dialog-$PACKAGE_VERSION ] && rm -rf dialog-$PACKAGE_VERSION
	tar -xzvf dialog-$PACKAGE_VERSION.tgz
	cd dialog-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-Xdialog \
	            --disable-Xdialog2 \
	            --disable-whiptail
	$MAKE
}

dialog_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/dialog/README"
	install -m 644 CHANGES "$1/usr/share/doc/dialog/CHANGES"
	install -m 644 COPYING "$1/usr/share/doc/dialog/COPYING"
}
