PACKAGE_VERSION="2014.65"
PACKAGE_SOURCES="https://matt.ucc.asn.au/dropbear/releases/dropbear-$PACKAGE_VERSION.tar.bz2"
PACKAGE_DESC="A SSH server and client"

PROGRAMS="dropbear dbclient dropbearkey scp"

dropbear_build() {
	[ -d dropbear-$PACKAGE_VERSION ] && rm -rf dropbear-$PACKAGE_VERSION
	tar -xjvf dropbear-$PACKAGE_VERSION.tar.bz2
	cd dropbear-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/dropbear-options.patch"
	patch -p 1 < "$BASE_DIR/patches/dropbear-links.patch"
	./configure --host=$HOST \
	            --prefix= \
	            --sbindir=/bin \
	            --datarootdir=/usr/share \
	            --enable-zlib \
	            --disable-pam \
	            --disable-lastlog
	$MAKE PROGRAMS="$PROGRAMS" MULTI=1
}

dropbear_package() {
	$MAKE DESTDIR="$1" PROGRAMS="$PROGRAMS" MULTI=1 install
	ln -s dropbearmulti "$1/bin/ssh"
	install -d -m 644 "$1/etc/dropbear"
	install -D -m 644 README "$1/usr/share/doc/dropbear/README"
	install -m 644 CHANGES "$1/usr/share/doc/dropbear/CHANGES"
	install -m 644 LICENSE "$1/usr/share/doc/dropbear/LICENSE"
}
