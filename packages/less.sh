PACKAGE_VERSION="458"
PACKAGE_SOURCES="http://www.greenwoodsoftware.com/less/less-$PACKAGE_VERSION.tar.gz"

less_build() {
	[ -d less-$PACKAGE_VERSION ] && rm -rf less-$PACKAGE_VERSION
	tar -xzvf less-$PACKAGE_VERSION.tar.gz
	cd less-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --datarootdir=/usr/share \
	            --with-regex=re_comp \
	            --with-editor=/bin/vi
	make
}

less_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/less/README"
	install -D -m 644 NEWS "$1/usr/share/doc/less/NEWS"
	install -D -m 644 LICENSE "$1/usr/share/doc/less/LICENSE"
	install -D -m 644 COPYING "$1/usr/share/doc/less/COPYING"
}
