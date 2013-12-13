PACKAGE_VERSION="2.1.0"
PACKAGE_SOURCES="http://joewing.net/projects/jwm/releases/jwm-2.1.0.tar.bz2"

jwm_build() {
	[ -d jwm-$PACKAGE_VERSION ] && rm -rf jwm-$PACKAGE_VERSION
	tar -xjvf jwm-$PACKAGE_VERSION.tar.bz2
	cd jwm-$PACKAGE_VERSION

	sed s/courier/fixed/ -i src/font.c

	./configure --host=$HOST \
	            --prefix= \
	            --sysconfdir=/etc \
	            --datarootdir=/usr/share \
	            --enable-xft \
	            --disable-shape \
	            --disable-xmu \
	            --enable-xinerama
	$MAKE
}

jwm_package() {
	install -D -m 755 src/jwm "$1/bin/jwm"
	install -D -m 644 example.jwmrc "$1/etc/system.jwmrc"
	install -D -m 644 README "$1/usr/share/doc/jwm/README"
	install -m 644 LICENSE "$1/usr/share/doc/jwm/LICENSE"
}
