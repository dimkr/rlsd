PACKAGE_VERSION="1.0.0"
PACKAGE_SOURCES="http://www.musl-libc.org/releases/musl-$PACKAGE_VERSION.tar.gz"

musl_build() {
	[ -d musl-$PACKAGE_VERSION ] && rm -rf musl-$PACKAGE_VERSION
	tar -xzvf musl-$PACKAGE_VERSION.tar.gz
	cd musl-$PACKAGE_VERSION

	./configure --prefix= \
	            --includedir=/usr/include \
	            --host=$HOST \
	            --disable-debug \
	            --enable-gcc-wrapper \
	            $CONFIGURE_LIBRARY_FLAGS
	$MAKE
}

musl_package() {
	$MAKE DESTDIR="$1" install

	# move the GCC wrapper out of the package
	mv "$1/bin/musl-gcc" "$BASE_DIR"
	rmdir "$1/bin"
	sed s~"/lib"~"$SYSROOT/lib"~ -i "$BASE_DIR/musl-gcc"

	install -D -m 644 README "$1/usr/share/doc/musl/README"
	install -D -m 644 WHATSNEW "$1/usr/share/doc/musl/WHATSNEW"
	install -D -m 644 COPYRIGHT "$1/usr/share/doc/musl/COPYRIGHT"
}
