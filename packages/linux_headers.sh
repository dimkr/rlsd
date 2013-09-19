PACKAGE_VERSION="3.10.12"
PACKAGE_SOURCES="http://linux-libre.fsfla.org/pub/linux-libre/releases/3.10.12-gnu/linux-libre-$PACKAGE_VERSION-gnu.tar.xz"

linux_headers_build() {
	[ -d linux-$PACKAGE_VERSION ] && rm -rf linux-$PACKAGE_VERSION
	tar -xJvf linux-libre-$PACKAGE_VERSION-gnu.tar.xz
	cd linux-$PACKAGE_VERSION
	make clean
	make mrproper
}

linux_headers_package() {
	make INSTALL_HDR_PATH="$1" headers_install
	mkdir "$1/usr"
	mv "$1/include" "$1/usr/"
	find "$1/usr/include" -name .install -or -name ..install.cmd | xargs rm -f
}
