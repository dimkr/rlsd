PACKAGE_VERSION="2.7.1"
PACKAGE_SOURCES="http://ftp.gnu.org/gnu/patch/patch-$PACKAGE_VERSION.tar.xz"

patch_build() {
	[ -d patch-$PACKAGE_VERSION ] && rm -rf patch-$PACKAGE_VERSION
	tar -xJvf patch-$PACKAGE_VERSION.tar.xz
	cd patch-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share
	$MAKE
}

patch_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/patch/README"
	install -m 644 NEWS "$1/usr/share/doc/patch/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/patch/ChangeLog"
	install -m 644 ChangeLog-2011 "$1/usr/share/doc/patch/ChangeLog-2011"
	install -m 644 AUTHORS "$1/usr/share/doc/patch/AUTHORS"
	install -m 644 COPYING "$1/usr/share/doc/patch/COPYING"
}
