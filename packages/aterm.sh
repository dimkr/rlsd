PACKAGE_VERSION="1.0.1"
PACKAGE_SOURCES="ftp://ftp.afterstep.org/apps/aterm/aterm-1.0.1.tar.bz2"

aterm_build() {
	[ -d aterm-$PACKAGE_VERSION ] && rm -rf aterm-$PACKAGE_VERSION
	tar -xjvf aterm-$PACKAGE_VERSION.tar.bz2
	cd aterm-$PACKAGE_VERSION

	patch -p1 < "$BASE_DIR/patches/aterm-openpty.patch"
	patch -p1 < "$BASE_DIR/patches/aterm-font.patch"
	./configure --host=$HOST \
	            --prefix=/usr \
	            --bindir=/bin \
	            --disable-utmp \
	            --disable-wtmp \
	            --disable-memset
	make
}

aterm_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/aterm/README"
	install -D -m 644 NEWS "$1/usr/share/doc/aterm/NEWS"
	install -D -m 644 AUTHORS "$1/usr/share/doc/aterm/AUTHORS"
	install -D -m 644 COPYING "$1/usr/share/doc/aterm/COPYING"
}
