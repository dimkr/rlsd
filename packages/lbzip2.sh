PACKAGE_VERSION="2.5"
PACKAGE_SOURCES="http://archive.lbzip2.org/lbzip2-$PACKAGE_VERSION.tar.gz"

lbzip2_build() {
	[ -d lbzip2-$PACKAGE_VERSION ] && rm -rf lbzip2-$PACKAGE_VERSION
	tar -xzvf lbzip2-$PACKAGE_VERSION.tar.gz
	cd lbzip2-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share
	$MAKE
}

lbzip2_package() {
	$MAKE DESTDIR="$1" install
	for i in "$1/bin"/*
	do
		name="$(basename "$i")"
		ln -s "$name" "$1/bin/$(echo "$name" | cut -c 2-)"
	done
	install -D -m 644 README "$1/usr/share/doc/lbzip2/README"
	install -m 644 NEWS "$1/usr/share/doc/lbzip2/NEWS"
	install -m 644 ChangeLog "$1/usr/share/doc/lbzip2/ChangeLog"
	install -m 644 ChangeLog.old "$1/usr/share/doc/lbzip2/ChangeLog.old"
	install -m 644 AUTHORS "$1/usr/share/doc/lbzip2/AUTHORS"
	install -m 644 THANKS "$1/usr/share/doc/lbzip2/THANKS"
	install -m 644 COPYING "$1/usr/share/doc/lbzip2/COPYING"
}
