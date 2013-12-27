PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/tinyalsa/tinyalsa/archive/master.zip,tinyalsa-$PACKAGE_VERSION.zip"

tinyalsa_build() {
	[ -d tinyalsa-master ] && rm -rf tinyalsa-master
	unzip tinyalsa-$PACKAGE_VERSION.zip
	cd tinyalsa-master

	patch -p 1 < "$BASE_DIR/patches/tinyalsa-build.patch"
	patch -p 1 < "$BASE_DIR/patches/tinyalsa-musl.patch"
	$MAKE
}

tinyalsa_package() {
	install -D -m 644 libtinyalsa.a "$1/lib/libtinyalsa.a"
	for i in tinycap tinymix tinypcminfo tinyplay
	do
		install -D -m 755 $i "$1/bin/$i"
	done
	install -D -m 644 README "$1/usr/share/doc/tinyalsa/README"
	head -n 26 mixer.c | tail -n 24 | cut -c 4- \
	                                       > "$1/usr/share/doc/tinyalsa/COPYING"
	chmod 644 "$1/usr/share/doc/tinyalsa/COPYING"
	cp -r include "$1/usr"
}