PACKAGE_VERSION="1.3"
PACKAGE_SOURCES="http://distro.ibiblio.org/amigolinux/download/AmigoProjects/GtkDialog1/GtkDialog1-$PACKAGE_VERSION.tar.bz2"

gtkdialog1_build() {
	[ -d GtkDialog1-$PACKAGE_VERSION ] && rm -rf GtkDialog1-$PACKAGE_VERSION
	tar -xjvf GtkDialog1-$PACKAGE_VERSION.tar.bz2
	cd GtkDialog1-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/gtkdialog1-x86_64.patch"

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --with-gtk=1.2
	$MAKE
}

gtkdialog1_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/GtkDialog1/README"
	install -m 644 NEWS "$1/usr/share/doc/GtkDialog1/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/GtkDialog1/ChangeLog"
	install -m 644 AUTHORS "$1/usr/share/doc/GtkDialog1/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/GtkDialog1/COPYING"
}
