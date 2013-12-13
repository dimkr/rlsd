PACKAGE_VERSION="1.0.2"
PACKAGE_SOURCES="http://downloads.sourceforge.net/project/htop/htop/$PACKAGE_VERSION/htop-$PACKAGE_VERSION.tar.gz"

htop_build() {
	[ -d htop-$PACKAGE_VERSION ] && rm -rf htop-$PACKAGE_VERSION
	tar -xzvf htop-$PACKAGE_VERSION.tar.gz
	cd htop-$PACKAGE_VERSION
	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --disable-openvz \
	            --disable-vserver \
	            --disable-ancient-vserver \
	            --disable-unicode
	$MAKE
}

htop_package() {
	$MAKE DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/htop/README"
	install -D -m 644 NEWS "$1/usr/share/doc/htop/NEWS"
	install -D -m 644 AUTHORS "$1/usr/share/doc/htop/AUTHORS"
	install -D -m 644 COPYING "$1/usr/share/doc/htop/COPYING"
}
