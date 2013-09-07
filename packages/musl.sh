PACKAGE_VERSION="0.9.13"
PACKAGE_SOURCES="http://www.musl-libc.org/releases/musl-$PACKAGE_VERSION.tar.gz"

musl_build() {
	[ -d musl-$PACKAGE_VERSION ] && rm -rf musl-$PACKAGE_VERSION
	tar -xzvf musl-$PACKAGE_VERSION.tar.gz
	cd musl-$PACKAGE_VERSION

	# define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP in pthread.h, to allow
	# alsa-lib to be built against musl
	sed s~'#define PTHREAD_MUTEX_INITIALIZER {{{0}}}'~'&\n#define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP {{{1,0,0,0,0,0,0,0,0,0}}}'~ \
	    -i include/pthread.h

	# define __compar_fn_t, a callback passed to bsearch() - this is a glibc
	# implementation detail, but some packages (i.e eudev) cast pointers to it
	sed s~'void \*bsearch'~'typedef int (*__compar_fn_t)(const void *, const void *);\nvoid *bsearch'~ \
	    -i include/stdlib.h

	./configure --prefix=$SYSROOT \
	            --includedir=$SYSROOT/usr/include \
	            --disable-debug \
	            --enable-gcc-wrapper \
	            --disable-shared \
	            --enable-static
	make
}

musl_package() {
	# TODO: figure out how to build the GCC wrapper without having an empty
	# installation directory
	make install

	install -D -m 644 README "$1/usr/share/doc/musl/README"
	install -D -m 644 WHATSNEW "$1/usr/share/doc/musl/WHATSNEW"
	install -D -m 644 COPYRIGHT "$1/usr/share/doc/musl/COPYRIGHT"
}
