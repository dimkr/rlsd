PACKAGE_VERSION="2.6.32.63"
PACKAGE_SOURCES="http://linux-libre.fsfla.org/pub/linux-libre/releases/$PACKAGE_VERSION-gnu1/linux-libre-$PACKAGE_VERSION-gnu1.tar.xz"
PACKAGE_DESC="Kernel API headers"

build() {
	[ -d linux-$PACKAGE_VERSION ] && rm -rf linux-$PACKAGE_VERSION
	tar -xJvf linux-libre-$PACKAGE_VERSION-gnu1.tar.xz
	cd linux-$PACKAGE_VERSION
	$MAKE ARCH="$KARCH" clean
	$MAKE ARCH="$KARCH" mrproper
}

package() {
	ARCH="$KARCH" $MAKE INSTALL_HDR_PATH="$1" headers_install
	mkdir "$1/usr"
	mv "$1/include" "$1/usr/"
	find "$1/usr/include" -name .install -or -name ..install.cmd | xargs rm -f
	install -D -m 644 README "$1/usr/share/doc/linux_headers/README"
	install -m 644 COPYING "$1/usr/share/doc/linux_headers/COPYING"
	install -m 644 CREDITS "$1/usr/share/doc/linux_headers/CREDITS"
	install -m 644 MAINTAINERS "$1/usr/share/doc/linux_headers/MAINTAINERS"
}
