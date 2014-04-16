PACKAGE_VERSION="1.14"
PACKAGE_SOURCES="http://distro.ibiblio.org/slitaz/sources/packages-cooking/m/minised-$PACKAGE_VERSION.tar.gz"

minised_build() {
	[ -d minised-$PACKAGE_VERSION ] && rm -rf minised-$PACKAGE_VERSION
	tar -xzvf minised-$PACKAGE_VERSION.tar.gz
	cd minised-$PACKAGE_VERSION
	
	patch -p 1 < "$BASE_DIR/patches/minised-build.patch"
	$MAKE
}

minised_package() {
	$MAKE DESTDIR="$1" BINDIR="/bin" install
	ln -s minised "$1/bin/sed"
	install -D -m 644 README "$1/usr/share/doc/minised/README"
	install -m 644 LICENSE "$1/usr/share/doc/minised/LICENSE"
}
