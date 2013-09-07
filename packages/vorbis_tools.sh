PACKAGE_VERSION="1.4.0"
PACKAGE_SOURCES="http://downloads.xiph.org/releases/vorbis/vorbis-tools-$PACKAGE_VERSION.tar.gz"

vorbis_tools_build() {
	[ -d vorbis-tools-$PACKAGE_VERSION ] && rm -rf vorbis-tools-$PACKAGE_VERSION
	tar -xzvf vorbis-tools-$PACKAGE_VERSION.tar.gz
	cd vorbis-tools-$PACKAGE_VERSION

	./configure --host=$HOST \
	            --prefix= \
	            --includedir=/usr/include \
	            --datarootdir=/usr/share \
	            --disable-nls \
	            --without-flac \
	            --without-speex \
	            --without-kate
	make
}

vorbis_tools_package() {
	make DESTDIR="$1" install
	install -D -m 644 README "$1/usr/share/doc/vorbis-tools/README"
	install -D -m 644 CHANGES "$1/usr/share/doc/vorbis-tools/CHANGES"
	install -D -m 644 AUTHORS "$1/usr/share/doc/vorbis-tools/AUTHORS"
	install -D -m 644 COPYING "$1/usr/share/doc/vorbis-tools/COPYING"
}
