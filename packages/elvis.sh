PACKAGE_VERSION="1.4"
PATCH_VERSION="23"
PACKAGE_SOURCES="http://ftp.de.debian.org/debian/pool/main/e/elvis-tiny/elvis-tiny_$PACKAGE_VERSION.orig.tar.gz http://ftp.de.debian.org/debian/pool/main/e/elvis-tiny/elvis-tiny_$PACKAGE_VERSION-$PATCH_VERSION.debian.tar.gz"
PACKAGE_DESC="A text editor"

elvis_build() {
	[ -d elvis-tiny-$PACKAGE_VERSION.orig ] && rm -rf elvis-tiny-$PACKAGE_VERSION.orig
	tar -xzvf elvis-tiny_$PACKAGE_VERSION.orig.tar.gz
	cd elvis-tiny-$PACKAGE_VERSION.orig
	tar -xzvf ../elvis-tiny_$PACKAGE_VERSION-$PATCH_VERSION.debian.tar.gz

	cat debian/patches/series | while read i
	do
		patch -p 1 < debian/patches/$i
	done

	patch -p 1 < "$BASE_DIR/patches/elvis-build.patch"

	$MAKE -f Makefile.mix
}

elvis_package() {
	install -D -m 755 elvis "$1/bin/elvis"
	ln -s elvis "$1/bin/vi"
	install -D -m 644 doc/elvis.man "$1/usr/share/man/man1/elvis.1"
	install -D -m 644 README "$1/usr/share/doc/elvis/README"
}
