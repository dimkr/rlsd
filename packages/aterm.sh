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
	$MAKE
}

aterm_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 ChangeLog "$1/usr/share/doc/aterm/ChangeLog"
	install -m 644 ChangeLog.0.4 "$1/usr/share/doc/aterm/ChangeLog.0.4"
}
