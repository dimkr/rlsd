PACKAGE_VERSION="3.10.12"
PACKAGE_SOURCES="https://www.kernel.org/pub/linux/kernel/v3.x/linux-$PACKAGE_VERSION.tar.xz"

linux_headers_build() {
	[ -d linux-$PACKAGE_VERSION ] && rm -rf linux-$PACKAGE_VERSION
	tar -xJvf linux-$PACKAGE_VERSION.tar.xz
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
