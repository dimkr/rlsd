PACKAGE_VERSION="git$(date +%d%m%Y)"
PACKAGE_SOURCES="https://github.com/dimkr/ted/archive/master.zip,ted-$PACKAGE_VERSION.zip"
PACKAGE_DESC="A word processor"

ted_build() {
	[ -d ted-master ] && rm -rf ted-master
	unzip ted-$PACKAGE_VERSION.zip
	cd ted-master

	patch -p 1 < "$BASE_DIR/patches/ted-build.patch"

	$MAKE CONFIGURE_OPTIONS="--host=$HOST --prefix= --datadir=/usr/share --with-GTK"
	$MAKE package
}

ted_package() {
	mkdir -p "$1/usr/share/ted"
	tar -xzvf tedPackage/Ted_*_Linux_${ARCH}.tar.gz -C "$1/usr/share/ted"
	mv "$1/usr/share/ted/bin" "$1/"
	install -D -m 644 tedPackage/Ted.png "$1/usr/share/pixmaps/Ted.png"
	install -D -m 644 README "$1/usr/share/doc/ted/README"
	install -m 644 gpl.txt "$1/usr/share/doc/ted/gpl.txt"
}
