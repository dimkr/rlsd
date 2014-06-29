PACKAGE_VERSION="2.6.32.63"
PACKAGE_SOURCES="http://linux-libre.fsfla.org/pub/linux-libre/releases/$PACKAGE_VERSION-gnu1/linux-libre-$PACKAGE_VERSION-gnu1.tar.xz"
PACKAGE_DESC="Kernel API headers"

linux_headers_build() {
	[ -d linux-$PACKAGE_VERSION ] && rm -rf linux-$PACKAGE_VERSION
	tar -xJvf linux-libre-$PACKAGE_VERSION-gnu1.tar.xz
	cd linux-$PACKAGE_VERSION
	$MAKE clean
	$MAKE mrproper
}

linux_headers_package() {
	$MAKE ARCH="$KARCH" INSTALL_HDR_PATH="$1" headers_install
	mkdir "$1/usr"
	mv "$1/include" "$1/usr/"
	find "$1/usr/include" -name .install -or -name ..install.cmd | xargs rm -f
}
