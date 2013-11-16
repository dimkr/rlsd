PACKAGE_VERSION="1.10"
PACKAGE_SOURCES="http://ftp.gnome.org/pub/GNOME/sources/ttf-bitstream-vera/$PACKAGE_VERSION/ttf-bitstream-vera-$PACKAGE_VERSION.tar.gz"

ttf_bitstream_vera_build() {
	[ -d ttf-bitstream-vera-$PACKAGE_VERSION ] && rm -rf ttf-bitstream-vera-$PACKAGE_VERSION
	tar -xzvf ttf-bitstream-vera-$PACKAGE_VERSION.tar.gz
	cd ttf-bitstream-vera-$PACKAGE_VERSION
}

ttf_bitstream_vera_package() {
	mkdir -p "$1/usr/share/fonts/truetype"
	install -m 644 *.ttf "$1/usr/share/fonts/truetype/"
	install -D -m 644 README.TXT "$1/usr/share/doc/ttf-bitstream-vera/README"
	install -m 644 RELEASENOTES.TXT "$1/usr/share/doc/ttf-bitstream-vera/RELEASENOTES.TXT"
	install -m 644 COPYRIGHT.TXT "$1/usr/share/doc/ttf-bitstream-vera/COPYRIGHT.TXT"
}
