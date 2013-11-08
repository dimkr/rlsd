PACKAGE_VERSION="1.1.1"
PACKAGE_SOURCES="http://xorg.freedesktop.org/releases/individual/app/xinit-$PACKAGE_VERSION.tar.bz2"

xinit_build() {
	[ -d xinit-$PACKAGE_VERSION ] && rm -rf xinit-$PACKAGE_VERSION
	tar -xjvf xinit-$PACKAGE_VERSION.tar.bz2
	cd xinit-$PACKAGE_VERSION

	sed s~'XINITDIR = $(libdir)/X11/xinit'~'XINITDIR = $(libdir)'~ \
	    -i Makefile.in

	CFLAGS="-D_POSIX_SOURCE $CFLAGS" \
	./configure --host=$HOST \
	            --prefix= \
	            --libdir=/lib/xinit \
	            --datarootdir=/usr/share
	make
}

xinit_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/xinit/README"
	install -D -m 644 ChangeLog "$1/usr/share/doc/xinit/ChangeLog"
	install -D -m 644 AUTHORS "$1/usr/share/doc/xinit/AUTHORS"
	install -D -m 644 COPYING "$1/usr/share/doc/xinit/COPYING"
}
