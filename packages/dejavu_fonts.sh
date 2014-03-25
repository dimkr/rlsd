PACKAGE_VERSION="2.34"
PACKAGE_SOURCES="http://downloads.sourceforge.net/project/dejavu/dejavu/$PACKAGE_VERSION/dejavu-fonts-$PACKAGE_VERSION.tar.bz2 http://downloads.sourceforge.net/project/dejavu/dejavu/$PACKAGE_VERSION/dejavu-fonts-ttf-$PACKAGE_VERSION.tar.bz2 http://www.unicode.org/Public/UNIDATA/UnicodeData.txt,dejavu_fonts-UnicodeData.txt http://www.unicode.org/Public/UNIDATA/Blocks.txt,dejavu_fonts-Blocks.txt http://www.freedesktop.org/software/fontconfig/release/fontconfig-2.11.1.tar.bz2"

dejavu_fonts_build() {
	[ -d fontconfig-2.11.1 ] && rm -rf fontconfig-2.11.1
	tar -xjvf fontconfig-2.11.1.tar.bz2

	[ -d dejavu-fonts-ttf-$PACKAGE_VERSION ] && rm -rf dejavu-fonts-ttf-$PACKAGE_VERSION
	tar -xjvf dejavu-fonts-ttf-$PACKAGE_VERSION.tar.bz2

	[ -d dejavu-fonts-$PACKAGE_VERSION ] && rm -rf dejavu-fonts-$PACKAGE_VERSION
	tar -xjvf dejavu-fonts-$PACKAGE_VERSION.tar.bz2
	cd dejavu-fonts-$PACKAGE_VERSION

	mkdir resources
	ln -s ../../dejavu_fonts-UnicodeData.txt resources/UnicodeData.txt
	ln -s ../../dejavu_fonts-Blocks.txt resources/Blocks.txt
	ln -s ../../fontconfig-2.11.1/fc-lang resources/
	patch -p 1 < "$BASE_DIR/patches/dejavu-fonts-lgc_no_rename.patch"

	$MAKE lgc
}

dejavu_fonts_package() {
	# install the fonts
	cd build
	for i in *.ttf
	do
		install -D -m 644 $i "$1/usr/share/fonts/truetype/$i"
	done
	cd ..

	# install the Fontconfig configuration files
	install -d -m 755 "$1/etc/fonts/conf.d/"
	cd ../dejavu-fonts-ttf-$PACKAGE_VERSION/fontconfig
	for i in *
	do
		install -D -m 644 $i "$1/etc/fonts/conf.avail/$i"
		ln -s ../conf.avail/$i "$1/etc/fonts/conf.d/"
	done
	cd ../../dejavu-fonts-$PACKAGE_VERSION

	install -D -m 644 README "$1/usr/share/doc/dejavu-fonts/README"
	install -m 644 NEWS "$1/usr/share/doc/dejavu-fonts/NEWS"
	install -m 644 AUTHORS "$1/usr/share/doc/dejavu-fonts/AUTHORS"
	install -m 644 LICENSE "$1/usr/share/doc/dejavu-fonts/LICENSE"
}
