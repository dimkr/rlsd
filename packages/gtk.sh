PACKAGE_VERSION="1.2.10"
PACKAGE_SOURCES="http://ftp.gnome.org/pub/gnome/sources/gtk+/1.2/gtk+-$PACKAGE_VERSION.tar.gz https://projects.archlinux.org/svntogit/packages.git/plain/trunk/aclocal-fixes.patch?h=packages/gtk,gtk-aclocal-fixes.patch"

gtk_build() {
	[ -d gtk+-$PACKAGE_VERSION ] && rm -rf gtk+-$PACKAGE_VERSION
	tar -xzvf gtk+-$PACKAGE_VERSION.tar.gz
	cd gtk+-$PACKAGE_VERSION

	patch -p0 < ../gtk-aclocal-fixes.patch
	cp /usr/share/libtool/config/config.guess .
	cp /usr/share/libtool/config/config.sub .
	patch -p0 < "$BASE_DIR/patches/gtk+-1.2.10.diff"

	echo '#!/bin/sh
exec pkg-config "$@"' > glib-config
	chmod 755 glib-config
  	PATH="$(pwd):$PATH" \
	./configure --host=$HOST \
	            --target=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datadir=/usr/share \
	            $CONFIGURE_LIBRARY_FLAGS
	make
}

gtk_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/gtk/README"
	install -m 644 CHANGES "$1/usr/share/doc/gtk/CHANGES"
	install -m 644 COPYING "$1/usr/share/doc/gtk/COPYING"
}
