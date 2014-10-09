PACKAGE_VERSION="1.0.4"
PACKAGE_SOURCES="http://www.musl-libc.org/releases/musl-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A C library"

musl_build() {
	[ -d musl-$PACKAGE_VERSION ] && rm -rf musl-$PACKAGE_VERSION
	tar -xzvf musl-$PACKAGE_VERSION.tar.gz
	cd musl-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/musl-ld_preload.patch"
	patch -p 1 < "$BASE_DIR/patches/musl-getauxval.patch"
	patch -p 1 < "$BASE_DIR/patches/musl-build.patch"

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
	mv "$1/bin/musl-gcc" "$BASE_DIR/"
	mv "$1/lib/musl-gcc.specs" "$BASE_DIR/"
	rmdir "$1/bin"
	sed s~"/lib/musl-gcc.specs"~"$BASE_DIR/musl-gcc.specs"~ -i "$BASE_DIR/musl-gcc"
	sed -e s~"/lib"~"$SYSROOT/lib"~g \
	    -e s~"/usr/include"~"$SYSROOT/usr/include"~g \
	    -i "$BASE_DIR/musl-gcc.specs"

	install -D -m 644 README "$1/usr/share/doc/musl/README"
	install -D -m 644 WHATSNEW "$1/usr/share/doc/musl/WHATSNEW"
	install -D -m 644 COPYRIGHT "$1/usr/share/doc/musl/COPYRIGHT"
}
